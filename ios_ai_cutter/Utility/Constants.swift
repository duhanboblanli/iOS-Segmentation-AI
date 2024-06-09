//
//  Constants.swift
//  colorful-room
//
//  Created by Ping9 on 16/01/2022.
//

import Foundation
import SwiftUI

public class Constants{
    @AppStorage("language") private var language = LocalizationService.shared.language

    static var supportFilters:[FilterModel] = [
        FilterModel("Brightness".localized(LocalizationService.shared.language),image:"brightness"
, edit: EditMenu.exposure),
        FilterModel("Contrast".localized(LocalizationService.shared.language),image:"contrast"
, edit: EditMenu.contrast),
        FilterModel("Saturation".localized(LocalizationService.shared.language),image:"saturation"
, edit: EditMenu.saturation),
        FilterModel("White Balance".localized(LocalizationService.shared.language)
,image:"temperature", edit: EditMenu.white_balance),
        FilterModel("Tone".localized(LocalizationService.shared.language)
,image: "tone", edit: EditMenu.tone),
        FilterModel("HSL".localized(LocalizationService.shared.language)
,image: "hls", edit: EditMenu.hls),
        FilterModel("Fade".localized(LocalizationService.shared.language),image:"fade"
, edit: EditMenu.fade),
    ]
}
