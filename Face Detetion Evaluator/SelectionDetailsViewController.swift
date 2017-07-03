//
//  ApiDescriptionViewController.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 15.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit

class SelectionDetailsViewController: UIViewController {
    
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var kairosEmotionsTimerLabel: UILabel!
    @IBOutlet weak var kairosRecognitionTimerLabel: UILabel!
    @IBOutlet weak var facePlusPlusTimerLabel: UILabel!
    @IBOutlet weak var microsoftTimerLabel: UILabel!
    
    
    // MARK: - Stored Properties
    var testImage: TestImage?
    var kairosEmotionsTime: Double = 0
    var kairosRecognitionTime: Double = 0
    var facePlusPlusTime: Double = 0
    var microsoftTime: Double = 0
    var finishedTests: [Bool] = []
    
    var kairosEmotionsFaces: [KairosEmotionsFace]?
    var kairosRecognitionFaces: [KairosRecognitionFace]?
    var facePlusPlusFaces: [FacePlusPlusFace]?
    var microsoftFaces: [MicrosoftFace]?
    
    var kairosEmotionsTimer = Timer()
    var kairosRecognitionTimer = Timer()
    var facePlusPlusTimer = Timer()
    var microsoftTimer = Timer()
    
    // MARK: - Class Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Test"
        
        self.startButton.layer.cornerRadius = 3
        
        if let urlString = self.testImage?.urlString,
        let url = URL(string: urlString) {
            previewImage.af_setImage(withURL: url)
        }
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {

        startTest()
        
    }
    
    func startTest() {
        
        guard let url = self.testImage?.urlString else {return}
        
        startKairosEmotionsTest(imageURL: url, completionHandler: { (success, faces, elapsedTime) in
            self.kairosEmotionsFaces = faces
            self.finishedTests.append(success)
            self.checkIfTestsFinished()
        })
        
        startKairosRecognitionTest(imageURL: url, completionHandler: { (success, faces, timeString) in
            self.kairosRecognitionFaces = faces
            self.finishedTests.append(success)
            self.checkIfTestsFinished()
        })
        
        startFacePlusPlusTest(imageURL: url, completionHandler: { (success, faces, timeString) in
            self.facePlusPlusFaces = faces
            self.finishedTests.append(success)
            self.checkIfTestsFinished()
        })

        startMicrosoftCognitiveServicesTest(imageURL: url, completionHandler: { (success, faces, timeString) in
            self.microsoftFaces = faces
            self.finishedTests.append(success)
            self.checkIfTestsFinished()
        })
        
    }
    
    func startKairosEmotionsTest(imageURL: String, completionHandler: @escaping (Bool, [KairosEmotionsFace]?, String?) -> Void) {
        let kairosAPI = KairosAPI()
        self.kairosEmotionsTime = 0
        self.startKairosEmotionsTimer()
        
        kairosAPI.processMediaFile(imageURL: imageURL) { (success, id, faces) in
            if success {
                self.stopTimer(timer: self.kairosEmotionsTimer)
                let elapsedTimeString = "\(self.kairosEmotionsTime)"
                completionHandler(true, faces, elapsedTimeString)
            } else {
                self.stopTimer(timer: self.kairosEmotionsTimer)
                self.kairosEmotionsTimerLabel.text = "Error"
                
                self.finishedTests.append(false)
                completionHandler(false, nil, nil)
            }
        }
    }
    
    func startKairosRecognitionTest(imageURL: String, completionHandler: @escaping (Bool, [KairosRecognitionFace]?, String?) -> Void) {
        let kairosAPI = KairosAPI()
        self.kairosRecognitionTime = 0
        self.startKairosRecognitionTimer()
        
        kairosAPI.detectFaces(imageURL: imageURL) { (success, faces) in
            if success {
                self.stopTimer(timer: self.kairosRecognitionTimer)
                let elapsedTimeString = "\(self.kairosRecognitionTime)"
                completionHandler(true, faces, elapsedTimeString)
            } else {
                self.stopTimer(timer: self.kairosRecognitionTimer)
                self.kairosRecognitionTimerLabel.text = "Error"
                
                self.finishedTests.append(false)
                completionHandler(false, nil, nil)
            }
        }
    }
    
    func startFacePlusPlusTest(imageURL: String, completionHandler: @escaping (Bool, [FacePlusPlusFace]?, String?) -> Void) {
        let facePlusPlusAPI = FacePlusPlusAPI()
        self.facePlusPlusTime = 0
        self.startFacePlusPlusTimer()
        
        facePlusPlusAPI.detectFaces(imageURL: imageURL) { (success, faces) in
            if success {
                self.stopTimer(timer: self.facePlusPlusTimer)
                let elapsedTimeString = "\(self.facePlusPlusTime)"
                completionHandler(true, faces, elapsedTimeString)
            } else {
                self.stopTimer(timer: self.facePlusPlusTimer)
                self.facePlusPlusTimerLabel.text = "Error"
                
                self.finishedTests.append(false)
                completionHandler(false, nil, nil)
            }
        }
    }

    func startMicrosoftCognitiveServicesTest(imageURL: String, completionHandler: @escaping (Bool, [MicrosoftFace]?, String?) -> Void) {
        let microsoftFaceAPI = MicrosofttFaceDetectionAPI()
        self.microsoftTime = 0
        self.startMicrosoftTimer()

        microsoftFaceAPI.detectFaces(imageURL: imageURL) { (success, faces) in
            if success {
                self.stopTimer(timer: self.microsoftTimer)
                let elapsedTimeString = "\(self.microsoftTime)"
                completionHandler(true, faces, elapsedTimeString)
            } else {
                self.stopTimer(timer: self.microsoftTimer)
                self.microsoftTimerLabel.text = "Error"
                
                self.finishedTests.append(false)
                completionHandler(false, nil, nil)
            }
        }
    }
    
    func checkIfTestsFinished() {
        var successfullTestsCounter = 0
        if finishedTests.count == 4 {
            for test in finishedTests {
                if test {
                    successfullTestsCounter += 1
                }
            }
        }
        if successfullTestsCounter == 4 {
            showResultsViewController()
        } else if finishedTests.count >= 4{
            print("not everything finished or successfull")
            finishedTests.removeAll()
        }
    }
    
    func showResultsViewController() {
        guard let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultsNavigationController") as? UINavigationController,
        let vc = navigationController.viewControllers.first as? ResultsDetailsTableViewController else {return}
        
        vc.title = "Results"
        vc.testImage = self.testImage
        
        vc.kairosEmotionsResult = KairosEmotionsTestResult(faces: self.kairosEmotionsFaces, elapsedTime: kairosEmotionsTime)
        vc.kairosRecognitionResult = KairosRecognitionTestResult(faces: self.kairosRecognitionFaces, elapsedTime: kairosRecognitionTime)
        vc.facePlusPlusResult = FacePlusPlusTestResult(faces: self.facePlusPlusFaces, elapsedTime: facePlusPlusTime)
        vc.microsoftResult = MicrosoftTestResult(faces: self.microsoftFaces, elapsedTime: microsoftTime)
        
        showAlert(vc: vc)
    }
    
    func showAlert(vc: UIViewController) {
        var kairosEmoHasFace = "Yes"
        if let kairosEmotionsFaces = self.kairosEmotionsFaces {
            kairosEmoHasFace = (kairosEmotionsFaces.isEmpty) ? "No" : "Yes"
        }
        var kairosRecHasFace = "Yes"
        if let kairosRecognitionFaces = self.kairosRecognitionFaces {
            kairosRecHasFace = (kairosRecognitionFaces.isEmpty) ? "No" : "Yes"
        }
        var facePlusPlusHasFace = "Yes"
        if let facePlusPlusFaces = self.facePlusPlusFaces {
            facePlusPlusHasFace = (facePlusPlusFaces.isEmpty) ? "No" : "Yes"
        }
        var msHasFace = "Yes"
        if let msFaces = self.microsoftFaces {
            msHasFace = (msFaces.isEmpty) ? "No" : "Yes"
        }
        
        let hasFaceString = "KairosEmo: \(kairosEmoHasFace), KairosRec: \(kairosRecHasFace), Face++: \(facePlusPlusHasFace), Microsoft: \(msHasFace)"
        
        let alert = UIAlertController(title: "Gesicht gefunden?", message: hasFaceString, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.show(vc, sender: self)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
