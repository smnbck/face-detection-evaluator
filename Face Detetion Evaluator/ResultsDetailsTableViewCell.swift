//
//  ResultsDetailsTableViewCell.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 15.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit

class ResultsDetailsTableViewCell: UITableViewCell {

    // MARK: - PreviewCell
    @IBOutlet weak var previewImageView: UIImageView!
    
    // MARK: - AttributeCell
    @IBOutlet weak var attributeNameLabel: UILabel!
    @IBOutlet weak var attributeValueLabel: UILabel!
    
    // MARK: - Class Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
