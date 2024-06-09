//
//  Ext_CGPath.swift
//  ios_ai_cutter
//
//  Created by Mert Uludogan on 9.10.2023.
//

import Foundation
import UIKit

extension CGPath{
    func clip(image: UIImage) -> UIImage{
        var cgRect = self.boundingBoxOfPath
        let resultImage = UIGraphicsImageRenderer(size: cgRect.size).image{ context in
            context.cgContext.translateBy(
                x: -cgRect.origin.x,
                y: -cgRect.origin.y
            )
            context.cgContext.addPath(self)
            context.cgContext.clip()
            image.draw(at: .zero)
        }
        return resultImage
    }
}
