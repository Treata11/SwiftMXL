//
//  Beats.swift
//
//
//  Created by Treata Norouzi on 10/3/23.
//

public struct Beats: Equatable {
    
    // MARK: - Instance Properties
    /// The `beats` element indicates the number of beats, as found in the numerator of a time signature.
    public let beats: String
    /// The `beat-type` element indicates the beat unit, as found in the denominator of a time signature.
    public let beatType: String
    
    // MARK: - Intializers
    
    public init(beats: String, beatType: String) {
        self.beats = beats
        self.beatType = beatType
    }
    
    public init(_ beats: String, _ beatType: String) {
        self.beats = beats
        self.beatType = beatType
    }
}

extension Beats: Codable {
       // MARK: - Codable
       
       public enum CodingKeys: String, CodingKey {
           case beats
           case beatType = "beat-type"
       }
    
    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(beats, forKey: .beats)
        try container.encode(beatType, forKey: .beatType)
    }
    
    // MARK: Decodable

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        func decode <T>(_ key: CodingKeys) throws -> T where T: Codable {
            return try container.decode(T.self, forKey: key)
        }
        
        self.beats = try container.decode(String.self, forKey: .beats)
        self.beatType = try container.decode(String.self, forKey: .beatType)
        
        // If contains one, both elements must be present
        // bogus probably, try to decode an array of beats & beattypes
//        if container.contains(.beats) {
//            self.beats = try container.decode(String.self, forKey: .beats)
//            self.beatType = try container.decode(String.self, forKey: .beatType)
//        } else {
//            throw DecodingError.typeMismatch(
//                Encoding.Kind.self,
//                DecodingError.Context(
//                    codingPath: decoder.codingPath,
//                    debugDescription: "Unrecognized choice"
//                )
//            )
//        }
    }
}

import XMLCoder

extension Beats: DynamicNodeEncoding {
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .element
    }
}

//extension Beats: DynamicNodeDecoding {
//    public static func nodeDecoding(for key: CodingKey) -> XMLCoder.XMLDecoder.NodeDecoding {
//        return .elementOrAttribute
//    }
//}
