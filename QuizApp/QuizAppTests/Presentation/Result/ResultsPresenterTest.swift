//
//  ResultsPresenterTest.swift
//  QuizAppTests
//
//  Created by Ramzy on 30/05/2021.
//

import Foundation
import XCTest
import QuizEngine
@testable import QuizApp

class ResultsPresenterTest: XCTestCase {
    let singleAnswerQuestion = Question.singleAnswer("Question 1")
    let multipleAnswerQuestion = Question.multipleAnswer("Question 2")
    
    func test_title_returnsFormattedTitlte() {
       
        let answers = [singleAnswerQuestion: ["Answer 1"],multipleAnswerQuestion: ["Answer 2","Answer 3"]]
        let result = Result.make(answers: answers, score: 1)
        let sut = ResultsPresenter(result: result, questions: [], correctAnswers: [:])
        
        XCTAssertEqual(sut.title, "Result")
    }
    
    func test_summary_withTwoQuestionsAndScoreOne_returnSummary() {
        let answers = [singleAnswerQuestion: ["Answer 1"],multipleAnswerQuestion: ["Answer 2","Answer 3"]]
        let result = Result.make(answers: answers, score: 1)
        let orderdQuestions = [singleAnswerQuestion,multipleAnswerQuestion]
        
        let sut = ResultsPresenter(result: result, questions: orderdQuestions, correctAnswers: [:])
        
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withoutQuestions_isEmpty() {
        let answers = [Question<String>: [String]]()
        let result = Result.make(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, questions: [], correctAnswers: [:])
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
        let answers = [singleAnswerQuestion: ["Answer 1"]]
        let correctAnswers = [singleAnswerQuestion: ["Answer 2"]]
        let result = Result.make(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, questions: [singleAnswerQuestion], correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Question 1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "Answer 2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "Answer 1")
    }
    
    func test_presentableAnswers_withWrongMultipleSingleAnswer_mapsAnswer() {
        let answers = [multipleAnswerQuestion: ["Answer 1","Answer 4"]]
        let correctAnswers = [multipleAnswerQuestion: ["Answer 2","Answer 3"]]
        let result = Result.make(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, questions: [multipleAnswerQuestion], correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Question 2")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "Answer 2, Answer 3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "Answer 1, Answer 4")
    }

    
    func test_presentableAnswers_withTwoQuestions_mapsOrderdAnswer() {
        let answers = [
            singleAnswerQuestion: ["Answer 2"],
            multipleAnswerQuestion: ["Answer 1","Answer 4"]
            ]
        let correctAnswers = [multipleAnswerQuestion: ["Answer 1","Answer 4"],singleAnswerQuestion: ["Answer 2"]]
        let orderdQuestions = [singleAnswerQuestion,multipleAnswerQuestion]
        let result = Result.make(answers: answers, score: 0)

        let sut = ResultsPresenter(result: result,questions: orderdQuestions,correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Question 1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "Answer 2")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)

        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.last!.question, "Question 2")
        XCTAssertEqual(sut.presentableAnswers.last!.answer, "Answer 1, Answer 4")
        XCTAssertNil(sut.presentableAnswers.last!.wrongAnswer)
    }

}
