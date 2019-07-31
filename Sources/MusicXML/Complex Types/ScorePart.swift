//
//  ScorePart.swift
//  MusicXML
//
//  Created by James Bean on 5/28/19.
//

/// Each MusicXML part corresponds to a track in a Standard MIDI Format 1 file. The score-instrument
/// elements are used when there are multiple instruments per track. The midi-device element is used
/// to make a MIDI device or port assignment for the given track or specific MIDI instruments.
/// Initial midi-instrument assignments may be made here as well.
#warning("TODO: Add support for ScorePart print-style, print-object, and justify")
public struct ScorePart {

    public let id: String

    /// Identification contains basic metadata about the score. It includes the information in
    /// MuseData headers that may apply at a score-wide, movement-wide, or part-wide level. The
    /// creator, rights, source, and relation elements are based on Dublin Core.
    public let identification: Identification?

    /// The part-name type describes the name or abbreviation of a score-part element. Formatting
    /// attributes for the part-name element are deprecated in Version 2.0 in favor of the new
    /// part-name-display and part-abbreviation-display elements.
    public let name: PartName

    /// The part-name-display and part-abbreviation-display elements used in the score.mod file may
    /// also be used here to change how a part name or abbreviation is displayed over the course of
    /// a piece. They take effect when the current measure or a succeeding measure starts a new
    /// system.
    public let nameDisplay: NameDisplay?

    /// The part-name-display and part-abbreviation-display elements used in the score.mod file may
    /// also be used here to change how a part name or abbreviation is displayed over the course of
    /// a piece. They take effect when the current measure or a succeeding measure starts a new
    /// system.
    public let partAbbreviation: PartName?

    /// The part-name-display and part-abbreviation-display elements used in the score.mod file may
    /// also be used here to change how a part name or abbreviation is displayed over the course of
    /// a piece. They take effect when the current measure or a succeeding measure starts a new
    /// system.
    public let partAbbreviationDisplay: NameDisplay?

    /// The group element allows the use of different versions of the part for different purposes.
    /// Typical values include score, parts, sound, and data. Ordering information that is directly
    /// encoded in MuseData can be derived from the ordering within a MusicXML score or opus.
    public let group: [String]

    /// The score-instrument type represents a single instrument within a score-part. As with the
    /// score-part type, each score-instrument has a required ID attribute, a name, and an optional
    /// abbreviation. A score-instrument type is also required if the score specifies MIDI 1.0
    /// channels, banks, or programs. An initial midi-instrument assignment can also be made here.
    /// MusicXML software should be able to automatically assign reasonable channels and instruments
    /// without these elements in simple cases, such as where part names match General MIDI
    /// instrument names.
    public let scoreInstrument: [ScoreInstrument]

    public let midi: [MIDI]
}

extension ScorePart {
    public struct MIDI {
        /// The midi-device type corresponds to the DeviceName meta event in Standard MIDI Files.
        /// Unlike the DeviceName meta event, there can be multiple midi-device elements per
        /// MusicXML part starting in MusicXML 3.0.
        public let midiDevice: MIDIDevice?

        /// The midi-instrument type defines MIDI 1.0 instrument playback. The midi-instrument
        /// element can be a part of either the score-instrument element at the start of a part, or
        /// the sound element within a part. The id attribute refers to the score-instrument
        /// affected by the change.
        public let midiInstrument: MIDIInstrument?
    }
}

extension ScorePart.MIDI: Equatable { }
extension ScorePart.MIDI: Decodable { }

extension ScorePart: Equatable { }
extension ScorePart: Decodable { }

//extension PartList.ScorePart: Decodable {
//
//    // MARK: - Decodable
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case identification
//        case name = "part-name"
//        case nameDisplay = "part-name-display"
//    }
//}