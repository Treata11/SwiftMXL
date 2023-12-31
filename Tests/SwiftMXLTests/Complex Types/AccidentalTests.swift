//
//  AccidentalTests.swift
//  SwiftMXLTests
//
//  Created by James Bean on 8/4/19.
//

import SwiftMXL
import XCTest
import XMLCoder

class AccidentalTests: XCTestCase {
    func testDecodingSimple() throws {
        let xml = """
        <accidental>sharp</accidental>
        """
        let decoded = try XMLDecoder().decode(Accidental.self, from: xml.data(using: .utf8)!)
        let expected = Accidental.sharp
        XCTAssertEqual(decoded, expected)
    }

    func testSimple() throws {
        try testRoundTrip(Accidental.sharp)
    }

    func testDecodingPlacement() throws {
        let xml = """
        <accidental-mark placement="above">double-sharp</accidental-mark>
        """
        let expected = AccidentalMark(.doubleSharp, placement: .above)
        try assertDecoded(xml, equals: expected)
    }
}
