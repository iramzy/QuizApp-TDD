//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by Ramzy on 30/05/2021.
//

import Foundation
import QuizEngine

struct ResultsPresenter {
    let result: Result<Question<String>, [String]>
    let questions: [Question<String>]
    let correctAnswers: [Question<String>: [String]]
    
    var title: String {
        return "Result"
    }
    
    var summary: String {
        return "You got \(result.score)/\(questions.count) correct"
    }
    
    var presentableAnswers: [PresentableAnswer] {
        return questions.map { (question) in
            guard let userAnswers = result.answers[question],
                  let correctAnswer = correctAnswers[question] else {
                fatalError("Could not find correct answer for question: \(question)")
            }
            return presentableAnswer(question, userAnswers, correctAnswer)
        }
    }
    
    private func presentableAnswer(_ question: Question<String>,_ userAnswers: [String],_ correctAnswer: [String]) -> PresentableAnswer {
        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value):
            return PresentableAnswer(question: value,
                                     answer: formattedAnswer(correctAnswer),
                                     wrongAnswer: formattedWrongAnswer(userAnswers, correctAnswer))
        }
    }
    
    private func formattedAnswer(_ answers: [String]) -> String {
        return answers.joined(separator: ", ")
    }
    
    private func formattedWrongAnswer(_ userAnswers: [String],_ correctAnswer: [String]) -> String? {
        return correctAnswer == userAnswers ? nil : userAnswers.joined(separator: ", ")
    }
}
