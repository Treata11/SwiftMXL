//
//  HelloWorld.swift
//  SwiftMXLTests
//
//  Created by James Bean on 8/9/19.
//

import SwiftMXL
import XCTest
import XMLCoder

class HelloWorld: XCTestCase {
    /// Used to **fail**; Decoding.swift implementations were incomplete.
    func testHelloWorldDecoding() throws {
        let xml = """
        <?xml version="1.0" encoding="UTF-8" standalone="no"?>
        <!DOCTYPE score-partwise PUBLIC
            "-//Recordare//DTD MusicXML 4.0 Partwise//EN"
            "http://www.musicxml.org/dtds/partwise.dtd">
        <score-partwise version="4.0">
          <part-list>
            <score-part id="P1">
              <part-name>Music</part-name>
            </score-part>
          </part-list>
          <part id="P1">
            <measure number="1">
              <attributes>
                <divisions>1</divisions>
                <key>
                  <fifths>0</fifths>
                </key>
                <time>
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
                  <step>C</step>
                  <octave>4</octave>
                </pitch>
                <duration>4</duration>
                <type>whole</type>
              </note>
            </measure>
          </part>
        </score-partwise>
        """
        let decoded_ = try? Score(string: xml)
//        let decoded = try! XMLDecoder().decode(Partwise.self, from: xml.data(using: .utf8)!)

        // Create the note
        let note = Note(pitch: Pitch(step: .c, octave: 4), duration: 4, type: .whole)
        // Create measure attributes
        let attributes = Attributes(
            divisions: 1,
            keys: [Key(fifths: 0)],
            times: [Time( [Time.Signature(beats: ["4"], beatType: ["4"])] )],
            clefs: [Clef(sign: .g, line: 2)]
        )
        // Create the measure
        let measure = Partwise.Measure(
            number: "1",
            musicData: [
                .attributes(attributes),
                .note(note),
            ]
        )
        // Create the part
        let part = Partwise.Part(id: "P1", measures: [measure])
        // Create the traversal
        let traversal = Partwise(
            partList: [
                .part(ScorePart(id: "P1", name: "Music")),
            ],
            parts: [part]
        )
        // Create the score
        let score: Score = .partwise(traversal)
        
//        print("""
//        HelloWorld.decoded: \n\(decoded)
//        ------------------------------------------------------------------------
//        HelloWorld.score: \n\(score)
//        ------------------------------------------------------------------------
//        """)

        XCTAssertEqual(decoded_, score)
//        XCTAssertEqual(decoded, decoded_)
    }
}

