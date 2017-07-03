//
//  KairosAPI.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 16.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import Foundation
import Alamofire
import Arrow

class KairosAPI {
    
    let baseURL = "https://api.kairos.com"
    
    func getHeaders() -> [String: String] {
        let headers: [String: String] = [
            "app_id": ApiKeys().getKairosAppID(),
            "app_key": ApiKeys().getKairosApiKey()
        ]
        return headers
    }
}

// MARK: - Emotion Anaylysis API
extension KairosAPI {
    
    // uploads media file multiple times until Kairos finished processing it
    func processMediaFile(imageURL: String, completionHandler: @escaping (Bool, String?, [KairosEmotionsFace]?) -> Void) {
        uploadMediaFile(imageURL: imageURL) { (success, id, faces) in
            if success {
                if let faces = faces,
                    let id = id {
                    completionHandler(true, id, faces)
                } else {
                    self.processMediaFile(imageURL: imageURL) { (_) in }
                }
            } else {
                completionHandler(false, nil, nil)
            }
        }
    }
    
    
    private func uploadMediaFile(imageURL: String, completionHandler: @escaping (Bool, String?, [KairosEmotionsFace]?) -> Void) {
        
        var finalImageURL = imageURL
        finalImageURL = finalImageURL.replacingOccurrences(of: ":", with: "%3A")
        finalImageURL = finalImageURL.replacingOccurrences(of: "/", with: "%2F")
        let url = baseURL + "/v2/media?source=" + finalImageURL + "&landmarks=1"
        
        Alamofire.request(url, method: .post, headers: getHeaders()).responseJSON { (response) in
            if response.result.isSuccess {
                
                guard let data = response.result.value as? [String: Any],
                let json = JSON(data),
                let id = json["id"]?.data as? String,
                let framesJSON = json["frames"]?.collection,
                let facesJSON = framesJSON[0]["people"]?.collection,
                let statusMessage = json["status_message"]?.data as? String else {
                    completionHandler(false, nil, nil)
                    return
                }
                
                if statusMessage == "Complete" {
                    var faces: [KairosEmotionsFace] = []
                    
                    for faceJSON in facesJSON {
                        let face = KairosEmotionsFace()
                        face.deserialize(faceJSON)
                        faces.append(face)
                    }
                    
                    completionHandler(true, id, faces)
                } else {
                    completionHandler(true, id, nil)
                }
            } else {
                print("error")
                completionHandler(false, nil, nil)
            }
        }
    }
    
    // get results from a media file by passing it's id
    func getMediaFileResults(fileID: String, completionHandler: @escaping (Bool, [KairosEmotionsFace]?) -> Void) {
        
        let url = baseURL + "/v2/media/\(fileID)"
        
        Alamofire.request(url, method: .get, headers: getHeaders()).responseJSON { (response) in
            if response.result.isSuccess {
                guard let data = response.result.value as? [String: Any],
                let json = JSON(data),
                let facesJSON = json["faces"]?.collection else {
                    completionHandler(false, nil)
                    return
                }
                
                var faces: [KairosEmotionsFace] = []
                
                for faceJSON in facesJSON {
                    let face = KairosEmotionsFace()
                    face.deserialize(faceJSON)
                    faces.append(face)
                }
                
                completionHandler(true, faces)
                
            } else {
                completionHandler(false, nil)
            }
        }
    }
    
    // deletes a media file from kairos servers
    func deleteMediaFile(fileID: String, completionHandler: @escaping (Bool) -> Void) {
        
        let url = baseURL + "/v2/media/\(fileID)"
        
        Alamofire.request(url, method: .delete, headers: getHeaders()).responseJSON { (response) in
            if response.result.isSuccess {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
}

// MARK: - Face Recognition APi
extension KairosAPI {
    
    func detectFaces(imageURL: String, completionHandler: @escaping (Bool, [KairosRecognitionFace]?) -> Void) {
        
        let url = baseURL + "/detect"
        let parameters = [
            "image":imageURL,
//            "selector":"ROLL" // <- optional, default is FRONTAL
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: getHeaders()).responseJSON { (response) in
            if response.result.isSuccess {
                guard let data = response.result.value as? [String: Any],
                let json = JSON(data),
                let imagesJSON = json["images"]?.collection,
                let facesJSON = imagesJSON[0]["faces"]?.collection else {
                        completionHandler(true, nil)
                        return
                }
                
                var faces: [KairosRecognitionFace] = []
                
                for faceJSON in facesJSON {
                    let face = KairosRecognitionFace()
                    face.deserialize(faceJSON)
                    faces.append(face)
                }
                
                completionHandler(true, faces)
            } else {
                completionHandler(false, nil)
            }
        }
    }
}
