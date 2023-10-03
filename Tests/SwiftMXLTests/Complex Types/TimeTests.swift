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
        let expected = Time.Measured(signature: Time.Signature(beats: 4, beatType: 4))
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
        let expected = Time(4, 4, symbol: .common)
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
        let decoded = try! XMLDecoder(trimValueWhitespaces: false, removeWhitespaceElements: true)
            .decode(Time.self, from: xml.data(using: .utf8)!)
        // Time.Measured
        let expected = Time(3+2, 8, symbol: .singleNumber)
        let encoded = try! encoder.encode(decoded, withRootKey: "time")
        
        print("""
        TimeTests:
        decoded: \n\(decoded)
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
        // Time.Measured
        let expected = Time(1, 8, symbol: .singleNumber)
        let encoded = try! encoder.encode(decoded, withRootKey: "time")
        
        print("""
        TimeTests:
        decoded: \n\(decoded)
        encoded: \n\(String(data: encoded, encoding: .utf8) ?? "nil")
        expected: \n\(expected)
        ------------------------------------------------------------------------
        """)
        XCTAssertEqual(decoded, expected)
    }
}
