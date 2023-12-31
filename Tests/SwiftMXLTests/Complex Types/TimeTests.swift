//
//  TimeTests.swift
//  SwiftMXLTests
//
//  Created by James Bean on 8/4/19.
//

import SwiftMXL
import XCTest
import XMLCoder

class TimeTests: XCTestCase {
    var encoder: XMLEncoder {
        let encoder = XMLEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        return encoder
    }

    func testDecodingSingleNumber() throws {
        let xml = """
        <time symbol="single-number">
          <beats>3+2</beats>
          <beat-type>8</beat-type>
        </time>
        """
        let decoded = try XMLDecoder(trimValueWhitespaces: false, removeWhitespaceElements: true)
            .decode(Time.self, from: xml.data(using: .utf8)!)
        // Time.Measured
        let expected = Time([Time.Signature(beats: ["3+2"], beatType: ["8"])], symbol: .singleNumber)
//        let encoded = try! encoder.encode(decoded, withRootKey: "time")
        
        XCTAssertEqual(decoded, expected)
    }
    
    func testDecodingComplex() throws {
        let xml = """
        <time symbol="single-number">
          <beats>1</beats>
          <beat-type>8</beat-type>
          <beats>2</beats>
          <beat-type>4</beat-type>
        </time>
        """
        let decoded = try! XMLDecoder(trimValueWhitespaces: false, removeWhitespaceElements: true)
            .decode(Time.self, from: xml.data(using: .utf8)!)
        // Time.Measured(signature: Time.Signature(beats: 1, beatType: 8)) works
        // but the following does not function to encode the beats & beatType.
        // the decoding works fine for both.
        let expected = Time(
            [Time.Signature(beats: ["1"], beatType: ["8"]), Time.Signature(beats: ["2"], beatType: ["4"])],
            symbol: .singleNumber
        )
//        let encoded = try! encoder.encode(decoded, withRootKey: "time")
//        let expectedEncoded = try! encoder.encode(expected, withRootKey: "time")
        
        XCTAssertEqual(decoded, expected)
    }
    
    // MARK: - Time.Measured Tests
    
    func testDecodingMeasured() throws {
        let xml = """
        <time>
            <beats>3</beats>
            <beat-type>4</beat-type>
            <beats>1</beats>
            <beat-type>8</beat-type>
        </time>
        """
        let decoded = try XMLDecoder().decode(Time.Measured.self, from: xml.data(using: .utf8)!)
        let expected = Time.Measured([Time.Signature(beats: ["3"], beatType: ["4"]), Time.Signature(beats: ["1"], beatType: ["8"])])
//        let encoded = try! encoder.encode(decoded, withRootKey: "time")
        
        XCTAssertEqual(decoded, expected)
    }
}
