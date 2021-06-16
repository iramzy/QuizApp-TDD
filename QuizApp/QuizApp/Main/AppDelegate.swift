//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Ramzy on 29/04/2021.
//

import UIKit
import QuizEngine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var game: Game<Question<String>, [String], NavigationControllerRouter>?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        let question1 = Question.singleAnswer("What is vin diesel's name in fast and furious ?")
//        let question2 = Question.multipleAnswer("In which movies did Lucas Black appears from the following")
//        let questions = [question1,question2]
//        let option1 = "Dominic Toretto"
//        let option2 = "Mike Toretto"
//        let option3 = "Steven Toretto"
//        let options1 = [option1,option2,option3]
//        
//        let option4 = "Fast 5"
//        let option5 = "Fast 7"
//        let option6 = "Tokyo Drift"
//        let options2 = [option4,option5,option6]
//        
//        let correctAnswer = [question1: [option1], question2: [option5, option6]]
//        
//        let navigationController = UINavigationController()
//        let factory = iOSViewControllerFactory(questions: questions, options: [question1:options1, question2:options2], correctAnswers: correctAnswer)
//        let router = NavigationControllerRouter(navigationController, factory: factory)
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
//        game = startGame(questions: questions, router: router, correctAnswer: correctAnswer)
        return true
    }
    
}

