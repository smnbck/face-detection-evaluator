//
//  MicrosoftEmotions.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 25.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit
import Arrow

class MicrosoftEmotions: Emotions {
    
    var neutral: Double?
    var contempt: Double?
    
    required init() {}
}

extension MicrosoftEmotions: ArrowParsable {
    func deserialize(_ json: JSON) {
        self.anger <-- json["anger"]
        self.disgust <-- json["disgust"]
        self.fear <-- json["fear"]
        self.joy <-- json["happiness"]
        self.sadness <-- json["sadness"]
        self.surprise <-- json["surprise"]
        self.neutral <-- json["neutral"]
        self.contempt <-- json["contempt"]
    }
}
