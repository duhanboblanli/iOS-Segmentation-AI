//
//  NetworkManager.swift
//  Segment AI
//
//  Created by Duhan Boblanlı on 5.11.2023.
//

import Foundation
import CommonCrypto
import Alamofire

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    var afSession: Session!

    private override init() {
        super.init()
        
        let evaluators: [String: ServerTrustEvaluating] = [
            "api.openweathermap.org": PublicKeysTrustEvaluator()
        ]
        
        let manager = ServerTrustManager(evaluators: evaluators)
        afSession = Session.init(serverTrustManager: manager)
    }
    
    
    func afRequest<T: Decodable>(url: URL?, expecting: T.Type, completion: @escaping (_ data: T?, _ error: Error?)-> ()) {
        
        afSession.request(url?.absoluteString ?? "")
            .validate()
            .response { response in
                
                switch response.result {
                    
                case .success(let data):
                    guard let data else {
                        completion(nil, NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"something went wrong"]))
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let response = try decoder.decode(T.self, from: data)
                        completion(response, nil)
                    } catch {
                        completion(nil, error)
                    }
                    
                case .failure(let error):
                    switch error {
                        
                    case .serverTrustEvaluationFailed(let reason):
                        print(reason)
                        completion(nil, NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"Pinning Failed"]))
                        
                    default:
                        completion(nil, error)
                    }

                }
            }
    }
}


