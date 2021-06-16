//
//  ResultHelper.swift
//  QuizAppTests
//
//  Created by Ramzy on 28/05/2021.
//

@testable import QuizEngine

extension Result: Hashable {
    static func make(answers:  [Question: Answer], score: Int) -> Result<Question,Answer> {
        return Result(answers: answers, score: score)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
    
    public static func == (lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
