//
//  UITableViewExtension.swift
//  QuizApp
//
//  Created by Ramzy on 25/05/2021.
//

import UIKit

extension UITableView {
    func register(_ type: UITableViewCell.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(_ type: T.Type) -> T?{
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as? T
    }
}

