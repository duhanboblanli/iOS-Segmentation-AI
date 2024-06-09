//
//  Ext_CGSize.swift
//  ios_ai_cutter
//
//  Created by Mert Uludogan on 9.10.2023.
//

import Foundation
import UIKit

extension CGSize{
    func transform(with point: CGPoint, from size: CGSize) -> CGPoint{
        
        let transform = CGAffineTransform(scaleX: self.width / size.width, y: self.height / size.height)
        return point.applying(transform)
        
    }
    
    func transform(with point: CGPoint, to size: CGSize) -> CGPoint{
        
        let transform = CGAffineTransform(scaleX: size.width / self.width, y: size.height / self.height)
        return point.applying(transform)
        
    }
    
    func fit(in size: CGSize) -> CGSize{

        let widthRatio: CGFloat = self.width / size.width
        let heightRatio: CGFloat = self.height / size.height
        if widthRatio > heightRatio{
            return CGSize(width: size.width, height: self.height / widthRatio)
        }
        else{
            return CGSize(width: self.width / heightRatio, height: size.height )
        }
        
        
    }
}
