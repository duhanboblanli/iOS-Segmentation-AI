//
//  LutMenuUI.swift
//  colorful-room
//
//  Created by macOS on 7/14/20.
//  Copyright © 2020 PingAK9. All rights reserved.
//

import SwiftUI

// Filter small image buttons
struct LutMenuUI: View {
    @AppStorage("language") private var language = LocalizationService.shared.language

    @EnvironmentObject var shared:PECtl
    
    var body: some View {
        ZStack{
            Color("editBackground")
            ScrollViewReader{ reader in
                VStack{
                    Spacer()
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        if(shared.lutsCtrl.showLoading){
                            LutMenuUILoading()
                        }else{
                            HStack(spacing: 12){
                                Spacer().frame(width: 0)
                                // neutral
                                NeutralButton(image: UIImage(cgImage: shared.lutsCtrl.cubeSourceCG!)).id("neutral")
                                // cube by collections
                                ForEach(shared.lutsCtrl.collections, id: \.identifier) { collection in
                                    HStack(spacing: 12){
                                        if(collection.cubePreviews.isEmpty == false){
                                            Rectangle()
                                                .fill(Color.myDivider)
                                                .frame(width: 1, height: 92)
                                        }
                                        ForEach(collection.cubePreviews, id: \.filter.identifier) { cube in
                                            LUTButton(cube: cube)
                                        }
                                    }.id("\(collection.identifier)-cube")
                                }
                                Spacer().frame(width: 0)
                            }
                        }
                    }
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 16){
                            Spacer().frame(width: 0)
                        
                            collectionButtonView(key: "", name: "All Luts".localized(LocalizationService.shared.language), reader:reader)
                            //
                            ForEach(shared.lutsCtrl.collections, id: \.identifier) { collection in
                                collectionButtonView(key: collection.identifier, name: collection.name,reader:reader)
                            }
                            Spacer().frame(width: 0)
                        }
                    }.padding(.bottom, 8)
                }
                
            } // ScrollViewReader
            if(self.shared.lutsCtrl.editingLut){
                LutMenuUIEdit()
            }
        }
    }
    
    @ViewBuilder
    func collectionButtonView(key:String, name: String, reader:ScrollViewProxy) -> some View {
        Button(action:{
            withAnimation{
                if(key.isEmpty){
                    reader.scrollTo("neutral")
                }else{
                    reader.scrollTo("\(key)-cube", anchor: .leading)
                }
            }
        }){
            // En alt filtre albüm seçimi textleri
            // All Luts - Film
            CollectionButton(name: name)
        }
    }
}


///
struct LutMenuUILoading: View{
    @AppStorage("language") private var language = LocalizationService.shared.language

    var body: some View{
        HStack(spacing: 12){
            Spacer().frame(width: 0)
            LutLoadingButton(name: "Original".localized(LocalizationService.shared.language), on: true)
            Rectangle()
                .fill(Color.myDivider)
                .frame(width: 1, height: 92)
            LutLoadingButton(name: "Lut1".localized(LocalizationService.shared.language), on: false)
            LutLoadingButton(name: "Lut2".localized(LocalizationService.shared.language), on: false)
            LutLoadingButton(name: "Lut3".localized(LocalizationService.shared.language), on: false)
            Spacer().frame(width: 0)
        }
    }
}

// Filtre ayarı kısmı
struct LutMenuUIEdit: View{
    @AppStorage("language") private var language = LocalizationService.shared.language

    @EnvironmentObject var shared:PECtl
    
    var body: some View{
        VStack{
            Spacer()
            
            //Slider
            ColorCubeControl()
                .padding()
            Spacer()
            HStack{
                
                /*
                // Cancel button
                Button(action: {
                    print("PECtlAction.revert")
                    self.shared.didReceive(action: PECtlAction.revert)
                    self.shared.lutsCtrl.onSetEditingMode(false)
                }){
                    Image(systemName: "xmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color("butonTitleColor"))
                }
                 */
                
                
                // Cancel button
                Button(action: {
                    Task {
                        print("PECtlAction.revert")
                        self.shared.didReceive(action: PECtlAction.revert)
                        self.shared.lutsCtrl.onSetEditingMode(false)
                    }
                    
                }){
                    Text("CANCEL".localized(LocalizationService.shared.language))
                        .font(.custom(FontsManager.Poppins.semi_bold, size: 20))
                        .foregroundColor(Color("butonTitleColor"))
                        .minimumScaleFactor(0.4)
                }
                .frame(width: 70, height: 22)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(
                            Color.myGray,
                            lineWidth: 2
                        )
                )
                .frame(height: 64)
                
                Spacer()
                
                // Filter Name Text
                Text(self.shared.editState.currentEdit.filters.colorCube?.name ?? "Lut")
                    .font(.custom(FontsManager.Poppins.semi_bold, size: 15))
                    .foregroundColor(Color("butonTitleColor"))
                Spacer()
                
                
                /*
                // Done(checkmark) Button
                Button(action: {
                    print("PECtlAction.commit")
                    self.shared.didReceive(action: PECtlAction.commit)
                    self.shared.lutsCtrl.onSetEditingMode(false)
                }){
                    Image(systemName: "checkmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color("butonTitleColor"))
                }
                 */
                
                
                
                // Done(checkmark) Button
                Button(action: {
                    Task {
                        print("PECtlAction.commit")
                        self.shared.didReceive(action: PECtlAction.commit)
                        self.shared.lutsCtrl.onSetEditingMode(false)
                    }
                    
                }){
                    Text("DONE".localized(LocalizationService.shared.language))
                        .font(.custom(FontsManager.Poppins.semi_bold, size: 20))
                        .foregroundColor(Color("butonTitleColor"))
                        .minimumScaleFactor(0.4)
                }
                .frame(width: 73, height: 22)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(
                            SamColors.tapToAICutGradient,
                            lineWidth: 2
                        )
                )
                .frame(height: 64)
                
                
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        //Filtera tıklanınca gelen filter derecesi background
        .background(Color("editBackground"))
    }
}
