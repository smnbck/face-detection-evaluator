//
//  ResultsDetailsViewController.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 15.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit

class ResultsDetailsTableViewController: UITableViewController {

    // MARK: - Passed Properties
    var testImage: TestImage?
    var kairosEmotionsResult: KairosEmotionsTestResult?
    var kairosRecognitionResult: KairosRecognitionTestResult?
    var facePlusPlusResult: FacePlusPlusTestResult?
    var microsoftResult: MicrosoftTestResult?
    
    // MARK: - Stored Properties
    let attributeArray: [String] = ["12.32 ms", "female", "yup"]
    let sectionNames = [
        "",
        "Time",
        "Age",
        "Gender",
        "Ethnicity",
        "Emotions",
        "Glasses",
        "Facial Hair",
        "Hair",
        "Image Quality"
//        "Accessories",
//        "Makeup",
//        "Occlusion"
    ]
    
    var apiNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
        apiNames.append(self.kairosRecognitionResult?.apiName ?? "error")
        apiNames.append(self.facePlusPlusResult?.apiName ?? "error")
        apiNames.append(self.microsoftResult?.apiName ?? "error")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let name = self.sectionNames[section]
        if name == "Age" {
           return "\(name): \(testImage?.age ?? -1)"
        } else {
            return name
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return (section == 0) ? "" :  " "
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : 3
    }
}
