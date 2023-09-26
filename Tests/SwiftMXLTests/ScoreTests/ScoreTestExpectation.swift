//
//  ScoreTestExpectation.swift
//  SwiftMXLTests
//
//  Created by Ben Lu on 10/13/19.
//

import SwiftMXL
import XCTest

protocol ScoreTestExpectation: AnyObject {
    static var expected: Score { get }
}
