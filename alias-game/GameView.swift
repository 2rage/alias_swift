//
//  GameView.swift
//  alias-game
//
//  Created by Konstantin Yakovlev on 02.06.2024.
//

import SwiftUI

struct GameView: View {
    @Binding var currentWord: String
    @Binding var timeRemaining: Int
    var nextWord: (Bool) -> Void
    @Binding var correctAnswers: Int
    @Binding var incorrectAnswers: Int
    @Binding var showingResult: Bool
    var exitToMenu: () -> Void
    
    var body: some View {
        VStack {
            Text("ALIAS")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text(currentWord)
                .font(.title)
                .padding()
            
            Text("Оставшееся время: \(timeRemaining)")
                .font(.title2)
                .padding()
            
            HStack {
                Button(action: { nextWord(true) }) {
                    Text("Верно")
                        .font(.title2)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Button(action: { nextWord(false) }) {
                    Text("Неверно")
                        .font(.title2)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            
            Button(action: exitToMenu) {
                Text("Выйти в меню")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .gesture(
            DragGesture(minimumDistance: 20)
                .onEnded { value in
                    if value.translation.height < 0 {
                        nextWord(false)
                    } else if value.translation.height > 0 {
                        nextWord(true)
                    }
                }
        )
    }
}
