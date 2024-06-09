//
//  String+Localization.swift
//  ios_ai_cutter
//
//  Created by Duhan Boblanlı on 12.09.2023.
//

import Foundation

extension String{
   
    /// Localizes a string using self as key.
        ///
        /// - Parameters:
        ///   - bundle: the bundle where the Localizable.strings file lies.
        /// - Returns: localized string.
        private func localized(bundle: Bundle) -> String {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        }
    
    /// Localizes a string using given language from Language enum.
        /// - parameter language: The language that will be used to localized string.
        /// - Returns: localized string.
        func localized(_ language: Language) -> String {
            let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
            let bundle: Bundle
            if let path = path {
                bundle = Bundle(path: path) ?? .main
            } else {
                bundle = .main
            }
            return localized(bundle: bundle)
        }
    
    /// Localizes a string using given language from Language enum.
       ///  - Parameters:
       ///  - language: The language that will be used to localized string.
       ///  - args:  dynamic arguments provided for the localized string.
       /// - Returns: localized string.
       func localized(_ language: Language, args arguments: CVarArg...) -> String {
           let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
           let bundle: Bundle
           if let path = path {
               bundle = Bundle(path: path) ?? .main
           } else {
               bundle = .main
           }
           return String(format: localized(bundle: bundle), arguments: arguments)
       }
}


