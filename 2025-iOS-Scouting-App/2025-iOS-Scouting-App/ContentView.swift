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
    @State private var autoT1 = 0
    @State private var autoT2 = 0
    @State private var autoT3 = 0
    @State private var autoT4 = 0
    @State private var autoAlgaeT1 = 0
    @State private var autoAlgaeT2 = 0
    @State private var defenseBot = "No"
    @State private var teleT1 = 0
    @State private var teleT2 = 0
    @State private var teleT3 = 0
    @State private var teleT4 = 0
    @State private var teleAlgaeBarge = 0
    @State private var teleAlgaeProccesor = 0
    @State private var teleAlgaeHPA = 0
    @State private var teleAlgaeHPM = 0
    @State private var finishingPosition = "None"
    @State private var comments = ""
    @Binding var gameHistory: [GameData]
    @Binding var resetForm: Bool
    let options = ["No", "Yes"]
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
            _autoT1 = State(initialValue: game.autoT1)
            _autoT2 = State(initialValue: game.autoT2)
            _autoT3 = State(initialValue: game.autoT3)
            _autoT4 = State(initialValue: game.autoT4)
            _autoAlgaeT1 = State(initialValue: game.autoAlgaeT1)
            _autoAlgaeT2 = State(initialValue: game.autoAlgaeT2)
            _defenseBot = State(initialValue: game.defenseBot)
            _teleT1 = State(initialValue: game.teleT1)
            _teleT2 = State(initialValue: game.teleT2)
            _teleT3 = State(initialValue: game.teleT3)
            _teleT4 = State(initialValue: game.teleT4)
            _teleAlgaeBarge = State(initialValue: game.teleAlgaeBarge)
            _teleAlgaeProccesor = State(initialValue: game.teleAlgaeProccesor)
            _teleAlgaeHPA = State(initialValue: game.teleAlgaeHPA)
            _teleAlgaeHPM = State(initialValue: game.teleAlgaeHPM)
            _finishingPosition = State(initialValue: game.finishingPosition)
            _comments = State(initialValue: game.comments)
        }
    }

    private func createSubmitString() -> String {
        return """
        \(studentName),
        \(teamNumber),
        \(matchNumber),
        \(robotStatus),
        \(autoT1),
        \(autoT2),
        \(autoT3),
        \(autoT4),
        \(autoAlgaeT1),
        \(autoAlgaeT2),
        \(defenseBot),
        \(teleT1),
        \(teleT2),
        \(teleT3),
        \(teleT4),
        \(teleAlgaeBarge),
        \(teleAlgaeProccesor),
        \(teleAlgaeHPA),
        \(teleAlgaeHPM),
        \(finishingPosition),
        \(comments),
        """
    }

    private func clearForm() {
        studentName = ""
        teamNumber = ""
        matchNumber = ""
        robotStatus = "Not Selected"
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
        teleAlgaeBarge = 0
        teleAlgaeProccesor = 0
        teleAlgaeHPA = 0
        teleAlgaeHPM = 0
        finishingPosition = "None"
        comments = ""
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                // Group 1: Header
                headerSection

                // Group 2: Student Information
                studentInformationSection

                // Group 3: Autonomous Section
                autonomousSection

                // Group 4: Tele-Op Section
                teleOpSection

                // Group 5: Endgame and Submit Section
                endgameAndSubmitSection
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onChange(of: resetForm) { oldValue, newValue in
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

    private var headerSection: some View {
        Group {
            Text("Reefscape Scouting App")
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
        }
    }

    private var studentInformationSection: some View {
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
    }

    private var autonomousSection: some View {
        Group {
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
                CustomStepper(label: "Auto T1", value: $autoT1)
                CustomStepper(label: "Auto T2", value: $autoT2)
                CustomStepper(label: "Auto T3", value: $autoT3)
                CustomStepper(label: "Auto T4", value: $autoT4)
            }
            SectionHeader(title: "Algae")
            VStack(spacing: 10) {
                CustomStepper(label: "Auto Algae Barge", value: $autoAlgaeT1)
                CustomStepper(label: "Auto Algae Processor", value: $autoAlgaeT2)
            }
        }
    }

    private var teleOpSection: some View {
        Group {
            SectionHeader(title: "Tele-Op")
            HStack {
                Text("Defense Bot:")
                    .font(.headline)
                    .foregroundColor(.orange)
                    .frame(width: 150, alignment: .leading)
                Picker("", selection: $defenseBot) {
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
                CustomStepper(label: "Tele T1", value: $teleT1)
                CustomStepper(label: "Tele T2", value: $teleT2)
                CustomStepper(label: "Tele T3", value: $teleT3)
                CustomStepper(label: "Tele T4", value: $teleT4)
            }
            SectionHeader(title: "Algae")
            VStack(spacing: 10) {
                CustomStepper(label: "Tele Algae Barge", value: $teleAlgaeBarge)
                CustomStepper(label: "Tele Algae Proccesor", value: $teleAlgaeProccesor)
                CustomStepper(label: "Tele Algae HPA", value: $teleAlgaeHPA)
                CustomStepper(label: "Tele Algae HPM", value: $teleAlgaeHPM)
            }
        }
    }

    private var endgameAndSubmitSection: some View {
        VStack(spacing: 15) {
            // Endgame Section
            endgameSection
            // Submit Button
            submitButton
        }
    }

    private var endgameSection: some View {
        Group {
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
        }
    }

    private var submitButton: some View {
        NavigationLink(destination: QRCodeView(gameData: GameData(
            studentName: studentName,
            teamNumber: teamNumber,
            matchNumber: matchNumber,
            robotStatus: robotStatus,
            autoT1: autoT1,
            autoT2: autoT2,
            autoT3: autoT3,
            autoT4: autoT4,
            autoAlgaeT1: autoAlgaeT1,
            autoAlgaeT2: autoAlgaeT2,
            defenseBot: defenseBot,
            teleT1: teleT1,
            teleT2: teleT2,
            teleT3: teleT3,
            teleT4: teleT4,
            teleAlgaeBarge: teleAlgaeBarge,
            teleAlgaeProccesor: teleAlgaeProccesor,
            teleAlgaeHPA: teleAlgaeHPA,
            teleAlgaeHPM: teleAlgaeHPM,
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
