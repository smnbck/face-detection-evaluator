//
//  KairosEmotions.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 25.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit
import Arrow

class KairosEmotions {
    var anger: Double?
    var disgust: Double?
    var fear: Double?
    var joy: Double?
    var sadness: Double?
    var surprise: Double?
    
    required init() {}
}

extension KairosEmotions: ArrowParsable {
    func deserialize(_ json: JSON) {
        self.anger <-- json["anger"]
        self.disgust <-- json["disgust"]
        self.fear <-- json["fear"]
        self.joy <-- json["joy"]
        self.sadness <-- json["sadness"]
        self.surprise <-- json["surprise"]
    }
}
