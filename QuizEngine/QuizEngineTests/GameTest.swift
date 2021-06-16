//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Ramzy on 27/05/2021.
//

import Foundation
import XCTest
import QuizEngine

class GameTest: XCTestCase {
    let router = RouterSpy()
    
    var game: Game<String,String,RouterSpy>!
    
    override func setUp() {
        super.setUp()
        
        game = startGame(questions: ["Question 1","Question 2"],router: router, correctAnswer:["Question 1":"Answer 1", "Question 2": "Answer 2"])
    }
    
    func test_startGame_answerZeroOutOfTwoCorrectly_scoresZero() {
        router.answerCallback("Answer 3")
        router.answerCallback("Answer 3")
        
        XCTAssertEqual(router.routedResult!.score, 0)
    }
    
    func test_startGame_answerOneOutOfTwoCorrectly_scoresOne() {
        router.answerCallback("Answer 1")
        router.answerCallback("Answer 3")
        
        XCTAssertEqual(router.routedResult!.score, 1)
    }
    
    func test_startGame_answerTwoOutOfTwoCorrectly_scoresTwo() {
        router.answerCallback("Answer 1")
        router.answerCallback("Answer 2")
        
        XCTAssertEqual(router.routedResult!.score, 2)
    }
    
    
    
}
