//
//  ResultsDetailsTableViewController+CellConfiguration.swift
//  Face Detetion Evaluator
//
//  Created by Simon Back on 28.06.17.
//  Copyright © 2017 Simon Back. All rights reserved.
//

import UIKit

extension ResultsDetailsTableViewController {
    
    // MARK: - Cell Configuration
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return configurePreviewCell(indexPath: indexPath)
        case 1:
            return configureTimeSection(indexPath: indexPath)
        case 2:
            return configureAgeSection(indexPath: indexPath)
        case 3:
            return configureGenderSection(indexPath: indexPath)
        case 4:
            return configureEthnicitySection(indexPath: indexPath)
        case 5:
            return configureEmotionsSection(indexPath: indexPath)
        case 6:
            return configureGlassesSection(indexPath: indexPath)
        case 7:
            return configureFacialHairSection(indexPath: indexPath)
        case 8:
            return configureHairSection(indexPath: indexPath)
        case 9:
            return configureImageQualitySection(indexPath: indexPath)
        default:
            return configureAgeSection(indexPath: indexPath)
        }
    }
    
    func configureTimeSection(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath)
        if let cell = cell as? ResultsDetailsTableViewCell {
            
            cell.attributeNameLabel.text = "\(apiNames[indexPath.row])"
            var value: String?
            switch indexPath.row {
            case 0:
                value = "\(round(1000 * (self.kairosRecognitionResult?.elapsedTime ?? -1)) / 1000) (Rec) / \(round(1000 * (self.kairosEmotionsResult?.elapsedTime ?? -1)) / 1000) (Emo) sec"
            case 1:
                value = "\(round(1000 * (self.facePlusPlusResult?.elapsedTime ?? -1)) / 1000) sec"
            case 2:
                value = "\(round(1000 * (self.microsoftResult?.elapsedTime ?? -1)) / 1000) sec"
            default:
                break
            }
            cell.attributeValueLabel.text = value ?? "no value"
        }
        return cell
    }
    
    func configureAgeSection(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath)
        if let cell = cell as? ResultsDetailsTableViewCell {
            
            cell.attributeNameLabel.text = "\(apiNames[indexPath.row])"
            var age: Int?
            switch indexPath.row {
            case 0:
                if let face = self.kairosRecognitionResult?.faces?.first {
                    age = face.age
                }
            case 1:
                if let face = self.facePlusPlusResult?.faces?.first {
                    age = face.age
                }
            case 2:
                if let face = self.microsoftResult?.faces?.first {
                    age = Int(face.age ?? -1)
                }
            default:
                break
            }
            cell.attributeValueLabel.text = "\(age ?? -1)"
        }
        return cell
    }
    
    func configureGenderSection(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath)
        if let cell = cell as? ResultsDetailsTableViewCell {
            
            cell.attributeNameLabel.text = "\(apiNames[indexPath.row])"
            var value: Gender?
            switch indexPath.row {
            case 0:
                if let face = self.kairosRecognitionResult?.faces?.first {
                    value = face.gender
                }
            case 1:
                if let face = self.facePlusPlusResult?.faces?.first {
                    value = face.gender
                }
            case 2:
                if let face = self.microsoftResult?.faces?.first {
                    value = face.gender
                }
            default:
                break
            }
            
            cell.attributeValueLabel.text = (value == .female) ? "female" : "none"
            cell.attributeValueLabel.text = (value == .male) ? "male" : "none"
            
        }
        return cell
    }
    
    func configureEthnicitySection(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath)
        if let cell = cell as? ResultsDetailsTableViewCell {
            
            cell.attributeNameLabel.text = "\(apiNames[indexPath.row])"
            var value: String?
            switch indexPath.row {
            case 0:
                if let face = self.kairosRecognitionResult?.faces?.first {
                    value = "Asian: \(face.asian ?? -1)\nBlack: \(face.black ?? -1)\nHispanic: \(face.hispanic ?? -1)\nWhite: \(face.white ?? -1)\nOther: \(face.other ?? -1)"
                }
            case 1:
                if let face = self.facePlusPlusResult?.faces?.first {
                    value = face.ethnicity
                }
            case 2:
                value = "data not available"
            default:
                break
            }
            
            cell.attributeValueLabel.text = value ?? "no value"
            
        }
        return cell
    }
    
    func configureEmotionsSection(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath)
        if let cell = cell as? ResultsDetailsTableViewCell {
            
            cell.attributeNameLabel.text = "\(apiNames[indexPath.row])"
            var value: String?
            switch indexPath.row {
            case 0:
                if let face = self.kairosEmotionsResult?.faces?.first {
                    let anger = face.emotions?.anger ?? -1
                    let disgust = face.emotions?.disgust ?? -1
                    let fear = face.emotions?.fear ?? -1
                    let joy = face.emotions?.joy ?? -1
                    let surprise = face.emotions?.surprise ?? -1
                    let sadness = face.emotions?.sadness ?? -1
                    
                    value = "Anger: \(anger)\nDisgust: \(disgust)\nFear: \(fear)\nJoy: \(joy)\nSurprise: \(surprise)\nSadness: \(sadness)"
                }
            case 1:
                if let smiling = self.facePlusPlusResult?.faces?.first?.smiling {
                    value = (smiling) ? "Is smiling: Yes" : "Is smiling: No"
                } else {
                    value = "Is smiling: error"
                }
            case 2:
                if let face = self.microsoftResult?.faces?.first {
                    let anger = face.emotions?.anger ?? -1
                    let disgust = face.emotions?.disgust ?? -1
                    let fear = face.emotions?.fear ?? -1
                    let joy = face.emotions?.joy ?? -1
                    let surprise = face.emotions?.surprise ?? -1
                    let sadness = face.emotions?.sadness ?? -1
                    value = "Anger: \(anger)\nDisgust: \(disgust)\nFear: \(fear)\nJoy: \(joy)\nSurprise: \(surprise)\nSadness: \(sadness)\nIs smiling: \(face.smile ?? -1)"
                }
            default:
                break
            }
            
            cell.attributeValueLabel.text = value ?? "no value"
            
        }
        return cell
    }
    
    func configureGlassesSection(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath)
        if let cell = cell as? ResultsDetailsTableViewCell {
            
            cell.attributeNameLabel.text = "\(apiNames[indexPath.row])"
            var value: String?
            switch indexPath.row {
            case 0:
                if let face = kairosEmotionsResult?.faces?.first {
                    value = face.glasses
                }
            case 1:
                if let face = self.facePlusPlusResult?.faces?.first {
                    value = face.glass
                }
            case 2:
                if let face = self.microsoftResult?.faces?.first {
                    value = face.glasses
                }
            default:
                break
            }
            
            cell.attributeValueLabel.text = value ?? "no value"
            
        }
        return cell
    }
    
    func configureFacialHairSection(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath)
        if let cell = cell as? ResultsDetailsTableViewCell {
            
            cell.attributeNameLabel.text = "\(apiNames[indexPath.row])"
            var value: String?
            switch indexPath.row {
            case 0:
                value = "data not available"
            case 1:
                value = "data not available"
            case 2:
                if let face = self.microsoftResult?.faces?.first {
                    value = "Beard: \(face.facialHairBeard ?? -1)\nMustache: \(face.facialHairMoustache ?? -1)\nSideburns: \(face.facialHairSideburns ?? -1)"
                }
            default:
                break
            }
            
            cell.attributeValueLabel.text = value ?? "no value"
            
        }
        return cell
    }
    
    func configureHairSection(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath)
        if let cell = cell as? ResultsDetailsTableViewCell {
            
            cell.attributeNameLabel.text = "\(apiNames[indexPath.row])"
            var value: String?
            switch indexPath.row {
            case 0:
                value = "data not available"
            case 1:
                value = "data not available"
            case 2:
                if let face = self.microsoftResult?.faces?.first,
                let hairInvisible = face.hairInvisible {
                    value = "Hair invisible: \((hairInvisible) ? "Yes" : "No")"
                }
                // hair colors are missing
            default:
                break
            }
            
            cell.attributeValueLabel.text = value ?? "no value"
            
        }
        return cell
    }
    
    func configureImageQualitySection(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath)
        if let cell = cell as? ResultsDetailsTableViewCell {
            
            cell.attributeNameLabel.text = "\(apiNames[indexPath.row])"
            var value: String?
            switch indexPath.row {
            case 0:
                value = "Image quality: \(String(self.kairosRecognitionResult?.faces?.first?.quality ?? -99))"
            case 1:
                if let face = self.facePlusPlusResult?.faces?.first, let blurAffectedRecognition: Bool = face.blurAffectedRecognition {
                    value = "Face quality: \(String(face.faceQuality ?? -99))\nBlur affected detection: \((blurAffectedRecognition) ? "Yes" : "No")\n"
                }
            case 2:
                if let face = self.microsoftResult?.faces?.first {
                    value = "Blur: \(face.blurLevel ?? "error")\nNoise: \(face.noiseLevel ?? "error")\nExposure: \(face.exposureLevel ?? "error")\n"
                }
            // hair colors are missing
            default:
                break
            }
            
            cell.attributeValueLabel.text = value ?? "no value"
            
        }
        return cell
    }
    
//    missing section names
//        "Accessories",
//        "Makeup",
//        "Occlusion"
    
    func configurePreviewCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath)
        if let cell = cell as? ResultsDetailsTableViewCell {
            if let urlString = self.testImage?.urlString,
                let url = URL(string: urlString) {
                cell.previewImageView.af_setImage(withURL: url)
            }
        }
        return cell
    }
    
}
