//
//  APISelectionTableViewCell.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 14.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit

class APISelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var imageDescription: UILabel!
    
    @IBOutlet weak var testImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
