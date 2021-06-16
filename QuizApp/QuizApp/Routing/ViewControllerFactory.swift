//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Ramzy on 29/05/2021.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
     
    func questionViewController(for question: Question<String>, answerCallback:@escaping ([String]) -> Void) -> UIViewController
    
    func resultsViewController(for result: Result<Question<String>,[String]>) -> UIViewController
}
