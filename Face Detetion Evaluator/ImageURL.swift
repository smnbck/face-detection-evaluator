//
//  ImageURL.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 26.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import Foundation

class TestImage {
    
    var description: String
    var urlString: String
    var age: Int
    
    init(description: String, urlString: String, age: Int) {
        self.description = description
        self.urlString = urlString
        self.age = age
    }
}
