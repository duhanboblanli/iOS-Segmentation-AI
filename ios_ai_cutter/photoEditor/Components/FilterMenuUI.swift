//
//  FilterMenuView.swift
//  colorful-room
//
//  Created by macOS on 7/14/20.
//  Copyright © 2020 PingAK9. All rights reserved.
//

import SwiftUI

struct FilterMenuUI: View {
    
    @AppStorage("language") private var language = LocalizationService.shared.language

    @EnvironmentObject var shared:PECtl
    var index:EditMenu {
        get {
            return shared.currentEditMenu
        }
    }
    
    var body: some View {
        ZStack{
            Color("editBackground")
            if shared.currentFilter.edit == .none {
                VStack{
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 16){
                            Spacer().frame(width: 0)
                            ForEach(Constants.supportFilters, id: \.name) { filter in
                                ButtonView(action: filter)
                            }
                            Spacer().frame(width: 0)
                        }
                    }
                    Spacer()
                    
                    Text("Edit Color".localized(LocalizationService.shared.language)
)
                        .font(.custom(FontsManager.Poppins.semi_bold, size: 15))
                        .foregroundColor(Color("butonTitleColor"))
                        .padding(.bottom, 8)
                }
            }
            if shared.currentFilter.edit != .none {
                VStack{
                    Spacer()
                    if index == .color {
                        ColorControl()
                    }else if index == .contrast {
                        ContrastControl()
                    }else if index == .vignette {
                        VignetteControl()
                    }else if index == .fade {
                        FadeControl()
                    }else if index == .highlights {
                        HighlightsControl()
                    }else if index == .hls {
                        HLSControl()
                    }else if index == .exposure {
                        ExposureControl()
                    }else if index == .saturation {
                        SaturationControl()
                    }else if index == .shadows {
                        ShadowsControl()
                    }else if index == .sharpen {
                        SharpenControl()
                    }else if index == .temperature {
                        TemperatureControl()
                    }else if index == .vignette {
                        VignetteControl()
                    }else if index == .tone {
                        ToneControl()
                    }else if index == .white_balance {
                        WhiteBalanceControl()
                    }else{
                        Text("Todo")
                    }
                    
                    Spacer()
                    HStack{
                        /*
                        Button(action: {
                            self.shared.didReceive(action: PECtlAction.revert)
                            self.shared.currentFilter = FilterModel.noneFilterModel
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
                                print("PECtlAction.commit")
                                self.shared.didReceive(action: PECtlAction.revert)
                                self.shared.currentFilter = FilterModel.noneFilterModel
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
                        Text(shared.currentFilter.name)
                            .font(.custom(FontsManager.Poppins.semi_bold, size: 15))
                            .foregroundColor(Color("butonTitleColor"))
                        

                        Spacer()
                        
                        /*
                        Button(action: {
                            self.shared.didReceive(action: PECtlAction.commit)
                            self.shared.currentFilter = FilterModel.noneFilterModel
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
                                self.shared.didReceive(action: PECtlAction.commit)
                                self.shared.currentFilter = FilterModel.noneFilterModel
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
                        
                        
                    }.padding(.bottom, 8)
                } // ends of VStack
                .padding(.horizontal)
                .background(Color("editBackground"))
            }
        }
    }
}
