//
//  LyricFontTests.swift
//  SwiftMXLTests
//
//  Created by James Bean on 10/24/19.
//

import SwiftMXL
import XCTest
import XMLCoder

class LyricFontTests: XCTestCase {
    var decoder: XMLDecoder {
        let decoder = XMLDecoder()
//            decoder.trimValueWhitespaces = false
//            decoder.removeWhitespaceElements = true
        return decoder
    }
    var encoder: XMLEncoder {
        let encoder = XMLEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        return encoder
    }
    
    func testRoundTrip() throws {
        let lyricFont = LyricFont(
            Font(family: "Helvetica", style: .italic, size: 42, weight: .bold),
            number: 13,
            name: "Recitative"
        )
        let xml = """
            <lyric-font number="13" name="Recitative">
                <font-weight>bold</font-weight>
            </lyric-font>
        """
        // font-style="italic" font-weight="bold"
        let encoded_ = try! encoder.encode(lyricFont, withRootKey: "lyric-font")
        let decoded = try! decoder.decode(LyricFont.self, from: xml.data(using: .utf8)!)
        let encoded = try! encoder.encode(decoded, withRootKey: "lyric-font")
        let decoded2 = try? decoder.decode(LyricFont.self, from: encoded)
        
        print("""
        encoded_: \n\(String(data: encoded_, encoding: .utf8)!)
        decoded: \n\(decoded)
        encoded: \n\(String(data: encoded, encoding: .utf8)!)
        decoded2: \n\(String(describing: decoded2 ?? nil))
        """)
        
//        try testRoundTrip(lyricFont)
        XCTAssertEqual(decoded, decoded2)
    }
}
