//
//  SetupView.swift
//  alias-game
//
//  Created by Konstantin Yakovlev on 02.06.2024.
//

import SwiftUI

struct SetupView: View {
    let teams: [String]
    let difficulties: [String]
    let wordCounts: [Int]
    @Binding var selectedTeam: String
    @Binding var selectedDifficulty: String
    @Binding var wordsCount: Int
    var startGame: () -> Void
    
    var body: some View {
        VStack {
            Text("Выбор команды и уровня сложности")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Picker("Выберите команду", selection: $selectedTeam) {
                ForEach(teams, id: \.self) { team in
                    Text(team)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Picker("Выберите уровень сложности", selection: $selectedDifficulty) {
                ForEach(difficulties, id: \.self) { difficulty in
                    Text(difficulty)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Picker("Выберите количество слов", selection: $wordsCount) {
                ForEach(wordCounts, id: \.self) { count in
                    Text("\(count)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button(action: startGame) {
                Text("Начать игру")
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
    }
}
