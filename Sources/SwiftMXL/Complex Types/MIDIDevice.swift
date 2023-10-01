//
//  MIDIDevice.swift
//  MusicXML
//
//  Created by James Bean on 5/16/19.
//

import XMLCoder

/// The `midi-device` type corresponds to the DeviceName meta event in Standard MIDI Files. Unlike the
/// DeviceName meta event, there can be multiple midi-device elements per MusicXML part starting in
/// MusicXML 3.0.
public struct MIDIDevice {
    // MARK: - Instance Properties

    // MARK: Attributes

    /// The **optional** port attribute is a number from 1 to 16 that can be used with the unofficial
    /// MIDI port (or cable) meta event.
    public var port: Int?
    /// The optional id attribute refers to the score-instrument assigned to this device. If
    /// missing, the device assignment affects all score-instrument elements in the score-part.
    public var id: String?

    // MARK: Value

    // !!!: Should value be optional<String>?
    public var value: String

    // MARK: - Initializers

    public init(_ value: String = "", port: Int? = nil, id: String? = nil) {
        self.value = value
        self.port = port
        self.id = id
    }
}

extension MIDIDevice: Equatable { }

extension MIDIDevice: Codable {
    // MARK: - Codable

    enum CodingKeys: String, CodingKey, XMLChoiceCodingKey {
        case id
        case port
        case value = ""
    }
}

extension MIDIDevice: DynamicNodeEncoding {
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        switch key {
        case CodingKeys.id, CodingKeys.port:
            return .attribute
        default:
            return .element
        }
    }
}
