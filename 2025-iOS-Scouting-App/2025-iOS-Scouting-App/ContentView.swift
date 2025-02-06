//
// ContentView.swift
// reefscape rough draft
//
// Created by Krishiv Vaidya on 1/11/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

// MainMenuView
struct MainMenuView: View {
    @Binding var gameHistory: [GameData]
    @Binding var resetForm: Bool
    @State private var searchQuery = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("Main Menu")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.orange)
                    .padding(.top, 50)
                VStack {
                    // Button to go to the scouting page and reset the form
                    NavigationLink(destination: ContentView(game: nil, gameHistory: $gameHistory, resetForm: $resetForm)) {
                        Text("Next Match")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .simultaneousGesture(TapGesture().onEnded {
                        resetForm = true
                    })

                    // New Button to go to the scouting page without resetting the form
                    NavigationLink(destination: ContentView(game: nil, gameHistory: $gameHistory, resetForm: .constant(false))) {
                        Text("Resume Scouting")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    // Search bar
                    TextField("Search Match Number", text: $searchQuery)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .frame(width: 200) // Adjust the width as needed
                    
                    // Filtered list of saved games
                    List(filteredGames) { game in
                        NavigationLink(destination: ContentView(game: game, gameHistory: $gameHistory, resetForm: .constant(false))) {
                            HStack {
                                Text(game.teamNumber)
                                    .foregroundColor(.orange)
                                Spacer()
                                Text("Match \(game.matchNumber)")
                                    .foregroundColor(.orange)
                            }
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                            .border(Color.orange, width: 2) // Add border to the list item
                        }
                        .listRowBackground(Color.black) // Set the list row background color to black
                    }
                    .background(Color.black) // Set the list background color to black
                    .scrollContentBackground(.hidden) // Ensure the list items' background is black
                }
                Spacer()
                Image("robostangs_logo") // Make sure the image is added to your assets with this name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding(.top, 20)
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }

    var filteredGames: [GameData] {
        if searchQuery.isEmpty {
            return gameHistory
        } else {
            return gameHistory.filter { $0.matchNumber.contains(searchQuery) }
        }
    }
}

// ContentView
struct ContentView: View {
    @State private var studentName = ""
    @State private var teamNumber = ""
    @State private var matchNumber = ""
    @State private var robotStatus = "Not Selected"
    @State private var algaeInProcessor = 0
    @State private var algaeInNet = 0
    @State private var coralPlaced = 0
    @State private var TalgaeInProcessor = 0
    @State private var TalgaeInNet = 0
    @State private var TcoralPlaced = 0
    @State private var EalgaeInProcessor = 0
    @State private var EalgaeInNet = 0
    @State private var EcoralPlaced = 0
    @State private var robotStatus2 = "P"
    @State private var comments = ""
    @State private var finishingPosition = "None"
    @Binding var gameHistory: [GameData]
    @Binding var resetForm: Bool
    let options = ["Yes", "No"]
    let finishingPositionOptions = ["None", "Parked", "Shallow", "Deep"]

    var game: GameData?
    @Environment(\.presentationMode) var presentationMode
    
    init(game: GameData?, gameHistory: Binding<[GameData]>, resetForm: Binding<Bool>) {
        self.game = game
        self._gameHistory = gameHistory
        self._resetForm = resetForm
        if let game = game {
            _studentName = State(initialValue: game.studentName)
            _teamNumber = State(initialValue: game.teamNumber)
            _matchNumber = State(initialValue: game.matchNumber)
            _robotStatus = State(initialValue: game.robotStatus)
            _algaeInProcessor = State(initialValue: game.algaeInProcessor)
            _algaeInNet = State(initialValue: game.algaeInNet)
            _coralPlaced = State(initialValue: game.coralPlaced)
            _TalgaeInProcessor = State(initialValue: game.TalgaeInProcessor)
            _TalgaeInNet = State(initialValue: game.TalgaeInNet)
            _TcoralPlaced = State(initialValue: game.TcoralPlaced)
            _EalgaeInProcessor = State(initialValue: game.EalgaeInProcessor)
            _EalgaeInNet = State(initialValue: game.EalgaeInNet)
            _EcoralPlaced = State(initialValue: game.EcoralPlaced)
            _robotStatus2 = State(initialValue: game.robotStatus2)
            _comments = State(initialValue: game.comments)
            _finishingPosition = State(initialValue: game.finishingPosition)
        }
    }

    private func createSubmitString() -> String {
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

    private func clearForm() {
        studentName = ""
        teamNumber = ""
        matchNumber = ""
        robotStatus = "Not Selected"
        algaeInProcessor = 0
        algaeInNet = 0
        coralPlaced = 0
        TalgaeInProcessor = 0
        TalgaeInNet = 0
        TcoralPlaced = 0
        EalgaeInProcessor = 0
        EalgaeInNet = 0
        EcoralPlaced = 0
        robotStatus2 = "P"
        finishingPosition = "None"
        comments = ""
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                // Header
                Text("ReefScape Scouting App")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                Text("548 Northville Robostangs")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                // Student Information
                Group {
                    TextField("Student Name", text: $studentName)
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
                        .foregroundColor(.orange)
                        .frame(width: 150, alignment: .leading)
                    Picker("", selection: $robotStatus) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .foregroundColor(Color.black)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                SectionHeader(title: "Coral")
                VStack(spacing: 10) {
                    CustomStepper(label: "Auto T1", value: $algaeInProcessor)
                    CustomStepper(label: "Auto T2", value: $algaeInNet)
                    CustomStepper(label: "Auto T3", value: $coralPlaced)
                }
                SectionHeader(title: "Algae")
                VStack(spacing: 10) {
                    CustomStepper(label: "Auto Algae T1", value: $algaeInProcessor)
                    CustomStepper(label: "Auto Algae T2", value: $algaeInNet)
                }
                // Tele-Op Section
                SectionHeader(title: "Tele-Op")
                HStack {
                    Text("Defense Bot:")
                        .font(.headline)
                        .foregroundColor(.orange)
                        .frame(width: 150, alignment: .leading)
                    Picker("", selection: $robotStatus2) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color.white)
                }
                .padding(.horizontal)
                SectionHeader(title: "Coral")
                VStack(spacing: 10) {
                    CustomStepper(label: "Tele T1", value: $TalgaeInProcessor)
                    CustomStepper(label: "Tele T2", value: $TalgaeInNet)
                    CustomStepper(label: "Tele T3", value: $TcoralPlaced)
                }
                SectionHeader(title: "Algae")
                VStack(spacing: 10) {
                    CustomStepper(label: "Tele Algae T1", value: $TalgaeInProcessor)
                    CustomStepper(label: "Tele Algae T2", value: $TalgaeInNet)
                    CustomStepper(label: "Tele Algae T3", value: $TcoralPlaced)
                }
                // Endgame Section
                SectionHeader(title: "Endgame")
                HStack {
                    Text("Finishing Position:")
                        .font(.headline)
                        .foregroundColor(.orange)
                        .frame(width: 150, alignment: .leading)
                    Picker("", selection: $finishingPosition) {
                        ForEach(finishingPositionOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color.white)
                }
                .padding(.horizontal)
                TextField("Comments", text: $comments)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                NavigationLink(destination: QRCodeView(gameData: GameData(
                    studentName: studentName,
                    teamNumber: teamNumber,
                    matchNumber: matchNumber,
                    robotStatus: robotStatus,
                    algaeInProcessor: algaeInProcessor,
                    algaeInNet: algaeInNet,
                    coralPlaced: coralPlaced,
                    TalgaeInProcessor: TalgaeInProcessor,
                    TalgaeInNet: TalgaeInNet,
                    TcoralPlaced: TcoralPlaced,
                    EalgaeInProcessor: EalgaeInProcessor,
                    EalgaeInNet: EalgaeInNet,
                    EcoralPlaced: EcoralPlaced,
                    robotStatus2: robotStatus2,
                    finishingPosition: finishingPosition,
                    comments: comments
                ), gameHistory: $gameHistory, resetForm: $resetForm)) {
                    Text("Submit")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onChange(of: resetForm) { newValue in
            if newValue {
                clearForm()
                resetForm = false
            }
        }
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "line.horizontal.3")
                .foregroundColor(.orange)
                .font(.title)
        })
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .foregroundColor(.orange)
    }
}

// SectionHeader View
struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.title2)
            .bold()
            .foregroundColor(.orange)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(.top)
    }
}
