//
//  Router.swift
//  QuizEngine
//
//  Created by Ramzy on 27/05/2021.
//

import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(question: Question,answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question ,Answer>)
}
