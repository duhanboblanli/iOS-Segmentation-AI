//
//  API Types.swift
//  ios_ai_cutter
//
//  Created by Mert Uludogan on 31.08.2023.
//

import Foundation

extension API {
    
    enum Types {
        
        enum Response{
            
            struct Mask: Codable {
                struct Segmentation: Codable {
                    var counts: [Int]
                    var size: [Int]
                }
                
                var segmentation: Segmentation
                var crop_box: [Int]
                var predicted_iou: Double
                var bbox: [Int]
                var stability_score: Double
                var area: Float
                var point_coords: [[Double]]
            }
        }
        
        enum Request{
            struct Empty : Encodable {
            }
        }
        
        enum Error: LocalizedError{
            
            case generic(reason: String)
            case `internal`(reason: String)
            
            var errorDescription: String? {
                switch self {
                case .generic(let reason):
                    return reason
                case .internal(let reason):
                    return "Internal Error: \(reason)"
                }
            }
        }
        
        /*enum Endpoint {
            
            case dockerSegmentation
            case localSegmentation
            case cloudSegmentation
            
            var url: URL {
                var components = URLComponents()
                switch self{
                    
                
                case .dockerSegmentation:
                    components.host = "localhost"
                    components.port = 8000
                    components.scheme = "http"
                    components.path = "/v1/create_mask_upload/"
                     
             // http://ec2-18-196-210-218.eu-central-1.compute.amazonaws.com:80/v1/create_mask_upload/
                case .localSegmentation:

                    components.scheme = "http"
                    components.host = "ec2-18-196-210-218.eu-central-1.compute.amazonaws.com"
                    components.port = 80
                    components.path = "/v1/create_mask_upload/"
                     

                case .cloudSegmentation:
                    components.host = "ec2-18-196-210-218.eu-central-1.compute.amazonaws.com"
                    
                         
                }
                print("URL:",components.url!)
                return components.url!
            }
        } */
        
        
        enum Method: String {
            case get
            case post
        }
    }
    
    
}
