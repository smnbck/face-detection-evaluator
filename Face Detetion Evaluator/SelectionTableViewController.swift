//
//  ViewController.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 14.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SelectionTableViewController: UITableViewController {

    var apis: [ApiDescription] = [
        ApiDescription(apiName: "Kairos Emotions Analysis", corporateName: "Kairos"),
        ApiDescription(apiName: "Kairos Face Recognition", corporateName: "Kairos"),
        ApiDescription(apiName: "Face++", corporateName: "Face++"),
        ApiDescription(apiName: "Cognitive Services", corporateName: "Microsoft")
    ]
    
    var testImages: [TestImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testImages = TestImages().getTestImages()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Table View Controller
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testImages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "apiCell", for: indexPath)
        if let cell = cell as? APISelectionTableViewCell {
            cell.imageDescription.text = testImages[indexPath.row].description
            let urlString = testImages[indexPath.row].urlString
            if let url = URL(string: urlString) {
                cell.testImageView.af_setImage(withURL: url)
            } else {
                print("error: \(indexPath.row)")
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let descriptionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DescriptionViewController") as? SelectionDetailsViewController {
            descriptionViewController.testImage = self.testImages[indexPath.row]
            self.show(descriptionViewController, sender: self)
        }
    }
}

