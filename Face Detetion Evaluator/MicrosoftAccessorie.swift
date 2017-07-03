//
//  MicrosoftAccessories.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 25.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit
import Arrow

class MicrosoftAccessorie {
    
    var type: String?
    var confidence: Double?
    
    required init() {}
    
}

extension MicrosoftAccessorie: ArrowParsable {
    func deserialize(_ json: JSON) {
        self.type <-- json["color"]
        self.confidence <-- json["confidence"]
    }
}
