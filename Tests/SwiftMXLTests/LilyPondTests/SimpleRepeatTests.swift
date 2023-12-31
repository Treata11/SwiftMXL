//
//  SimpleRepeatTests.swift
//  SwiftMXLTests
//
//  Created by James Bean on 10/12/19.
//

import SwiftMXL
import XCTest
import XMLCoder

class SimpleRepeatTests: XCTestCase {
    func testBarlineRepeatBackward() throws {
        let xml = """
        <barline location="right">
          <bar-style>light-heavy</bar-style>
          <repeat direction="backward" times="5"/>
        </barline>
        """
        let decoded = try XMLDecoder().decode(Barline.self, from: xml.data(using: .utf8)!)
        let expected = Barline(
            location: .right,
            barStyle: .lightHeavy,
            repeat: Repeat(direction: .backward, times: 5)
        )
        XCTAssertEqual(decoded, expected)
    }
}
