//
//  MicrosoftFaceDetectionAPI.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 23.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit
import Alamofire
import Arrow

class MicrosofttFaceDetectionAPI {
    
    let baseURL = "https://westeurope.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceAttributes=age,gender,smile,facialHair,glasses,emotion,hair,makeup,occlusion,accessories,blur,exposure,noise"
    
    func detectFaces(imageURL: String, completionHandler: @escaping (Bool, [MicrosoftFace]?) -> Void) {
        let headers: [String: String] = [
            "ocp-apim-subscription-key": ApiKeys().getMicrosoftSubscriptionKey()
        ]
        
        let parameters: [String: String] = [
            "url": imageURL
        ]
        
        let url = baseURL
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            if response.result.isSuccess {

                guard let data = response.value as? [Any],
                let jsons = JSON(data)?.collection else {
                    completionHandler(false, nil)
                    return
                }

                var faces: [MicrosoftFace] = []
                for json in jsons {
                    
                    if let attributesJSON = json["faceAttributes"] {
                        let face = MicrosoftFace()
                        face.deserialize(attributesJSON)
                        faces.append(face)
                    }
                }
                
                completionHandler(true, faces)

            } else {
                completionHandler(false, nil)
            }
        }
    }
}
