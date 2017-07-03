//
//  TestResult.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 28.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit

class KairosRecognitionTestResult: TestResult {
    
    let apiName = "Kairos"
    var faces: [KairosRecognitionFace]?
    
    init(faces: [KairosRecognitionFace]?, elapsedTime: Double) {
        self.faces = faces
        super.init(elapsedTime: elapsedTime)
    }
    
}
