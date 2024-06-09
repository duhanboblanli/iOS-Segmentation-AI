//
//  Ext_CGPath.swift
//  ios_ai_cutter
//
//  Created by Mert Uludogan on 6.10.2023.
//

import Foundation
import Vision
import UIKit

extension CGMutablePath{
    
    func moveDraw(fromPoint: CGPoint, toPoint: CGPoint){
        self.move(to: fromPoint)
        self.addLine(to: toPoint)
    }

}
