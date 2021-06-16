//
//  QuestionsViewControllerTests.swift
//  QuizAppTests
//
//  Created by Ramzy on 29/04/2021.
//

import Foundation
import XCTest

@testable import QuizApp

class QuestionsViewControllerTests: XCTestCase {

    func test_viewDidLoad_rendersQuestionHeaderText() {
        let sut = makeSUT(question: "Question 1")
        
        XCTAssertEqual(sut.headerLabel.text, "Question 1")
    }
    
    func test_viewDidLoad_renderOptions() {

        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["Answer 1"]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_rendersOptionsText() {
        XCTAssertEqual(makeSUT(options: ["Answer 1","Answer 2"]).tableView.title(at: 0), "Answer 1")
        XCTAssertEqual(makeSUT(options: ["Answer 1","Answer 2"]).tableView.title(at: 1), "Answer 2")
    }
    
    func test_viewDidLoad_withSingleSelection_configuresTableView() {
        XCTAssertFalse(makeSUT(options: ["Answer 1","Answer 2"],allowMultipleSelection: false).tableView.allowsMultipleSelection)
    }

    func test_viewDidLoad_withMultipleSelection_configuresTableView() {
        XCTAssertTrue(makeSUT(options: ["Answer 1","Answer 2"],allowMultipleSelection: true).tableView.allowsMultipleSelection)
    }
    
    func test_optionSelected_withSingleSelection_notifiesDelegateWithLastSelection() {
        var recivedAnswer = [String]()
        let sut = makeSUT(options:["Answer 1","Answer 2"],allowMultipleSelection: false) { recivedAnswer = $0 }
      
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(recivedAnswer, ["Answer 1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(recivedAnswer, ["Answer 2"])
    }
    
    func test_optionDeselected_withSingleSelection_doesNotNotifiesDelegateWithEmpty() {

        var callbackCount = 0
        let sut = makeSUT(options:["Answer 1","Answer 2"],allowMultipleSelection: false) {_ in callbackCount += 1}
    
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_optionSelected_withMultipleSelectionEnabled_notifiesDelegateSelection() {
        var recivedAnswer = [String]()
        let sut = makeSUT(options:["Answer 1","Answer 2"],allowMultipleSelection: true) { recivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(recivedAnswer, ["Answer 1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(recivedAnswer, ["Answer 1","Answer 2"])
    }
    
    func test_optionDeselected_withMultipleSelectionEnabled_notifiesDelegate() {
        var recivedAnswer = [String]()
        let sut = makeSUT(options:["Answer 1","Answer 2"],allowMultipleSelection: true) { recivedAnswer = $0 }
    
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(recivedAnswer, ["Answer 1"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(recivedAnswer, [])
    }
    
    // MARK:- Helpers
    func makeSUT(question: String = "",
                 options:[String] = [],
                 allowMultipleSelection: Bool = false,
                 selection: @escaping ([String]) -> Void = {_ in}
                ) -> QuestionsViewController {
        let sut = QuestionsViewController(question: question, options: options,allowMultipleSelection: allowMultipleSelection,selection: selection)
        _ = sut.view
        return sut
    }
    
}

