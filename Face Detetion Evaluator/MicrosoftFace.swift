//
//  MicrosoftFace.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 23.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit
import Arrow

class MicrosoftFace: Face {
    
    var age: Double?
    var gender: Gender?
    var smile: Double?
    var facialHairMoustache: Double?
    var facialHairBeard: Double?
    var facialHairSideburns: Double?
    var glasses: String?
    var emotions: MicrosoftEmotions?
    
    var hairBald: Double?
    var hairInvisible: Bool?
    var hairColors: [MicrosoftHairColor]?
    
    var accessories: [MicrosoftAccessorie]?
    
    var makeupEyes: Bool?
    var makeupLips: Bool?
    
    var foreheadOccluded: Bool? // occluded = geöffnet
    var mouthOccluded: Bool? // occluded = geöffnet
    var eyeOccluded: Bool? // occluded = geöffnet
    
    var blurValue: Double?
    var blurLevel: String?
    
    var exposureValue: Double?
    var exposureLevel: String?
    
    var noiseValue: Double?
    var noiseLevel: String?
    
    required init() {}
}

extension MicrosoftFace: ArrowParsable {
    
    func deserialize(_ json: JSON) {
        self.age <-- json["age"]
        
        var genderString: String?
        genderString <-- json["gender"]
        self.gender = (genderString == "male") ? .male : .female
        
        self.smile <-- json["smile"]
        self.facialHairMoustache <-- json["facialHair"]?["moustache"]
        self.facialHairBeard <-- json["facialHair"]?["beard"]
        self.facialHairSideburns <-- json["facialHair"]?["sideburns"]
        self.glasses <-- json["glasses"]
        
        if let emotionsJSON = json["emotion"] {
            self.emotions = MicrosoftEmotions()
            self.emotions?.deserialize(emotionsJSON)
        }
    
        self.hairBald <-- json["hair"]?["bald"]
        self.hairInvisible <-- json["hair"]?["invisible"]
        
        if let hairColorsJSON = json["hair"]?["hairColor"]?.collection {
            var hairColors: [MicrosoftHairColor] = []
            for hairColorJSON in hairColorsJSON {
                let hairColor = MicrosoftHairColor()
                hairColor.deserialize(hairColorJSON)
                hairColors.append(hairColor)
            }
            self.hairColors = hairColors
        }
        
        if let accessoriesJSON = json["accessories"]?.collection {
            var accessories: [MicrosoftAccessorie] = []
            for accessorieJSON in accessoriesJSON {
                let accessorie = MicrosoftAccessorie()
                accessorie.deserialize(accessorieJSON)
                accessories.append(accessorie)
            }
            self.accessories = accessories
        }
        
        self.makeupEyes <-- json["makeup"]?["eyeMakeup"]
        self.makeupLips <-- json["makeup"]?["lipMakeup"]
        
        self.foreheadOccluded <-- json["occlusion"]?["foreheadOccluded"]
        self.mouthOccluded <-- json["occlusion"]?["mouthOccluded"]
        self.eyeOccluded <-- json["occlusion"]?["eyeOccluded"]
        
        self.blurValue <-- json["blur"]?["value"]
        self.blurLevel <-- json["blur"]?["blurLevel"]
        
        self.exposureValue <-- json["exposure"]?["value"]
        self.exposureLevel <-- json["exposure"]?["exposureLevel"]
        
        self.noiseValue <-- json["noise"]?["value"]
        self.noiseLevel <-- json["noise"]?["noiseLevel"]
    }

}
