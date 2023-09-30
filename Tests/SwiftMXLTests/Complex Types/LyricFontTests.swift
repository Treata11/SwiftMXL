//
//  LyricFontTests.swift
//  SwiftMXLTests
//
//  Created by James Bean on 10/24/19.
//

import SwiftMXL
import XCTest

class LyricFontTests: XCTestCase {
    func testRoundTrip() throws {
        let lyricFont = LyricFont(
            Font(family: "Helvetica", style: .italic, size: 42, weight: .bold),
            number: 13,
            name: "Recitative"
        )
        try testRoundTrip(lyricFont)
    }
}