//
//  Untitled.swift
//  2025-iOS-Scouting-App
//
//  Created by Sathvik Surapaneni on 2/1/25.
//

import SwiftUI

struct WelcomeScreen: View {
    @Binding var showWelcomeScreen: Bool
    @State private var fadeOut = false

    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to the Reefscape Scouting App")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.orange)
                .multilineTextAlignment(.center)
                .padding()
            Image("robostangs_logo") // Make sure the image is added to your assets with this name
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure the VStack takes up the entire screen
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Make the background black and cover all edges
        .opacity(fadeOut ? 0 : 1)
        .onAppear {
            // Start the fade-out animation after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeOut(duration: 0.75)) {
                    fadeOut = true
                }
                // Transition to MainMenuView after the fade-out animation completes
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    showWelcomeScreen = false
                }
            }
        }
    }
}
