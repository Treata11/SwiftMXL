//
//  FretTests.swift
//  SwiftMXLTests
//
//  Created by James Bean on 10/24/19.
//

import SwiftMXL
import XCTest
import XMLCoder

class FretTests: XCTestCase {
    var decoder: XMLDecoder {
        let decoder = XMLDecoder()
            decoder.trimValueWhitespaces = false
            decoder.removeWhitespaceElements = true
        return decoder
    }
    var encoder: XMLEncoder {
        let encoder = XMLEncoder()
//            encoder.outputFormatting = [.prettyPrinted]
        return encoder
    }
    
    func testRoundTrip() throws {
//        let fret = Fret(
//            3, color: Color(hexValue: 0xFFFFFF),
//            font: Font(style: .italic, weight: .bold)
//        )
//        let fret_ = Fret(3)
        // FIXME: How to write a fret element with all of its attributes present in a String? (formatting)
        let xml = """
        <fret>3</fret>
        """
        let decoded = try? decoder.decode(Fret.self, from: xml.data(using: .utf8)!)
        let encoded = try! encoder.encode(decoded, withRootKey: "fret")
        let decoded2 = try? decoder.decode(Fret.self, from: encoded)
    
//        XCTAssertEqual(xml, String(data: encoded, encoding: .utf8)!)
        XCTAssertEqual(decoded, decoded2)
        
//        try testRoundTrip(fret, loggingEncoded: true)
    }
}
