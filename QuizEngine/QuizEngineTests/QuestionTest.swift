//
//  QuestionTest.swift
//  QuizAppTests
//
//  Created by Ramzy on 28/05/2021.
//

import Foundation
import XCTest
import QuizEngine
@testable import QuizApp

class QuestionTest: XCTestCase{
    func test_hasValue_singleAnswer_returnsTypeHash() {
        let type = "a string"
        
        let sut = Question.singleAnswer(type)
        
        XCTAssertEqual(sut.hashValue,type.hashValue)
    }
    
    func test_hasValue_MultipleAnswer_returnsTypeHash() {
        let type = "a string"
        
        let sut = Question.multipleAnswer(type)
        
        XCTAssertEqual(sut.hashValue,type.hashValue)
    }
    
    func test_equal_isEqual() {
        XCTAssertEqual(Question.singleAnswer("a string"), Question.singleAnswer("a string"))
        XCTAssertEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("a string"))
    }
    
    func test_notEqual_isENotqual() {
        XCTAssertNotEqual(Question.singleAnswer("a string"), Question.singleAnswer("another string"))
        XCTAssertNotEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("another string"))
        XCTAssertNotEqual(Question.singleAnswer("a string"), Question.multipleAnswer("another string"))
    }
}
