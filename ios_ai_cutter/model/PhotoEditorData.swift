//  PhotoEditorData.swift

import Foundation
import SwiftUI
import PixelEnginePackage

// Define filters according to their assets names
class PhotoEditorData: ObservableObject {
    
    static var shared = PhotoEditorData();
    
    init(){
        @AppStorage("language") var language = LocalizationService.shared.language

        autoreleasepool {
            neutralLUT = UIImage(named: "lut-normal")!
            neutralCube = FilterColorCube(
                name: "Neutral".localized(LocalizationService.shared.language),
                identifier: "neutral",
                lutImage: neutralLUT,
                dimension: 64
            )
            
            
            // basic
            let basic = PhotoEditorCollection(name: "Basic".localized(LocalizationService.shared.language), identifier: "Basic", cubeInfos: [])
            for i in 1...10{
                let cube =  FilterColorCubeInfo(
                    name: "Basic".localized(LocalizationService.shared.language) + "\(i)",
                    identifier: "basic-\(i)",
                    lutImage: "lut-\(i)"
                )
                basic.cubeInfos.append(cube)
            }
            
            // Cinematic
            let cinematic = PhotoEditorCollection(name: "Cinematic".localized(LocalizationService.shared.language), identifier: "Cinematic", cubeInfos: [])
            for i in 1...10{
                let cube =  FilterColorCubeInfo(
                    name: "Cinematic".localized(LocalizationService.shared.language) + "\(i)",
                    identifier: "Cinematic-\(i)",
                    lutImage: "cinematic-\(i)"
                )
                cinematic.cubeInfos.append(cube)
            }
            
            
            
            // Film
            let film = PhotoEditorCollection(name: "Film".localized(LocalizationService.shared.language), identifier: "Film", cubeInfos: [])
            for i in 1...3{
                let cube =  FilterColorCubeInfo(
                    name: "Film".localized(LocalizationService.shared.language) + "\(i)",
                    identifier: "Film-\(i)",
                    lutImage: "film-\(i)"
                )
                film.cubeInfos.append(cube)
            }
            
            
            // Selfie Good Skin
            let selfie = PhotoEditorCollection(name: "Selfie".localized(LocalizationService.shared.language), identifier: "Selfie", cubeInfos: [])
            for i in 1...12{
                let cube =  FilterColorCubeInfo(
                    name: "Selfie".localized(LocalizationService.shared.language) + "\(i)",
                    identifier: "Selfie-\(i)",
                    lutImage: "selfie-\(i)"
                )
                selfie.cubeInfos.append(cube)
            }
            
            
            // init collections
            
            self.collections = [basic, cinematic, film, selfie]
            //self.collections = [basic]

        }
    } // ends of init
    
    var neutralLUT: UIImage!
    var neutralCube: FilterColorCube!
    var collections:[PhotoEditorCollection]!
    
    // Cube by collection
    func cubeBy(identifier:String) -> FilterColorCube?{
        for e in self.collections {
            for cube in e.cubeInfos{
                if(cube.identifier == identifier){
                    return cube.getFilter()
                }
            }
        }
        return nil;
    }
}
