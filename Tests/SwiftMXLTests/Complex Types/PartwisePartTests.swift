//
//  PartwisePartTests.swift
//  SwiftMXLTests
//
//  Created by James Bean on 8/4/19.
//

import SwiftMXL
import XCTest
import XMLCoder

class PartwisePartTests: XCTestCase {
    func testDecodingSingleMeasure() throws {
        let xml = """
        <part id="P1">
            <measure number="1">
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
            <note>
              <pitch>
                <step>B</step>
                <octave>2</octave>
              </pitch>
              <duration>1</duration>
              <voice>1</voice>
              <type>quarter</type>
            </note>
            <note>
              <pitch>
                <step>C</step>
                <octave>3</octave>
              </pitch>
              <duration>1</duration>
              <voice>1</voice>
              <type>quarter</type>
            </note>
          </measure>
        </part>
        """
        let decoded = try XMLDecoder().decode(Partwise.Part.self, from: xml.data(using: .utf8)!)
        let expected = Partwise.Part(
            id: "P1",
            measures: [
                Partwise.Measure(
                    number: "1",
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
                        .note(
                            Note(
                                pitch: Pitch(step: .b, octave: 2),
                                duration: 1,
                                voice: "1",
                                type: .quarter
                            )
                        ),
                        .note(
                            Note(
                                pitch: Pitch(step: .c, octave: 3),
                                duration: 1,
                                voice: "1",
                                type: .quarter
                            )
                        ),
                    ]
                ),
            ]
        )
        XCTAssertEqual(decoded, expected)
    }

    func testDecoding() throws {
        let xml = """
        <part id="P1">
            <measure number="1">
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
            <note>
              <pitch>
                <step>B</step>
                <octave>2</octave>
              </pitch>
              <duration>1</duration>
              <voice>1</voice>
              <type>quarter</type>
            </note>
            <note>
              <pitch>
                <step>C</step>
                <octave>3</octave>
              </pitch>
              <duration>1</duration>
              <voice>1</voice>
              <type>quarter</type>
            </note>
          </measure>
          <!--=======================================================-->
          <measure number="2">
            <note>
              <pitch>
                <step>D</step>
                <octave>3</octave>
              </pitch>
              <duration>1</duration>
              <voice>1</voice>
              <type>quarter</type>
            </note>
            <note>
              <pitch>
                <step>E</step>
                <octave>3</octave>
              </pitch>
              <duration>1</duration>
              <voice>1</voice>
              <type>quarter</type>
            </note>
            <note>
              <pitch>
                <step>F</step>
                <octave>3</octave>
              </pitch>
              <duration>1</duration>
              <voice>1</voice>
              <type>quarter</type>
            </note>
            <note>
              <pitch>
                <step>G</step>
                <octave>3</octave>
              </pitch>
              <duration>1</duration>
              <voice>1</voice>
              <type>quarter</type>
            </note>
          </measure>
        </part>
        """
        let decoded = try XMLDecoder().decode(Partwise.Part.self, from: xml.data(using: .utf8)!)
        let expected = Partwise.Part(
            id: "P1",
            measures: [
                Partwise.Measure(
                    number: "1",
                    musicData: [
                        .attributes(
                            Attributes(
                                divisions: 1,
                                keys: [
                                    Key(fifths: 0, mode: .major)
                                ],
                                times: [
                                    Time([Time.Signature(beats: ["4"], beatType: ["4"])], symbol: .common)
                                ],
                                clefs: [
                                    Clef(sign: .g, line: 2)
                                ]
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
                        .note(
                            Note(
                                pitch: Pitch(step: .b, octave: 2),
                                duration: 1,
                                voice: "1",
                                type: .quarter
                            )
                        ),
                        .note(
                            Note(
                                pitch: Pitch(step: .c, octave: 3),
                                duration: 1,
                                voice: "1",
                                type: .quarter
                            )
                        )
                    ]
                ),
                Partwise.Measure(
                    number: "2",
                    musicData: [
                        .note(
                            Note(
                                pitch: Pitch(step: .d, octave: 3),
                                duration: 1,
                                voice: "1",
                                type: .quarter
                            )
                        ),
                        .note(
                            Note(
                                pitch: Pitch(step: .e, octave: 3),
                                duration: 1,
                                voice: "1",
                                type: .quarter
                            )
                        ),
                        .note(
                            Note(
                                pitch: Pitch(step: .f, octave: 3),
                                duration: 1,
                                voice: "1",
                                type: .quarter
                            )
                        ),
                        .note(
                            Note(
                                pitch: Pitch(step: .g, octave: 3),
                                duration: 1,
                                voice: "1",
                                type: .quarter
                            )
                        )
                    ]
                ),
            ]
        )
        
        XCTAssertEqual(decoded, expected)
    }
}
