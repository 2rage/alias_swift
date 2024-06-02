//
//  ContentView.swift
//  alias-game
//
//  Created by Konstantin Yakovlev on 02.06.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var words: [String] = []
    @State private var currentWord = ""
    @State private var timeRemaining = 60
    @State private var showingResult = false
    @State private var selectedTeam: String = ""
    @State private var selectedDifficulty: String = "Легкий"
    @State private var isGameStarted = false
    @State private var correctAnswers = 0
    @State private var incorrectAnswers = 0
    @State private var wordsCount = 20
    
    @State private var timer: Timer?
    
    let teams = ["Команда 1", "Команда 2"]
    let difficulties = ["Легкий", "Средний", "Сложный"]
    let wordCounts = [20, 50, 100]
    
    var body: some View {
        NavigationView {
            VStack {
                if isGameStarted {
                    GameView(
                        currentWord: $currentWord,
                        timeRemaining: $timeRemaining,
                        nextWord: nextWord,
                        correctAnswers: $correctAnswers,
                        incorrectAnswers: $incorrectAnswers,
                        showingResult: $showingResult,
                        exitToMenu: exitToMenu
                    )
                } else {
                    SetupView(
                        teams: teams,
                        difficulties: difficulties,
                        wordCounts: wordCounts,
                        selectedTeam: $selectedTeam,
                        selectedDifficulty: $selectedDifficulty,
                        wordsCount: $wordsCount,
                        startGame: startGame
                    )
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingResult) {
                ResultView(timeRemaining: $timeRemaining, correctAnswers: $correctAnswers, incorrectAnswers: $incorrectAnswers, resetGame: resetGame)
            }
        }
    }
    
    func startGame() {
        loadWords()
        nextWord()
        startTimer()
        isGameStarted = true
    }
    
    func resetGame() {
        stopTimer()
        timeRemaining = 60
        isGameStarted = false
        selectedTeam = ""
        selectedDifficulty = "Легкий"
        correctAnswers = 0
        incorrectAnswers = 0
        wordsCount = 20
    }
    
    func exitToMenu() {
        stopTimer()
        timeRemaining = 60
        isGameStarted = false
        correctAnswers = 0
        incorrectAnswers = 0
    }
    
    func nextWord(correct: Bool = false) {
        if correct {
            correctAnswers += 1
        } else {
            incorrectAnswers += 1
        }
        if correctAnswers + incorrectAnswers < wordsCount {
            if !words.isEmpty {
                currentWord = words.removeFirst()
            } else {
                currentWord = "Слова закончились!"
            }
        } else {
            stopTimer()
            showingResult = true
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                timer.invalidate()
                self.showingResult = true
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func loadWords() {
        let easyWords = ["яблоко", "банан", "машина", "кот", "собака", "компьютер"]
        let mediumWords = ["автомобиль", "технология", "исследование", "баланс", "проект"]
        let hardWords = ["инновация", "философия", "спецификация", "архитектура", "стратегия"]
        
        switch selectedDifficulty {
        case "Легкий":
            words = Array(repeating: easyWords, count: (wordsCount / easyWords.count) + 1).flatMap { $0 }.shuffled()
        case "Средний":
            words = Array(repeating: mediumWords, count: (wordsCount / mediumWords.count) + 1).flatMap { $0 }.shuffled()
        case "Сложный":
            words = Array(repeating: hardWords, count: (wordsCount / hardWords.count) + 1).flatMap { $0 }.shuffled()
        default:
            words = Array(repeating: easyWords, count: (wordsCount / easyWords.count) + 1).flatMap { $0 }.shuffled()
        }
    }
}
