//
//  KairosDetectionFace.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 24.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit
import Arrow

class KairosRecognitionFace: Face {
    
    var lips: String?
    var age: Int?
    var gender: Gender?
    var glasses: Bool?
    var asian: Double?
    var hispanic: Double?
    var other: Double?
    var black: Double?
    var white: Double?
    var quality: Double?
    
    required init() {}
}

extension KairosRecognitionFace: ArrowParsable {
    
    func deserialize(_ json: JSON) {
        let attributes = json["attributes"]
        if let attributes = attributes {
            self.lips <-- attributes["lips"]
            self.age <-- attributes["age"]
            
            var genderString: String?
            genderString <-- attributes["gender"]?["type"]
            self.gender = (genderString == "F") ? .female : .male
            
            var glassesString: String?
            glassesString <-- attributes["glasses"]
            self.glasses = (glassesString == "None") ? false : true
            
            self.asian <-- attributes["asian"]
            self.hispanic <-- attributes["hispanic"]
            self.other <-- attributes["other"]
            self.black <-- attributes["black"]
            self.white <-- attributes["white"]
        }
        self.quality <-- json["quality"]
    }
    
}
