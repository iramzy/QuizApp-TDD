//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Ramzy on 29/05/2021.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    let singleAnswerQuestion = Question.singleAnswer("Question 1")
    let multipleAnswerQuestion = Question.multipleAnswer("Question 1")
    let options = ["Answer 1", "Answer 2"]
    
    func test_questionViewController_singleAnswer_createsControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion,multipleAnswerQuestion], question: singleAnswerQuestion)
        
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).title, presenter.title)
    }

    func test_questionViewController_singleAnswer_createsControllerWithQuestioin() {
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).question, "Question 1")
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        XCTAssertFalse(makeQuestionController(question: singleAnswerQuestion).allowMultipleSelection)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).title, presenter.title)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithQuestioin() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).question, "Question 1")
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithSingleSelection() {
        XCTAssertTrue(makeQuestionController(question: multipleAnswerQuestion).allowMultipleSelection)
    }
    
    func test_resultsViewController_createsControllerWithTitle() {
        let results = makeResults()
        
        
        XCTAssertEqual(results.controller.title, results.presenter.title)
    }
    
    func test_resultsViewController_createsControllerWithSummary() {
        let results = makeResults()
        
        
        XCTAssertEqual(results.controller.summary, results.presenter.summary)
    }
    
    func test_resultsViewController_createsControllerWithPresentableAnswers() {

        let results = makeResults()
        
        XCTAssertEqual(results.controller.answers.count, results.presenter.presentableAnswers.count)
    }
    
    // MARK:- Helpers
    
    func makeSUT(options: [Question<String>: [String]] = [:],correctAnswers: [Question<String>: [String]] = [:]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: [singleAnswerQuestion,multipleAnswerQuestion],options: options,correctAnswers: correctAnswers)
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionsViewController {
        return makeSUT(options: [question:options]).questionViewController(for: question, answerCallback: {_ in}) as! QuestionsViewController
    }
    
    func makeResults() -> (controller: ResultsViewController, presenter: ResultsPresenter) {
        let userAnswers = [singleAnswerQuestion: ["Answer 1"], multipleAnswerQuestion: ["Answer 1", "Answer 2"]]
        let correctAnswers = [singleAnswerQuestion: ["Answer 1"], multipleAnswerQuestion: ["Answer 1", "Answer 2"]]
        let questions = [singleAnswerQuestion,multipleAnswerQuestion]
        let result = Result.make(answers: userAnswers , score: 2)
        let presenter = ResultsPresenter(result: result, questions: questions , correctAnswers: correctAnswers)
        let sut = makeSUT(correctAnswers: correctAnswers)
        let controller = sut.resultsViewController(for: result) as! ResultsViewController
        
        return (controller,presenter)
    }

}

