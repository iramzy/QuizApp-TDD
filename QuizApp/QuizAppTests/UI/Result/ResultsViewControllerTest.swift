//
//  ResultsViewControllerTest.swift
//  QuizAppTests
//
//  Created by Ramzy on 23/05/2021.
//

import Foundation
import XCTest
@testable import QuizApp

class ResultsViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renderSummary() {
        XCTAssertEqual(makeSUT(summary: "a summary").headerLabel.text, "a summary")
    }
    
    
    func test_viewDidLoad_renderAnswers() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    
    func test_viewDidLoad_withCorrectAnswer_configureCell() {
        let answer = makeAnswer(question: "Question 1",answer: "Answer 1")
        let sut = makeSUT(answers: [answer])

        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Question 1")
        XCTAssertEqual(cell?.answerLabel.text, "Answer 1")
    }
    
    
    func test_viewDidLoad_withWrongAnswer_configureCell() {
        let answer = makeAnswer(question: "Question 1",answer: "Answer 1",wrongAnswer: "wrong")
        let sut = makeSUT(answers: [answer])

        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Question 1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "Answer 1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
     
    }
    
    
    // MARK:- Helpers
    
    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController{
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }

    
    func makeAnswer(question: String = "",answer: String = "",wrongAnswer: String? = nil) -> PresentableAnswer {
        return PresentableAnswer(question: question,answer: answer , wrongAnswer: wrongAnswer)
    }
}
