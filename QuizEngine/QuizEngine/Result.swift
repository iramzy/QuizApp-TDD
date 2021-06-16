//
//  Result.swift
//  QuizEngine
//
//  Created by Ramzy on 27/05/2021.
//

import Foundation

public struct Result<Question: Hashable,Answer> {
    public let answers: [Question: Answer]
    public let score: Int

    

}
