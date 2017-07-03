//
//  TestResult.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 28.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit

class MicrosoftTestResult: TestResult {
    
    let apiName = "MS Cog. Services"
    var faces: [MicrosoftFace]?
    
    init(faces: [MicrosoftFace]?, elapsedTime: Double) {
        self.faces = faces
        super.init(elapsedTime: elapsedTime)
    }
    
}
