//
//  Ext_UIImage.swift
//  ios_ai_cutter
//
//  Created by Mert Uludogan on 7.10.2023.
//

import Foundation
import UIKit



extension UIImage {
    enum FilterType : String {
        case Chrome = "CIPhotoEffectChrome"
        case Fade = "CIPhotoEffectFade"
        case Instant = "CIPhotoEffectInstant"
        case Mono = "CIPhotoEffectMono"
        case Noir = "CIPhotoEffectNoir"
        case Process = "CIPhotoEffectProcess"
        case Tonal = "CIPhotoEffectTonal"
        case Transfer =  "CIPhotoEffectTransfer"
    }
    func addFilter(filter : FilterType) -> UIImage {
    let filter = CIFilter(name: filter.rawValue)
    // convert UIImage to CIImage and set as input
    let ciInput = CIImage(image: self)
    filter?.setValue(ciInput, forKey: "inputImage")
    // get output CIImage, render as CGImage first to retain proper UIImage scale
    let ciOutput = filter?.outputImage
    let ciContext = CIContext()
    let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
    //Return the image
    return UIImage(cgImage: cgImage!)
    }
    
    
    
}
