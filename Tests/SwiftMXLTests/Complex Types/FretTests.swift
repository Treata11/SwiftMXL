//
//  FretTests.swift
//  SwiftMXLTests
//
//  Created by James Bean on 10/24/19.
//

import SwiftMXL
import XCTest

class FretTests: XCTestCase {
    func testRoundTrip() throws {
        let fret = Fret(3,
                        color: Color(hexValue: 0xFFFFFF),
                        font: Font(style: .italic, weight: .bold))
        try testRoundTrip(fret, loggingEncoded: true)
    }
}
