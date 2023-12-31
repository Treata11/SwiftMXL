//
//  ScoreInstrumentTests.swift
//  SwiftMXLTests
//
//  Created by Ben Lu on 9/26/19.
//

import SwiftMXL
import XCTest
import XMLCoder

class ScoreInstrumentTests: XCTestCase {
    func testDecoding() throws {
        let xml =
            """
            <score-instrument id="P1-I1">
                <instrument-name>Piano</instrument-name>
            </score-instrument>
            """
        let decoded = try XMLDecoder().decode(ScoreInstrument.self, from: xml.data(using: .utf8)!)
        let expected = ScoreInstrument(id: "P1-I1", name: "Piano")
        XCTAssertEqual(decoded, expected)
    }
}
