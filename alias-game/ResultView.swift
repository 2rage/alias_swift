//
//  ResultView.swift
//  alias-game
//
//  Created by Konstantin Yakovlev on 02.06.2024.
//

import SwiftUI

struct ResultView: View {
    @Binding var timeRemaining: Int
    @Binding var correctAnswers: Int
    @Binding var incorrectAnswers: Int
    var resetGame: () -> Void
    
    var body: some View {
        VStack {
            Text("Время вышло!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Верных ответов: \(correctAnswers)")
                .font(.title2)
                .padding()
            
            Text("Неверных ответов: \(incorrectAnswers)")
                .font(.title2)
                .padding()
            
            Button(action: resetGame) {
                Text("Начать заново")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
