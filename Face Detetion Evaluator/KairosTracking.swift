//
//  KairosTracking.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 16.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit
import Arrow

class KairosTracking {
    var attention: Int?
    var dwell: Bool?
    var blink: Double?
    var glances: Int?
    
    required init() {}
}

extension KairosTracking: ArrowParsable {
    func deserialize(_ json: JSON) {
        self.attention <-- json["attention"]
        self.dwell <-- json["dwell"]
        self.blink <-- json["blink"]
        self.glances <-- json["glances"]
    }
}
