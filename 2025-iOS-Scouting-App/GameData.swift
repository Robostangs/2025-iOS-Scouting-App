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
    let algaeInProcessor: Int
    let algaeInNet: Int
    let coralPlaced: Int
    let TalgaeInProcessor: Int
    let TalgaeInNet: Int
    let TcoralPlaced: Int
    let EalgaeInProcessor: Int
    let EalgaeInNet: Int
    let EcoralPlaced: Int
    let robotStatus2: String
    let finishingPosition: String
    let comments: String

    func toQRCodeString() -> String {
        return """
        Student Name: \(studentName)
        Team Number: \(teamNumber)
        Match Number: \(matchNumber)
        Robot Status: \(robotStatus)
        Algae in Processor: \(algaeInProcessor)
        Algae in Net: \(algaeInNet)
        Coral Placed: \(coralPlaced)
        Tele-Op Algae in Processor: \(TalgaeInProcessor)
        Tele-Op Algae in Net: \(TalgaeInNet)
        Tele-Op Coral Placed: \(TcoralPlaced)
        Endgame Algae in Processor: \(EalgaeInProcessor)
        Endgame Algae in Net: \(EalgaeInNet)
        Endgame Coral Placed: \(EcoralPlaced)
        Robot Status 2: \(robotStatus2)
        Finishing Position: \(finishingPosition)
        Comments: \(comments)
        """
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
