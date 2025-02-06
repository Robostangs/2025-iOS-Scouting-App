//
//  CostomStepper.swift
//  2025-iOS-Scouting-App
//
//  Created by Sathvik Surapaneni on 2/1/25.
//
// CustomStepper View

import SwiftUI

struct CustomStepper: View {
    let label: String
    @Binding var value: Int
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.orange)
            Spacer()
            Button(action: {
                if value > 0 {
                    value -= 1
                }
            }) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.red)
                    .font(.title2)
            }
            Text("\(value)")
                .foregroundColor(.orange)
                .frame(width: 50)
            Button(action: {
                value += 1
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.green)
                    .font(.title2)
            }
        }
        .padding(.horizontal)
    }
}
