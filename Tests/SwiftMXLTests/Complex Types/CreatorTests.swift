//
//  CreatorTests.swift
//  SwiftMXLTests
//
//  Created by James Bean on 8/9/19.
//

import SwiftMXL
import XCTest
import XMLCoder

class CreatorTests: XCTestCase {
    func testCreatorRoundTrip() throws {
        let creator = Creator("Hildegard von Bingen", type: "composer")
        try testRoundTrip(creator)
    }
}
