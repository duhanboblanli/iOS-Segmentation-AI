//
//  Export.swift
//  colorful-room
//
//  Created by Ping9 on 16/01/2022.
//

import Foundation
import Combine
import SwiftUI
import PixelEnginePackage
import QCropper
//import CoreData

class ExportController : ObservableObject{
    
    // Export
    @Published var originExport:UIImage?
    
    var originRatio: Double {
        get{
            PECtl.shared.previewImage.size.width/PECtl.shared.previewImage.size.height;
        }
    }
    
    var controller: PECtl {
        get {
            PECtl.shared
        }
    }
    
    func prepareExport() {
        if(originExport == nil){
            controller.didReceive(action: .commit)
            DispatchQueue.main.async {
                if let cropperState = self.controller.cropperCtrl.state{
                    let originRender = self.controller.previewImage.cropped(withCropperState: cropperState)
                    let source = StaticImageSource(source: convertUItoCI(from: originRender!))
                    self.originExport =  self.controller.editState.makeCustomRenderer(source: source)
                        .render(resolution: .full)
                    // ADD
                    PECtl.shared.previewImage = self.originExport

                }else{
                    self.originExport = self.controller.editState.makeRenderer().render(resolution: .full)
                    // ADD
                    PECtl.shared.previewImage = self.originExport
                }
                let source = StaticImageSource(source: convertUItoCI(from: PhotoEditorData.shared.neutralLUT))
            }
        }
    }
    
    /*func updatePreview() {
        
            controller.didReceive(action: .commit)
        
            DispatchQueue.main.async {
                if let cropperState = self.controller.cropperCtrl.state {
                    let originRender = self.controller.previewImage.cropped(withCropperState: cropperState)
                    let source = StaticImageSource(source: convertUItoCI(from: originRender!))
                    PECtl.shared.previewImage =  self.controller.editState.makeCustomRenderer(source: source)
                        .render(resolution: .full)
                } else{
                    PECtl.shared.previewImage = self.controller.editState.makeRenderer().render(resolution: .full)
                }
                let source = StaticImageSource(source: convertUItoCI(from: PhotoEditorData.shared.neutralLUT))
            }
    } */
    
    func resetExport() {
        originExport = nil
    }
    
    func exportOrigin() {
        if let origin = originExport {
            ImageSaver().writeToPhotoAlbum(image: origin)
        }
        return
    }
   
}
