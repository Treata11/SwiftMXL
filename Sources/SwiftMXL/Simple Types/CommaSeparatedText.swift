//
//  CommaSeparatedText.swift
//  MusicXML
//
//  Created by James Bean on 5/14/19.
//

import XMLCoder

// !!!: Type is incomplete and prone to cause errs!

/// The `comma-separated-text` type is used to specify a `comma-separated` list of text elements, as is
///
/// used by the `font-family` attribute.
public struct CommaSeparatedText {
    // MARK: - Instance Properties
    
    // MARK: Elements
    
    // !!!: CommaSeparatedText is failing to excert `values`
    public var value: [String]
    
    // MARK: - Initializers
    
    public init(_ value: [String]) {
        self.value = value
    }
    
    public init(value: [String]) {
        self.value = value
    }
}

// MARK: - CommaSeparatedText Extensions

extension CommaSeparatedText: Equatable { }

extension CommaSeparatedText: Codable {
    private enum CodingKeys: String, CodingKey {
        case value = ""
    }
    
    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(value, forKey: .value)
        try value.forEach { try $0.encode(to: encoder) }
    }
    
    // MARK: Decodable
    public init(from decoder: Decoder) throws {
        let singleValue = try decoder.singleValueContainer()
        
        self.value = try singleValue.decode([String].self)
    }
}

extension CommaSeparatedText: ExpressibleByArrayLiteral {
    public init(arrayLiteral values: String...) {
        self.value = values
    }
}

extension CommaSeparatedText: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.value = [value]
    }
}

//extension CommaSeparatedText: DynamicNodeEncoding {
//    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
////        switch key {
////        case CodingKeys.value: return .attribute
////        default: return .element
////        }
//        return .attribute
//    }
//}
//
//extension CommaSeparatedText: DynamicNodeDecoding {
//    public static func nodeDecoding(for key: CodingKey) -> XMLDecoder.NodeDecoding {
//        return .attribute
//    }
//}
