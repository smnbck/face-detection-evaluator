//
//  SelectionDetailsViewController+Timer.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 27.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit

extension SelectionDetailsViewController {
    
    func startKairosEmotionsTimer() {
        self.kairosEmotionsTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateKairosEmotionsTime), userInfo: nil, repeats: true)
    }
    
    func startKairosRecognitionTimer() {
        self.kairosRecognitionTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateKairosRecognitionTime), userInfo: nil, repeats: true)    }
    
    func startFacePlusPlusTimer() {
        self.facePlusPlusTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateFacePlusPlusTime), userInfo: nil, repeats: true)
    }
    
    func startMicrosoftTimer() {
        self.microsoftTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateMicrosoftTime), userInfo: nil, repeats: true)
    }
    
    func stopTimer(timer: Timer) {
        timer.invalidate()
    }
    
    func updateKairosEmotionsTime() {
        self.kairosEmotionsTime += 0.001
        let time = round(kairosEmotionsTime * 1000) / 1000
        self.kairosEmotionsTimerLabel.text = "\(time) sec"
    }
    
    func updateKairosRecognitionTime() {
        self.kairosRecognitionTime += 0.001
        let time = round(kairosRecognitionTime * 1000) / 1000
        self.kairosRecognitionTimerLabel.text = "\(time) sec"
    }
    
    func updateFacePlusPlusTime() {
        self.facePlusPlusTime += 0.001
        let time = round(facePlusPlusTime * 1000) / 1000
        self.facePlusPlusTimerLabel.text = "\(time) sec"
    }
    
    func updateMicrosoftTime() {
        self.microsoftTime += 0.001
        let time = round(microsoftTime * 1000) / 1000
        self.microsoftTimerLabel.text = "\(time) sec"
    }
    
}
