//
//  Ext_CGRect.swift
//  ios_ai_cutter
//
//  Created by Mert Uludogan on 9.10.2023.
//

import Foundation


extension CGRect{
    
    func transform(cgRect: CGRect) -> CGRect{
        
        let transform = CGAffineTransform(scaleX: cgRect.size.width / self.width, y: cgRect.size.height / self.height)
        let point = cgRect.origin.applying(transform)
        
        return CGRect(origin: point, size: cgRect.size)
        
        
    }
    
    func transform(cgRect: CGRect, point: CGPoint) -> CGPoint{
        
        let transform = CGAffineTransform(scaleX: cgRect.size.width / self.width, y: cgRect.size.height / self.height)
        return point.applying(transform)
        
        
        
        
    }
    
    func transform(cgSize: CGSize, point: CGPoint) -> CGPoint{
        
        let transform = CGAffineTransform(scaleX: cgSize.width / self.width, y: cgSize.height / self.height)
        return point.applying(transform)
        
        
        
        
    }
    
    func contains(rect: CGRect) -> Bool{
        
        let a = self.minX <= rect.minX
        let b = rect.maxX <= self.maxX
        let c = self.minY <= rect.minY
        let d = rect.maxY <= self.maxY
        
        if(a && b && c && d){
            return true
        }
        else{
            return false
        }
        
    }
    
    
}

extension CGRect{
    
    init(
        point_1: CGPoint,
        point_2: CGPoint
    ){
        var origin: CGPoint!
        var size: CGSize!
        if(point_1.x < point_2.x){ // left
            if(point_1.y < point_2.y){ // top
                origin = point_1
                size = CGSize(
                    width: point_2.x - point_1.x,
                    height: point_2.y - point_1.y
                )
            }
            else{ // bottom
                origin = CGPoint(
                    x: point_1.x,
                    y: point_2.y
                )
                size = CGSize(
                    width: point_2.x - point_1.x,
                    height: point_1.y - point_2.y
                )
            }
        }
        else{ // right
            if(point_1.y < point_2.y){ // top
                origin = CGPoint(
                    x: point_2.x,
                    y: point_1.y
                )
                size = CGSize(
                    width: point_1.x - point_2.x,
                    height: point_1.y - point_2.y
                )
            }
            else{ // bottom
                origin = point_2
                size = CGSize(
                    width: point_1.x - point_2.x,
                    height: point_1.y - point_2.y
                )
            }
        }
        self.init(origin: origin, size: size)
    }
}
