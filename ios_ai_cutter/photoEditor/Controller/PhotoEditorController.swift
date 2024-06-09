
import Foundation
import Combine
import SwiftUI
import PixelEnginePackage
import QCropper

class PECtl : ObservableObject{
    
    
    static var shared = PECtl()
    @AppStorage("isCircular") var isCircular = false

    init() {
        print("init PECtl")
    }
    
    // origin image: pick from gallery or camera
    var originImage:UIImage?
    
    // cache origin: conver from UI to CI
    var originCI:CIImage!
    
    // Image preview: will update after edited
    @Published
    var previewImage:UIImage!
    
    // crop controller
    var cropperCtrl:CropperController = CropperController()
    // luts controller
    @NestedObservableObject
    var lutsCtrl:LutsController = LutsController()
    
    var editState: EditingStack!
    var initialEditState: EditingStack!
    
    var currentEditMenu:EditMenu{
        get{
            return currentFilter.edit
        }
    }
    
    //
    @Published
    var currentFilter:FilterModel = FilterModel.noneFilterModel
    
    // makeRenderer fonksiyonları background ekliyor png'ye
    func updatePreview() {
        DispatchQueue.main.async {
            self.didReceive(action: .commit)
            if let cropperState = self.cropperCtrl.state {
                print("cropperState mevcut --> previewImage = originImage ")
                let originRender = self.originImage!.cropped(withCropperState: cropperState)
                let source = StaticImageSource(source: convertUItoCI(from: originRender!))
                
                self.previewImage = self.editState.makeCustomRenderer(source: source)
                    .render(resolution: .full)
                
                if self.isCircular {
                    // Dairesel maskeyi uygula
                    let circularImage = self.circularImage(from: self.previewImage)
                    self.previewImage = circularImage
                }
                
            } else {
                print("cropperState yok")
                self.previewImage = self.editState.makeRenderer().render(resolution: .full)
            }
            //let source = StaticImageSource(source: convertUItoCI(from: PhotoEditorData.shared.neutralLUT))
        }
    }
    
    func updatePreviewOnCropperDidConfirm() {
        
        DispatchQueue.main.async {
            
            //self.didReceive(action: .commit)

            if let cropperState = self.cropperCtrl.state {
                print("cropperState mevcut --> previewImage = originImage ")
                
                // editState sıfırlama, filtreler vs temizlendi
                self.initialEditState = EditingStack.init(
                     source: StaticImageSource(source: self.originCI!),
                     previewSize: CGSize(width: 512, height: 512 * self.previewImage.size.width / self.previewImage.size.height)
                 )
                if let cgimg = sharedContext.createCGImage(self.initialEditState.previewImage!, from: self.initialEditState.previewImage!.extent) {
                    self.originImage = UIImage(cgImage: cgimg)
                }
                
                // croperState'i ekleme
                let originRender = self.originImage!.cropped(withCropperState: cropperState)
                let source = StaticImageSource(source: convertUItoCI(from: originRender!))
                
                // OriginImage zaten filtreli üzerine olan state ile bir daha filtre atıyor
                // OriginImage filtre statei 0 olmalı yani yeniden yaratılıp kullanılmalı
                // crop state aynı, filtre state sıfırlanmış halde yarat
                self.previewImage = self.editState.makeCustomRenderer(source: source)
                    .render(resolution: .full)
   
                if self.isCircular {
                    // Dairesel maskeyi uygula
                    let circularImage = self.circularImage(from: self.previewImage)
                    self.previewImage = circularImage
                }
                
            } else {
                print("cropperState yok")
                self.previewImage = self.editState.makeRenderer().render(resolution: .full)
            }
        }
    }
    
    // Yardımcı fonksiyon: Dairesel bir resim oluştur
    func circularImage(from image: UIImage) -> UIImage {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: 512, height: 512)

        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        context.addEllipse(in: CGRect(x: 0, y: 0, width: imageView.bounds.size.width, height: imageView.bounds.size.height))
        context.clip()

        imageView.layer.render(in: context)

        guard let circularImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        return circularImage
    }
    
    // previewImage'a seçilen image'ı atar
    func setImage(image:UIImage) {
        
        /// resetUI
        if(lutsCtrl.loadingLut == true){
            return
        }
        currentFilter = FilterModel.noneFilterModel
        
        // self.originImage = image
        self.previewImage = image
        
        self.originCI = convertUItoCI(from: image)
        
        self.editState = EditingStack.init(
            source: StaticImageSource(source: self.originCI!),
            // todo: need more code to caculator adjust with scale image
            previewSize: CGSize(width: 512, height: 512 * self.previewImage.size.width / self.previewImage.size.height)
            // previewSize: CGSize(width: self.originUI.size.width, height: self.originUI.size.height)
        )
        
        if let smallImage = resizedImage(at: originCI, scale: 128 / self.previewImage.size.height, aspectRatio: 1){
            lutsCtrl.setImage(image: smallImage)
        }
        
        cropperCtrl = CropperController()
        
        DispatchQueue.global(qos: .background).async{
            self.apply()
        }
    }
    
    func didReceive(action: PECtlAction) {
        switch action {
            
        case .setFilter(let closure):
            setFilterDelay(filters: closure)
            
        case .commit:
            editState?.commit()
            
        case .applyFilter(let closure):
            self.editState.set(filters: closure)
            self.editState.commit()
            self.apply()
            print("apply() -> .applyFilter")
            
            
        case .undo:
            if(editState?.canUndo == true){
                self.editState.undo()
                let name = self.editState.currentEdit.filters.colorCube?.identifier ?? ""
                self.lutsCtrl.selectCube(name)
                self.apply()
                print("apply() -> .undo")
            }
            
        case .revert:
            self.editState.revert()
            self.apply()
            print("apply() -> .revert")
        }
    }
    
    var count:Int  = 0
    func setFilterDelay(filters: (inout EditingStack.Edit.Filters) -> Void) {
        //        currentRecipe = nil
        self.count = self.count + 1
        let currentCount = self.count
        self.editState.set(filters: filters)
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.3, execute: {
            // escaping closure captures non-escaping parameter
            if (self.count == currentCount){
                self.count  = 0
                self.apply()
                print("apply() -> .setFilterDelay -> count == currentCount ")
            }else if (currentCount % 20 == 0){
                self.apply()
                print("apply() -> .setFilterDelay -> currentCount % 20 ")
            }
        })
    }
    
    // Change previewImage
    func apply() {
        
        guard let preview:CIImage = self.editState.previewImage else{
            return
        }
        
        DispatchQueue.main.async {
            if let cgimg = sharedContext.createCGImage(preview, from: preview.extent) {
                if self.originImage == nil {
                    print("apply -> originImage == nil")
                    self.previewImage = UIImage(cgImage: cgimg)
                } else {
                    print("apply -> crop işleminden sonra")
                    self.updatePreview()
                }
            }
        }
    }
    
}


