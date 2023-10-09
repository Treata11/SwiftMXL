//
//  TimewisePartTests.swift
//
//
//  Created by Treata Norouzi on 10/6/23.
//

import SwiftMXL
import XCTest
import XMLCoder

class TimewiseTests: XCTestCase {
    var decoder: XMLDecoder {
        let decoder = XMLDecoder()
            decoder.trimValueWhitespaces = false
            decoder.removeWhitespaceElements = true
        return decoder
    }
    var encoder: XMLEncoder {
        let encoder = XMLEncoder()
            encoder.outputFormatting = [.prettyPrinted]
        return encoder
    }

    // TODO: Handle the DynamicNodeEncoding of Timewise
    func testMeasureRoundTrip() {
        let xml = """
        <measure number="1">
           <part id="P1">
              <attributes>
                 <divisions>1</divisions>
                 <key>
                    <fifths>0</fifths>
                    <mode>major</mode>
                 </key>
                 <time symbol="common">
                    <beats>4</beats>
                    <beat-type>4</beat-type>
                 </time>
                 <clef>
                    <sign>G</sign>
                    <line>2</line>
                 </clef>
              </attributes>
              <note>
                 <pitch>
                    <step>G</step>
                    <octave>2</octave>
                 </pitch>
                 <duration>1</duration>
                 <voice>1</voice>
                 <type>quarter</type>
              </note>
              <note>
                 <pitch>
                    <step>A</step>
                    <octave>2</octave>
                 </pitch>
                 <duration>1</duration>
                 <voice>1</voice>
                 <type>quarter</type>
              </note>
           </part>
        </measure>
        """
        let decoded = try! decoder.decode(Timewise.Measure.self, from: xml.data(using: .utf8)!)
        let part = Timewise.Part(
            id: "P1",
            musicData: [
                .attributes(
                    Attributes(
                        divisions: 1,
                        keys: [Key(fifths: 0, mode: .major)],
                        times: [Time([Time.Signature(beats: ["4"], beatType: ["4"])], symbol: .common)],
                        clefs: [Clef(sign: .g, line: 2)]
                    )
                ),
                .note(
                    Note(
                       pitch: Pitch(step: .g, octave: 2),
                       duration: 1,
                       voice: "1",
                       type: .quarter
                   )
                ),
                .note(
                    Note(
                       pitch: Pitch(step: .a, octave: 2),
                       duration: 1,
                       voice: "1",
                       type: .quarter
                   )
                ),
            ]
        )
        let expected = Timewise.Measure(
            number: "1",
            parts: [part]
        )
        
        XCTAssertEqual(decoded, expected)
    }
}
