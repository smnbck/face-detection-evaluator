//
//  FacePlusPlusFace.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 20.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit
import Arrow

class FacePlusPlusFace: Face {
    
    var faceToken: String?
    var gender: Gender?
    var age: Int?
    var glass: String?
    
    var smileThreshold: Double?
    var smileValue: Double?
    var smiling: Bool?
    
    var blurThreshold: Double?
    var blurValue: Double?
    var blurAffectedRecognition: Bool?
    
    var faceQuality: Double?
    var ethnicity: String?
    
    required init() {}
}

extension FacePlusPlusFace: ArrowParsable {
    
    func deserialize(_ json: JSON) {
        if let attributesJSON = json["attributes"] {
            
            var genderString: String?
            genderString <-- attributesJSON["gender"]?["value"]
            self.gender = (genderString == "Male") ? .male : .female
            
            self.age <-- attributesJSON["age"]?["value"]
            self.glass <-- attributesJSON["glass"]?["value"]
            
            self.smileThreshold <-- attributesJSON["smile"]?["threshold"]
            self.smileValue <-- attributesJSON["smile"]?["value"]
            if let smileValue = smileValue, let smileThreshold = smileThreshold {
                self.smiling = (smileValue > smileThreshold) ? true : false
            }
            self.blurValue <-- attributesJSON["blur"]?["blurness"]?["value"]
            self.blurThreshold <-- attributesJSON["blur"]?["blurness"]?["threshold"]
            if let blurValue = blurValue, let blurThreshold = blurThreshold {
                self.blurAffectedRecognition = (blurValue > blurThreshold) ? true : false
            }
            
            self.faceQuality <-- attributesJSON["facequality"]?["value"]
            self.ethnicity <-- attributesJSON["ethnicity"]?["value"]
        }
        self.faceToken <-- json["face_token"]
        
        
    }

}
