//
//  QuestionView.swift
//  SkinSync-Home
//
//  Created by MacBook Pro on 09/01/25.
//

import SwiftUI
import Foundation

struct QuestionView: View {
    @State private var selectedAnswers: [Int: Any] = [:] // Store answers for all questions
    @State private var currentQuestionIndex = 0
    @State private var navigateToResultView = false
    var selectedImage: UIImage?
    var isAcneDetect: Bool

    @State private var questions: [Question] = [] // Load questions dynamically

    init(selectedImage: UIImage?, isAcneDetect: Bool) {
        self.selectedImage = selectedImage
        self.isAcneDetect = isAcneDetect
        _questions = State(initialValue: loadQuestions()) // Load questions into state
    }

    var body: some View {
        //NavigationStack {
            let currentQuestion = questions[currentQuestionIndex]
            
            VStack(alignment: .leading, spacing: 16) {
                Text(currentQuestion.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 161/255, green: 170/255, blue: 123/255))
                
                Text(currentQuestion.description)
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.bottom, 8)
            
                
                // Show options
                ForEach(0..<currentQuestion.options.count, id: \.self) { index in
                    Button(action: {
                        if currentQuestion.isCheckbox {
                            toggleCheckbox(for: index)
                        } else {
                            selectSingleOption(for: index)
                        }
                    }) {
                        
                        Text(currentQuestion.options[index])
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                currentQuestion.isCheckbox
                                    ? (isCheckboxSelected(index)
                                        ? Color(red: 161/255, green: 170/255, blue: 123/255).opacity(0.6)
                                        : Color(red: 217/255, green: 217/255, blue: 217/255))
                                    : (isSingleOptionSelected(index)
                                        ? Color(red: 161/255, green: 170/255, blue: 123/255).opacity(0.6)
                                        : Color(red: 217/255, green: 217/255, blue: 217/255))
                            )
                            .cornerRadius(8)
                            .foregroundColor(.black)
                    }
                }
                
                Button(action: {
                    if currentQuestionIndex < questions.count - 1 {
                        currentQuestionIndex += 1
                    } else {
                        navigateToResultView = true
                    }
                }) {
                    Text(currentQuestionIndex < questions.count - 1 ? "NEXT" : "FINISH")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .bold()
                        .background(isNextButtonEnabled() ? Color(red: 161/255, green: 170/255, blue: 123/255) : Color.gray)
                }
                .padding(.top, 30)
                .disabled(!isNextButtonEnabled())
                
                NavigationLink("", destination: ResultView(answers: getAnswers(), selectedImage: selectedImage, isAcneDetect: isAcneDetect), isActive: $navigateToResultView)
                    .hidden()
                    .navigationBarBackButtonHidden()
            }
            .onAppear {
                print("isAcneDetect onAppear:", isAcneDetect)
            }
        
            .padding()
            .background(Color.white)
        //}
    }

    // Toggle checkbox selection
    private func toggleCheckbox(for index: Int) {
        guard var selectedIndexes = selectedAnswers[currentQuestionIndex] as? Set<Int> else {
            selectedAnswers[currentQuestionIndex] = Set([index])
            return
        }
        if selectedIndexes.contains(index) {
            selectedIndexes.remove(index)
        } else {
            selectedIndexes.insert(index)
        }
        selectedAnswers[currentQuestionIndex] = selectedIndexes
    }

    // Select single option
    private func selectSingleOption(for index: Int) {
        selectedAnswers[currentQuestionIndex] = index
    }

    // Check if a checkbox is selected
    private func isCheckboxSelected(_ index: Int) -> Bool {
        guard let selectedIndexes = selectedAnswers[currentQuestionIndex] as? Set<Int> else { return false }
        return selectedIndexes.contains(index)
    }

    // Check if a single option is selected
    private func isSingleOptionSelected(_ index: Int) -> Bool {
        guard let selectedIndex = selectedAnswers[currentQuestionIndex] as? Int else { return false }
        return selectedIndex == index
    }

    // Enable the NEXT button only if valid options are selected
    private func isNextButtonEnabled() -> Bool {
        guard let answer = selectedAnswers[currentQuestionIndex] else { return false }
        if questions[currentQuestionIndex].isCheckbox {
            guard let selectedIndexes = answer as? Set<Int> else { return false }
            return !selectedIndexes.isEmpty
        } else {
            return answer is Int
        }
    }

    // Gather answers for the ResultView
    private func getAnswers() -> [String: String] {
        var answers: [String: String] = [:]
        for (index, question) in questions.enumerated() {
            if question.isCheckbox {
                if let selectedIndexes = selectedAnswers[index] as? Set<Int> {
                    answers[question.title] = selectedIndexes.map { question.options[$0] }.joined(separator: ", ")
                }
            } else if let selectedIndex = selectedAnswers[index] as? Int {
                answers[question.title] = question.options[selectedIndex]
            }
        }
        return answers
    }
}

// The Question struct and the loadQuestions function remain unchanged.
struct Question: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let options: [String]
    let isCheckbox: Bool
    let advice: [String: String]? // This is optional to handle cases where no advice is available.
}

func loadQuestions() -> [Question] {
    guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
        fatalError("Failed to locate questions.json in the bundle.")
    }
    
    do {
        let data = try Data(contentsOf: url)
        let questions = try JSONDecoder().decode([Question].self, from: data)
        return questions
    } catch {
        fatalError("Failed to decode questions.json: \(error.localizedDescription)")
    }
}
