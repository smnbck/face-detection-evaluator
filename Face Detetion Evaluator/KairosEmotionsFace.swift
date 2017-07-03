//
//  KairosFace.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 16.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit
import Arrow

class KairosEmotionsFace: Face {
    
    var glasses: String?
    var ageGroup: String?
    var gender: Gender?
    var distance: Double?
    var emotions: KairosEmotions?
    
    required init() {}
}

extension KairosEmotionsFace: ArrowParsable {
    
    func deserialize(_ json: JSON) {
        self.glasses <-- json["appearance"]?["glasses"]
        self.ageGroup <-- json["demographics"]?["age_group"]
        
        var genderString: String?
        genderString <-- json["demographics"]?["gender"]
        self.gender = (genderString == "Male") ? .male : .female
        
        self.distance <-- json["distance"]
        
        if let emotionsJSON = json["emotions"] {
            self.emotions = KairosEmotions()
            self.emotions?.deserialize(emotionsJSON)
        }
    }

}
