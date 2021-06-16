//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Ramzy on 27/04/2021.
//

import Foundation
import XCTest
@testable import QuizEngine
class FlowTest: XCTestCase {
    let router = RouterSpy()
    
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(questions: []).start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    
    func test_start_withOneQuestions_routesToCorrectQuestion() {
        makeSUT(questions: ["Question 1"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Question 1"])
    }
    
    func test_start_withOneQuestions_routesToCorrectQuestion2() {
        makeSUT(questions: ["Question 2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Question 2"])
    }
    
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        makeSUT(questions: ["Question 1","Question 2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Question 1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let sut =  makeSUT(questions: ["Question 1","Question 2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Question 1","Question 1"])
    }
    
    
    func test_startAndAnswerFirstQuestionAndSecondQuestion_withThreeQuestions_routesToThirdQuestion() {
        let sut = makeSUT(questions: ["Question 1","Question 2","Question 3"])
        sut.start()
        
        router.answerCallback("Answer 1")
        router.answerCallback("Answer 2")
        
        XCTAssertEqual(router.routedQuestions, ["Question 1","Question 2","Question 3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotRouteToNextQuestion() {
        let sut = makeSUT(questions: ["Question 1"])
        sut.start()
        
        router.answerCallback("Answer 1")
        
        XCTAssertEqual(router.routedQuestions, ["Question 1"])
    }
    
    func test_start_withNoQuestions_routesToResult() {
        makeSUT(questions: []).start()
        
        XCTAssertEqual(router.routedResult!.answers, [:])
    }
    
    func test_start_withOneQuestion_doesNotRouteToResult() {
        makeSUT(questions: ["Question 1"]).start()
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotRouteToResult() {
        let sut = makeSUT(questions: ["Question 1","Question 2"])
        sut.start()
        
        router.answerCallback("Answer 1")
        
        XCTAssertNil(router.routedResult)
    }
    
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_routeToResult() {
        let sut = makeSUT(questions: ["Question 1","Question 2"])
        sut.start()
        
        router.answerCallback("Answer 1")
        router.answerCallback("Answer 2")
        
        XCTAssertEqual(router.routedResult!.answers, ["Question 1": "Answer 1","Question 2": "Answer 2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scores() {
        let sut = makeSUT(questions: ["Question 1","Question 2"], scoring: {_ in 10})
        sut.start()
        
        router.answerCallback("Answer 1")
        router.answerCallback("Answer 2")
        
        XCTAssertEqual(router.routedResult!.score, 10)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scoresWithRightAnswers() {
        var receivedAnswers = [String:String]()
        let sut = makeSUT(questions: ["Question 1","Question 2"], scoring: {answers in
            receivedAnswers = answers
            return 20
            
        })
        sut.start()
        
        router.answerCallback("Answer 1")
        router.answerCallback("Answer 2")
        
        XCTAssertEqual(receivedAnswers,["Question 1":"Answer 1", "Question 2": "Answer 2"])
    }
    
    // MARK:- Helpers
    
    func makeSUT(questions: [String], scoring: @escaping ([String: String]) -> Int  = {_ in  0}) -> Flow<String,String, RouterSpy> {
        return Flow(questions: questions, router: router, scoring: scoring)
    }
}

