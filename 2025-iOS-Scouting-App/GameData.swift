//
//  GameData.swift
//  2025-iOS-Scouting-App
//
//  Created by Sathvik Surapaneni on 2/5/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct GameData: Identifiable {
    let id = UUID()
    let studentName: String
    let teamNumber: String
    let matchNumber: String
    let robotStatus: String
    let autoT1: Int
    let autoT2: Int
    let autoT3: Int
    let autoT4: Int
    let autoAlgaeT1: Int
    let autoAlgaeT2: Int
    let defenseBot: String
    let teleT1: Int
    let teleT2: Int
    let teleT3: Int
    let teleT4: Int
    let teleAlgaeBarge: Int
    let teleAlgaeProccesor: Int
    let teleAlgaeHPA: Int
    let teleAlgaeHPM: Int
    let finishingPosition: String
    let comments: String

    func toQRCodeString() -> String {
        let studentNameValue = studentName.isEmpty ? "0" : studentName
        let teamNumberValue = teamNumber.isEmpty ? "0" : teamNumber
        let matchNumberValue = matchNumber.isEmpty ? "0" : matchNumber
        let robotStatusValue = robotStatus == "Yes" ? 1 : 0
        let defenseBotValue = defenseBot == "Yes" ? 1 : 0
        let finishingPositionValue: Int
        
        switch finishingPosition {
        case "Parked":
            finishingPositionValue = 1
        case "Shallow":
            finishingPositionValue = 2
        case "Deep":
            finishingPositionValue = 3
        default:
            finishingPositionValue = 0
        }
        
        let data1 = String(studentNameValue) + "," + String(teamNumberValue) + "," + String(matchNumberValue) + "," + String(robotStatusValue) + ","
             let data2 = String(autoT1)  + "," + String(autoT2)  + "," + String(autoT3) + "," + String(autoT4) + "," + String(autoAlgaeT1) + "," + String(autoAlgaeT2) + ","
             let data3 = String(defenseBotValue) + "," + String(teleT1) + "," + String(teleT2) + "," + String(teleT3) + "," + String(teleT4) + "," + String(teleAlgaeBarge) + "," + String(teleAlgaeProccesor) + ","
             let data4 = String(teleAlgaeHPA) + "," + String(teleAlgaeHPM)  + "," + String(finishingPositionValue)  + "," + String(comments)
             let data = data1+data2+data3+data4
        return data
    }
}

func generateQRCode(from string: String) -> UIImage {
    guard let data = string.data(using: .ascii) else { return UIImage() }
    let filter = CIFilter.qrCodeGenerator()
    filter.setValue(data, forKey: "inputMessage")
    guard let qrCodeImage = filter.outputImage else { return UIImage() }
    
    let transform = CGAffineTransform(scaleX: 10, y: 10)
    let scaledQRCodeImage = qrCodeImage.transformed(by: transform)
    
    guard let cgImage = CIContext().createCGImage(scaledQRCodeImage, from: scaledQRCodeImage.extent) else { return UIImage() }
    return UIImage(cgImage: cgImage)
}
