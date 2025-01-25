//
// ContentView.swift
// reefscape rough draft
//
// Created by Krishiv Vaidya on 1/11/25.
//
import SwiftUI
import CoreImage.CIFilterBuiltins
struct ContentView: View {
  @State private var studentID = ""
  @State private var teamNumber = ""
  @State private var matchNumber = ""
  // Autonomous
  @State private var leftStarting = "No"
  private let leftStartingOptions = ["No", "Yes"]
  @State private var autoT1 = 0
  @State private var autoT2 = 0
  @State private var autoT3 = 0
  @State private var autoT4 = 0
  @State private var autoAlgaeT1 = 0
  @State private var autoAlgaeT2 = 0
  // Tele-Op
  @State private var defenseBot = "No"
  private let defenseBotOptions = ["No", "Yes"]
  @State private var teleT1 = 0
  @State private var teleT2 = 0
  @State private var teleT3 = 0
  @State private var teleT4 = 0
  @State private var teleAlgaeT1 = 0
  @State private var teleAlgaeT2 = 0
  @State private var teleAlgaeT3 = 0
  // Endgame
  @State private var finishingPosition = "None"
  private let finishingPositionOptions = ["N/A", "Parked", "Shallow", "Deep"]
  @State private var comments = ""
  @State private var resetForm = false
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 15) {
          // Header
          Text("ReefScape Scouting App")
            .font(.largeTitle)
            .bold()
            .foregroundColor(.blue)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
          Text("548 Northville Robostangs")
            .font(.title2)
            .bold()
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
          // Student Information
          Group {
            TextField("Student ID", text: $studentID)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .padding(.horizontal)
            TextField("Team Number", text: $teamNumber)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .padding(.horizontal)
            TextField("Match Number", text: $matchNumber)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .padding(.horizontal)
          }
          // Autonomous Section
          SectionHeader(title: "Autonomous")
          HStack {
            Text("Left Starting:")
              .font(.headline)
              .frame(width: 150, alignment: .leading)
            Picker("", selection: $leftStarting) {
              ForEach(leftStartingOptions, id: \.self) {
                Text($0)
              }
            }
            .pickerStyle(SegmentedPickerStyle())
          }
          .padding(.horizontal)
          SectionHeader(title: "Coral")
          TFieldsSection(titlePrefix: "Auto", t1: $autoT1, t2: $autoT2, t3: $autoT3, t4: $autoT4)
          SectionHeader(title: "Algae")
          VStack {
            Stepper("Algae P: \(autoAlgaeT1)", value: $autoAlgaeT1, in: 0...100)
              .padding(.horizontal)
            Stepper("Algae N: \(autoAlgaeT2)", value: $autoAlgaeT2, in: 0...100)
              .padding(.horizontal)
          }
          // Tele-Op Section
          SectionHeader(title: "Tele-Op")
          HStack {
            Text("Defense Bot:")
              .font(.headline)
              .frame(width: 150, alignment: .leading)
            Picker("", selection: $defenseBot) {
              ForEach(defenseBotOptions, id: \.self) {
                Text($0)
              }
            }
            .pickerStyle(SegmentedPickerStyle())
          }
          .padding(.horizontal)
          SectionHeader(title: "Coral")
          TFieldsSection(titlePrefix: "Tele", t1: $teleT1, t2: $teleT2, t3: $teleT3, t4: $teleT4)
          SectionHeader(title: "Algae")
          VStack {
            Stepper("Algae P: \(teleAlgaeT1)", value: $teleAlgaeT1, in: 0...100)
              .padding(.horizontal)
            Stepper("Algae N: \(teleAlgaeT2)", value: $teleAlgaeT2, in: 0...100)
              .padding(.horizontal)
          }
          // Endgame Section
          SectionHeader(title: "Endgame")
          Picker("Finishing Position", selection: $finishingPosition) {
            ForEach(finishingPositionOptions, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          .padding(.horizontal)
          TextField("Comments", text: $comments)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
          // QR Code Generation
          NavigationLink(destination: QRCodeView(data: generateDataString(), resetForm: $resetForm)) {
            Text("Submit")
              .bold()
              .frame(maxWidth: .infinity)
              .padding()
              .background(Color.blue)
              .foregroundColor(.white)
              .cornerRadius(10)
          }
          .padding()
        }
      }
      .onChange(of: resetForm) { newValue in
        if newValue {
          clearForm()
          resetForm = false
        }
      }
    }
  }
  private func generateDataString() -> String {
    let data = [
      studentID,
      teamNumber,
      matchNumber,
      leftStarting,
      "\(autoT1)",
      "\(autoT2)",
      "\(autoT3)",
      "\(autoT4)",
      "\(autoAlgaeT1)",
      "\(autoAlgaeT2)",
      defenseBot,
      "\(teleT1)",
      "\(teleT2)",
      "\(teleT3)",
      "\(teleT4)",
      "\(teleAlgaeT1)",
      "\(teleAlgaeT2)",
      "\(teleAlgaeT3)",
      finishingPosition,
      comments
    ]
    return data.joined(separator: ",")
  }
  private func clearForm() {
    studentID = ""
    teamNumber = ""
    matchNumber = ""
    leftStarting = "No"
    autoT1 = 0
    autoT2 = 0
    autoT3 = 0
    autoT4 = 0
    autoAlgaeT1 = 0
    autoAlgaeT2 = 0
    defenseBot = "No"
    teleT1 = 0
    teleT2 = 0
    teleT3 = 0
    teleT4 = 0
    teleAlgaeT1 = 0
    teleAlgaeT2 = 0
    teleAlgaeT3 = 0
    finishingPosition = "None"
    comments = ""
  }
}
struct SectionHeader: View {
  let title: String
  var body: some View {
    Text(title)
      .font(.title2)
      .bold()
      .foregroundColor(.blue)
      .multilineTextAlignment(.center)
      .frame(maxWidth: .infinity)
      .padding(.top)
  }
}
struct TFieldsSection: View {
  let titlePrefix: String
  @Binding var t1: Int
  @Binding var t2: Int
  @Binding var t3: Int
  @Binding var t4: Int
  var body: some View {
    VStack {
      Stepper("\(titlePrefix) T1: \(t1)", value: $t1, in: 0...100)
        .padding(.horizontal)
      Stepper("\(titlePrefix) T2: \(t2)", value: $t2, in: 0...100)
        .padding(.horizontal)
      Stepper("\(titlePrefix) T3: \(t3)", value: $t3, in: 0...100)
        .padding(.horizontal)
      Stepper("\(titlePrefix) T4: \(t4)", value: $t4, in: 0...100)
        .padding(.horizontal)
    }
  }
}
struct QRCodeView: View {
  let data: String
  @Binding var resetForm: Bool
  var body: some View {
    VStack {
      Text("QR Code")
        .font(.title)
        .bold()
      Image(uiImage: generateQRCode(from: data))
        .interpolation(.none)
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
      Text(data)
        .padding()
      Button(action: {
        resetForm = true
      }) {
        Text("Clear")
          .bold()
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(10)
      }
      .padding()
    }
  }
}
func generateQRCode(from string: String) -> UIImage {
  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()
  filter.message = Data(string.utf8)
  if let outputImage = filter.outputImage,
    let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
    return UIImage(cgImage: cgImage)
  }
  return UIImage(systemName: "xmark.circle") ?? UIImage()
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}









