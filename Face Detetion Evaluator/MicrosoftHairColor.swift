//
//  MicrosoftHairColor.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 25.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit
import Arrow

class MicrosoftHairColor {
    
    var color: String?
    var confidence: Double?
    
    required init() {}
    
}

extension MicrosoftHairColor: ArrowParsable {
    func deserialize(_ json: JSON) {
        self.color <-- json["color"]
        self.confidence <-- json["confidence"]
    }
}
