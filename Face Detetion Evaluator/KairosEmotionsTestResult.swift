//
//  TestResult.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 28.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit

class KairosEmotionsTestResult: TestResult {
    
    let apiName = "Kairos"
    var faces: [KairosEmotionsFace]?
    
    init(faces: [KairosEmotionsFace]?, elapsedTime: Double) {
        self.faces = faces
        super.init(elapsedTime: elapsedTime)
    }
    
}
