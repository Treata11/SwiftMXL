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
    
    func testDecodingMeasured() throws {
        let xml = """
        <time>
            <beats>4</beats>
            <beat-type>4</beat-type>
        </time>
        """
        let decoded = try! XMLDecoder().decode(Time.Measured.self, from: xml.data(using: .utf8)!)
        let expected = Time.Measured(signature: Time.Signature(beats: "4", beatType: "4"))
        let encoded = try! encoder.encode(decoded, withRootKey: "time")
        
        print("""
        TimeTests:
        decoded: \n\(decoded)
        encoded: \n\(String(data: encoded, encoding: .utf8) ?? "nil")
        ------------------------------------------------------------------------
        """)
        XCTAssertEqual(decoded, expected)
    }

    func testDecodingCommon() throws {
        let xml = """
        <time symbol="common">
            <beats>4</beats>
            <beat-type>4</beat-type>
        </time>
        """
        let decoded = try! XMLDecoder().decode(Time.self, from: xml.data(using: .utf8)!)
        // Time.Measured
        let expected = Time(Time.Signature(beats: "4", beatType: "4"), symbol: .common)
        let encoded = try! encoder.encode(decoded, withRootKey: "time")
        
        print("""
        TimeTests:
        decoded: \n\(decoded)
        encoded: \n\(String(data: encoded, encoding: .utf8) ?? "nil")
        ------------------------------------------------------------------------
        """)
        XCTAssertEqual(decoded, expected)
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
        let expected = Time(Time.Signature(beats: "3+2", beatType: "8"), symbol: .singleNumber)
        let encoded = try! encoder.encode(decoded, withRootKey: "time")
        
        print("""
        TimeTests:
        decoded: \n\(decoded)
        expected: \n\(expected)
        encoded: \n\(String(data: encoded, encoding: .utf8) ?? "nil")
        ------------------------------------------------------------------------
        """)
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
        let expected = Time(Time.Signature(beats: "1", beatType: "8"), symbol: .singleNumber)
        let encoded = try! encoder.encode(decoded, withRootKey: "time")
        let expectedEncoded = try! encoder.encode(expected, withRootKey: "time")
        
        print("""
        TimeTests:
        decoded: \n\(decoded)\n
        encoded: \n\(String(data: encoded, encoding: .utf8) ?? "nil")\n
        expected: \n\(expected)\n
        expectedEncoded: \n\(String(data: expectedEncoded, encoding: .utf8)!)
        ------------------------------------------------------------------------
        """)
        XCTAssertEqual(decoded, expected)
    }
}
