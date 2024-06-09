//
//  APIClient.swift
//  ios_ai_cutter
//
//  Created by Mert Uludogan on 31.08.2023.
//

import Foundation
import SwiftUI
import Alamofire

extension API {
        
    class Client{
        
        static let shared = Client()
        private let encoder = JSONEncoder()
        private let decoder = JSONDecoder()
        @AppStorage("endPointURL") var endPointURL = URL(fileURLWithPath: "")

        func getMasks(
                      body fileURL: URL,
                      then callback: ((Result<[[String: Any]], Types.Error>) -> Void)?
        ) async {
            
            
            print("fileURL: \(fileURL)")
            // Define the API endpoint URL
            // Define headers if needed
            let headers: HTTPHeaders = [:]
            // Create a multipartFormData block to add the file and mask_gen_params
            let serial = AF.upload(
                multipartFormData: { multipartFormData in
                    // Add the file
                    multipartFormData.append(fileURL, withName: "file")
                },
                to: endPointURL,
                headers: headers
            ){
                $0.timeoutInterval = 9999
            }
                .serializingData()
            
            switch await serial.response.result {
            case .success(let data):
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonDict = jsonResponse as? [String: Any] {
                        if let jsonString = jsonDict["masks"] as? String{
                            if let jsonData = jsonString.data(using: .utf8) {
                                do {
                                    if let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
                                        callback?(.success(jsonArray))
                                    }
                                } catch {
                                    callback?(.failure(.internal(reason: "Error parsing JSON: \(error)")))
                                }
                            }
                        }
                        else{
                            callback?(.failure(.internal(reason: "Error converting to String Data")))
                        }
                    } else {
                        callback?(.failure(.internal(reason: "Response data is not a valid JSON dictionary.")))
                    }
                }
                catch {
                    callback?(.failure(.internal(reason: "Error parsing JSON: \(error)")))
                }
                
            case .failure(let error):
                // Handle failure
                print("Error: \(error)")
            }
            
            
        }
        
    }
}
