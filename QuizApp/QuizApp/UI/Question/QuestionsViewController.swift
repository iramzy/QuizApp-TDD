//
//  QuestionsViewController.swift
//  QuizApp
//
//  Created by Ramzy on 29/04/2021.
//

import Foundation
import UIKit

class QuestionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private(set) var question: String = ""
    private(set) var options: [String] = []
    private(set) var allowMultipleSelection = false
    private var selection: (([String]) -> Void)? = nil
    private let reuseIdentifier = "Cell"
    
    
    convenience init(question: String, options: [String],allowMultipleSelection: Bool,selection: @escaping ([String]) -> Void) {
        self.init()
        self.question = question
        self.options = options
        self.selection = selection
        self.allowMultipleSelection = allowMultipleSelection
    }
    
    override func viewDidLoad() {
        headerLabel.text = question
        tableView.allowsMultipleSelection = allowMultipleSelection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(selectedOptions(in: tableView))
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.allowsMultipleSelection {
            selection?(selectedOptions(in: tableView))
        }
    }
    
    private func selectedOptions(in tableView: UITableView) -> [String] {
        guard let indexPaths = tableView.indexPathsForSelectedRows else { return [] }
        return indexPaths.map{ options[$0.row] }
    }
    
    private func dequeueCell(in tableview: UITableView) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    
    
}
