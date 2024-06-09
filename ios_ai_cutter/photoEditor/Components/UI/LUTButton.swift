//
//  LUTButton.swift
//  colorful-room
//
//  Created by macOS on 7/14/20.
//  Copyright © 2020 PingAK9. All rights reserved.
//

import SwiftUI
import PixelEnginePackage

struct LUTButton: View {
    
    var cube:PreviewFilterColorCube
    @AppStorage("language") private var language = LocalizationService.shared.language

    @EnvironmentObject var shared:PECtl
    
    var body: some View {
        let on = shared.lutsCtrl.currentCube == cube.filter.identifier
        
        return Button(action:{
            if(on){
                //print("EditAmong()")
                self.editAmong()
            }else{
                //print("valueChanged()")
                self.valueChanged()
            }
        }){
            VStack(spacing: 0){
                Image(uiImage: UIImage(cgImage: cube.cgImage))
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 68, height: 68)
                    .clipped()
                Text(cube.filter.name)
                    .font(.custom(FontsManager.Poppins.medium, size: 13))
                    .minimumScaleFactor(0.5)
                    .frame(width: 68, height: 20)
                    .background(on ? Color.myPrimary : Color.myButtonDark.opacity(0.5))
                    .foregroundColor(.white)
                
            }
            .frame(width: 68)
        }
    }
    
    func valueChanged() {
        shared.lutsCtrl.currentCube = cube.filter.identifier
        shared.didReceive(action: PECtlAction.applyFilter({ $0.colorCube = self.cube.filter }))
    }
    func editAmong(){
        self.shared.lutsCtrl.onSetEditingMode(true)
    }
}

struct NeutralButton: View {
    
    @AppStorage("language") private var language = LocalizationService.shared.language

    var image: UIImage
    @EnvironmentObject var shared:PECtl
    
    var body: some View {
        let on = shared.lutsCtrl.currentCube.isEmpty
        
        return Button(action:valueChanged){
            VStack(spacing: 0){
                Image(uiImage: image)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 68, height: 68)
                    .clipped()
                
                Text("Original".localized(LocalizationService.shared.language))
                    .font(.custom(FontsManager.Poppins.medium, size: 13))
                    .frame(width: 68, height: 20)
                    .background(on ? Color.myPrimary : Color.myButtonDark.opacity(0.5))
                    .foregroundColor(.white)
            }
        }
    }
    
    func valueChanged() {
        shared.lutsCtrl.selectCube("")
        shared.didReceive(action: PECtlAction.applyFilter({ $0.colorCube = nil }))
    }
}


struct LutLoadingButton: View {
    
    var name:String
    var on:Bool
    @AppStorage("language") private var language = LocalizationService.shared.language

    
    var body: some View {
        return VStack(spacing: 0){
            Rectangle()
                .fill(Color.myGrayDark).opacity(0.4)
                .frame(width: 68, height: 68)
                .overlay(
                    Image(systemName: "photo.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                )
            
            Text(name)
                .font(.custom(FontsManager.Poppins.medium, size: 13))
                .minimumScaleFactor(0.5)
                .frame(width: 68, height: 20)
                .background(on ? Color.myPrimary : Color.myButtonDark.opacity(0.5))
                .foregroundColor(.white)
        }
    }
}
