#if !canImport(ObjectiveC)
import XCTest

extension AccidentalTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__AccidentalTests = [
        ("testDecodingSimple", testDecodingSimple),
    ]
}

extension AttributesTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__AttributesTests = [
        ("testDecoding", testDecoding),
    ]
}

extension BarlineTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BarlineTests = [
        ("testDecodingSimple", testDecodingSimple),
    ]
}

extension IdentificationTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__IdentificationTests = [
        ("testDecoding", testDecoding),
    ]
}

extension KeyTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__KeyTests = [
        ("testDecodingTraditional", testDecodingTraditional),
    ]
}

extension MiscellaneousTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__MiscellaneousTests = [
        ("testDecoding", testDecoding),
        ("testMiscellaneousRoundTrip", testMiscellaneousRoundTrip),
    ]
}

extension MusicDataTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__MusicDataTests = [
        ("testDecodingAttributes", testDecodingAttributes),
        ("testDecodingDivisions", testDecodingDivisions),
    ]
}

extension NoteTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__NoteTests = [
        ("testNoteAccidentalDecoding", testNoteAccidentalDecoding),
        ("testNoteDecoding", testNoteDecoding),
    ]
}

extension PartListTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PartListTests = [
        ("testDecoding", testDecoding),
    ]
}

extension PartNameTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PartNameTests = [
        ("testDecoding", testDecoding),
    ]
}

extension PartwiseMeasureTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PartwiseMeasureTests = [
        ("testDecodingAttributes", testDecodingAttributes),
        ("testDecodingEmpty", testDecodingEmpty),
        ("testDecodingNotes", testDecodingNotes),
    ]
}

extension PartwisePartTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PartwisePartTests = [
        ("testDecoding", testDecoding),
        ("testDecodingSingleMeasure", testDecodingSingleMeasure),
    ]
}

extension Partwise_01_Pitches {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__Partwise_01_Pitches = [
        ("testNoThrows", testNoThrows),
    ]
}

extension PitchTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PitchTests = [
        ("testHighFQuarterSharpRoundTrip", testHighFQuarterSharpRoundTrip),
        ("testMiddleCRoundTrip", testMiddleCRoundTrip),
    ]
}

extension ScorePartTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ScorePartTests = [
        ("testDecoding", testDecoding),
    ]
}

extension TimeTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__TimeTests = [
        ("testDecodingCommon", testDecodingCommon),
        ("testDecodingMeasured", testDecodingMeasured),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AccidentalTests.__allTests__AccidentalTests),
        testCase(AttributesTests.__allTests__AttributesTests),
        testCase(BarlineTests.__allTests__BarlineTests),
        testCase(IdentificationTests.__allTests__IdentificationTests),
        testCase(KeyTests.__allTests__KeyTests),
        testCase(MiscellaneousTests.__allTests__MiscellaneousTests),
        testCase(MusicDataTests.__allTests__MusicDataTests),
        testCase(NoteTests.__allTests__NoteTests),
        testCase(PartListTests.__allTests__PartListTests),
        testCase(PartNameTests.__allTests__PartNameTests),
        testCase(PartwiseMeasureTests.__allTests__PartwiseMeasureTests),
        testCase(PartwisePartTests.__allTests__PartwisePartTests),
        testCase(Partwise_01_Pitches.__allTests__Partwise_01_Pitches),
        testCase(PitchTests.__allTests__PitchTests),
        testCase(ScorePartTests.__allTests__ScorePartTests),
        testCase(TimeTests.__allTests__TimeTests),
    ]
}
#endif
