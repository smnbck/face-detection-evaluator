//
//  FacePlusPlusAPI.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 20.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit
import Arrow
import Alamofire

class FacePlusPlusAPI {
    
    let baseURL = "https://api-us.faceplusplus.com/facepp/v3"
    
}

extension FacePlusPlusAPI {
    
    func detectFaces(imageURL: String, completionHandler: @escaping (Bool, [FacePlusPlusFace]?) -> Void) {
        let parameters: [String: Any] = [
            "api_key": ApiKeys().getFacePlusPlusApiKey(),
            "api_secret": ApiKeys().getFacePlusPlusSecret(),
            "image_url": imageURL, // <- worst way of uploading images because of possible problems with internet connections
//            "image_file": file <- recommended way of passing images
//            "image_base64": imageString <- base64 encoded string of the file, second best way
//            "return_landmark": 1, //optional: 1 is yes, 0 is no(default)
            "return_attributes": "gender,age,smiling,headpose,facequality,blur,eyestatus,ethnicity" //default is no
        ]

        let url = baseURL + "/detect"
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (response) in
            guard let data = response.value as? [String: Any],
            let json = JSON(data),
            let facesJSON = json["faces"]?.collection else {
                completionHandler(false, nil)
                return
            }
            
            if response.result.isSuccess {
                var faces: [FacePlusPlusFace] = []
                for faceJSON in facesJSON {
                    let face = FacePlusPlusFace()
                    face.deserialize(faceJSON)
                    faces.append(face)
                }
                completionHandler(true, faces)
            } else {
                completionHandler(false, nil)
            }
        }
    }
    
    // face_tokens are received via the detectFaces Method, this method basicly does the same as detectFaces() but you don't need to pass an image because it was allready processed previously
    func analyzeFaces(faceTokens: String, completionHandler: @escaping (Bool, String?, FacePlusPlusFace?) -> Void) {
        
    }
    
}
