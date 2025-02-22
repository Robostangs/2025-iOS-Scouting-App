//
//  QRcode.swift
//  2025-iOS-Scouting-App
//
//  Created by Sathvik Surapaneni on 2/2/25.
//

import SwiftUI

// QRCodeView
struct QRCodeView: View {
    let gameData: GameData
    @Binding var gameHistory: [GameData]
    @Binding var resetForm: Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Match Data")
                .font(.title)
                .bold()
                .foregroundColor(.orange)
            Image(uiImage: generateQRCode(from: gameData.toQRCodeString()))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text(gameData.matchNumber)
                .padding()
                .foregroundColor(.orange)
            Button(action: {
                gameHistory.append(gameData)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    resetForm = true
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Next Match")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.orange)
                .font(.title)
        })
    }
}
