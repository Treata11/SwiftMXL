//
//  Time.swift
//  MusicXML
//
//  Created by James Bean on 12/21/18.
//

import XMLCoder

/// Time signatures are represented by the beats element for the _numerator_ and the `beat-type` element
/// for the _denominator_.
///
/// Multiple pairs of `beat` and `beat-type` elements are used for composite time
/// signatures with multiple denominators, such as 2/4 + 3/8. A composite such as 3+2/8 requires
/// only one `beat/beat-type` pair. The `print-object` attribute allows a time signature to be specified
/// but not printed, as is the case for excerpts from the middle of a score. The value is **"yes"** if
/// not present.
///
/// > FIXME: See [Issue#2](https://github.com/Treata11/SwiftMXL/issues/2)
public struct Time {
    // MARK: Instance Properties

    // MARK: Attributes

    /// The optional number attribute refers to staff numbers within the part. If absent, the
    /// time signature applies to all staves in the part.
    public let number: Int?

    /// The symbol attribute is used indicate common and cut time symbols as well as a single number
    /// display.
    public let symbol: TimeSymbol?

    /// The time-separator attribute indicates how to display the arrangement between the beats and
    /// beat-type values in a time signature. The default value is none. The horizontal, diagonal,
    /// and vertical values represent horizontal, diagonal lower-left to upper-right, and vertical
    /// lines respectively. For these values, the beats and beat-type values are arranged on either
    /// side of the separator line. The none value represents  no separator with the beats and
    /// beat-type arranged vertically. The adjacent value represents no separator with the beats and
    /// beat-type arranged horizontally.
    public let separator: TimeSeparator?

    public let hAlign: LeftCenterRight?
    public let vAlign: VAlign?
    public let printObject: Bool?

    // MARK: Attribute Groups

    public let printStyle: PrintStyle

    // MARK: Kind

    public let kind: Kind

    // MARK: - Initializers

    public init(number: Int? = nil, symbol: TimeSymbol? = nil, separator: TimeSeparator? = nil, printStyle: PrintStyle = PrintStyle(), hAlign: LeftCenterRight? = nil, vAlign: VAlign? = nil, printObject: Bool? = nil, kind: Kind) {
        self.number = number
        self.symbol = symbol
        self.separator = separator
        self.printStyle = printStyle
        self.hAlign = hAlign
        self.vAlign = vAlign
        self.printObject = printObject
        self.kind = kind
    }
}

// MARK: - Time Extensions

extension Time {
    // MARK: Initializers
    
    /// Creates a `Measured` type `Time`.
    ///
    /// **Example Usage:**
    ///
    ///     let _ = Time(4,4)
    ///     let _ = Time(3, 16, staff: 3)
    ///
    public init(
        _ signature: [Signature],
        number: Int? = nil,
        symbol: TimeSymbol? = nil,
        seperator: TimeSeparator? = nil,
        staff: Int? = nil,
        interchangeable: Interchangeable? = nil
    ) {
        self.number = staff
        self.symbol = symbol
        self.kind = .measured(
            Measured(
                signature,
                interchangeable: interchangeable
            )
        )
        // TODO: Add remaining attributes and elements
        self.separator = nil
        self.printStyle = PrintStyle()
        self.hAlign = nil
        self.vAlign = nil
        self.printObject = nil
    }

    /// Creates an `Unmeasured` type `Time`.
    ///
    /// **Example Usage:**
    ///
    ///     let _ = Time(symbol: "XXX")
    ///
    public init(symbol: String? = nil, staff: Int? = nil) {
        self.number = staff
        self.kind = .unmeasured(Unmeasured(symbol: symbol))
        // TODO: Add remaining attributes and elements
        // TODO: correct symbol
        self.symbol = nil
        self.separator = nil
        self.printStyle = PrintStyle()
        self.hAlign = nil
        self.vAlign = nil
        self.printObject = nil
    }
}

extension Time: Equatable {}
extension Time: Codable {
    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case number
        case symbol
        case separator
        case hAlign = "halign"
        case vAlign = "valign"
        case printObject = "print-object"
        case kind = ""  // bogus!
    }
    
    // MARK: Encodable
    // FIXME: Handle `Kind` so that <kind> is not presented in the encoded xml
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(kind, forKey: .kind)
        try container.encodeIfPresent(number, forKey: .number)
        try container.encodeIfPresent(symbol, forKey: .symbol)
        try container.encodeIfPresent(separator, forKey: .separator)
//        try container.encode(printStyle, forKey: .printStyle)
        try container.encodeIfPresent(hAlign, forKey: .hAlign)
        try container.encodeIfPresent(vAlign, forKey: .vAlign)
        try container.encodeIfPresent(printObject, forKey: .printObject)
    }

    // MARK: Decodable

    public init(from decoder: Decoder) throws {
        // Decode attributes
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.number = try container.decodeIfPresent(Int.self, forKey: .number)
        self.symbol = try container.decodeIfPresent(TimeSymbol.self, forKey: .symbol)
        self.separator = try container.decodeIfPresent(TimeSeparator.self, forKey: .separator)
        self.printStyle = try PrintStyle(from: decoder)
        self.hAlign = try container.decodeIfPresent(LeftCenterRight.self, forKey: .hAlign)
        self.vAlign = try container.decodeIfPresent(VAlign.self, forKey: .vAlign)
        self.printObject = try container.decodeIfPresent(Bool.self, forKey: .printObject)
        // Decode kind
        do {
            // FIXME: Audit containers in Time.init(from: Decoder)
            let measuredKindContainer = try decoder.container(keyedBy: Measured.CodingKeys.self)
            let signatureContainer = try decoder.container(keyedBy: Signature.CodingKeys.self)
            let beats = try signatureContainer.decode([String].self, forKey: .beats)
            let beatTypes = try signatureContainer.decode([String].self, forKey: .beatType)
            let signatures = zip(beats, beatTypes).map { Time.Signature(beats: [$0], beatType: [$1]) }
            
            self.kind = .measured(
                Time.Measured(
                    signatures,
                    interchangeable: try measuredKindContainer.decodeIfPresent(Interchangeable.self,
                                                                       forKey: .interchangeable)
                )
            )
        } catch {
            let unmeasuredKindContainer = try decoder.container(keyedBy: Unmeasured.CodingKeys.self)
//            let unmeasuredKindContainer = try decoder.singleValueContainer()
            self.kind = .unmeasured(
                Time.Unmeasured(
                    symbol: try unmeasuredKindContainer.decodeIfPresent(String.self, forKey: .symbol)
//                    symbol: try unmeasuredKindContainer.decode(String.self)
                )
            )
        }
    }
}

extension Time: DynamicNodeDecoding {
    public static func nodeDecoding(for key: CodingKey) -> XMLDecoder.NodeDecoding {
        switch key {
        case CodingKeys.symbol, CodingKeys.number:
            return .attribute
        default:
            return .element
        }
    }
}

extension Time: DynamicNodeEncoding {
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        if key is XMLAttributeGroupCodingKey {
            return .attribute
        }
        switch key {
        case CodingKeys.number, CodingKeys.symbol, CodingKeys.separator, CodingKeys.hAlign, CodingKeys.vAlign, CodingKeys.printObject:
            return .attribute
        default:
            return .element
        }
    }
}

// MARK: - Time DataTypes

extension Time {
    // MARK: - Signature
    public struct Signature {
        /// The `beats` element indicates the number of beats, as found in the numerator of a time signature.
        let beats: [String]
        /// The `beat-type` element indicates the beat unit, as found in the denominator of a time signature.
        let beatType: [String]

        public init(beats: [String], beatType: [String]) {
            self.beats = beats
            self.beatType = beatType
        }
    }
    
    // MARK: - Measured
    /// > Time signatures are represented by two elements. The
    /// > beats element indicates the number of beats, as found in
    /// > the numerator of a time signature. The beat-type element
    /// > indicates the beat unit, as found in the denominator of
    /// > a time signature.
    ///
    /// > Multiple pairs of beats and beat-type elements are used for
    /// > composite time signatures with multiple denominators, such
    /// > as 2/4 + 3/8. A composite such as 3+2/8 requires only one
    /// > beats/beat-type pair.
    ///
    /// > The interchangeable element is used to represent the second
    /// > in a pair of interchangeable dual time signatures, such as
    /// > the 6/8 in 3/4 (6/8). A separate symbol attribute value is
    /// > available compared to the time element's symbol attribute,
    /// > which applies to the first of the dual time signatures.
    public struct Measured {
        // FIXME:
        var values: [Time.Signature]
        var interchangeable: Interchangeable?

        public init(_ values: [Time.Signature], interchangeable: Interchangeable? = nil) {
            self.values = values
            self.interchangeable = interchangeable
        }
    }

    // MARK: - Unmeasured
    /// > A **`senza-misura`** element explicitly indicates that no **time
    /// > signature** is present. The optional element content
    /// > indicates the symbol to be used, if any, such as an X.
    /// > The time element's `symbol` attribute is not used when a
    /// > `senza-misura` element is present.
    public struct Unmeasured {
        let symbol: String?

        public init(symbol: String? = nil) {
            self.symbol = symbol
        }
    }

    // MARK: - Time.Kind
    public enum Kind {
        case measured(Measured)
        case unmeasured(Unmeasured)
    }
}

// MARK: - .Signature Extensions

extension Time.Signature: Equatable {}
extension Time.Signature: Codable {
    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case beats
        case beatType = "beat-type"
    }
    
    // MARK: Decodable
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.beats) {
            self.beats = try container.decode([String].self, forKey: .beats)
            self.beatType = try container.decode([String].self, forKey: .beatType)
        } else {
            throw DecodingError.typeMismatch(
                Time.Signature.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unrecognized choice"
                )
            )
        }
    }
}

//extension Time.Signature: Sequence {
//    public func makeIterator() -> AnyIterator<Void> {
//        var index = 0
//        
//        return AnyIterator {
//            defer { index += 1 }
//            
//            switch index {
//            case 0:
//                return ()
//            default:
//                return nil
//            }
//        }
//    }
//}
//
//extension Time.Signature: Collection {
//    public typealias Element = Void
//    public typealias Index = Int
//    
//    public var startIndex: Index { 0 }
//    public var endIndex: Index { 1 }
//    
//    public func index(after i: Index) -> Index {
//        precondition(i == startIndex, "Signature index out of range")
//        return i + 1
//    }
//    
//    public subscript(position: Index) -> Element {
//        precondition(indices.contains(position), "Signature index out of range")
//        return ()
//    }
//}

// MARK: - .Measured Extensions

extension Time.Measured: Equatable {}
extension Time.Measured: Codable {
    // MARK: Codable

    enum CodingKeys: String, CodingKey {
//        case signature
        case interchangeable
    }
    
    // MARK: Encodable
    /// terminates the redundant `<signature>` & `<interchangeable>` in the encoded data
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        do {
            try values.forEach { try $0.encode(to: encoder) }
        } catch {
            try container.encode(interchangeable)
        }
    }

    // MARK: Decodable

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Time.Measured.CodingKeys.self)
        let signatureContainer = try decoder.container(keyedBy: Time.Signature.CodingKeys.self)
        let beats = try signatureContainer.decode([String].self, forKey: .beats)
        let beatTypes = try signatureContainer.decode([String].self, forKey: .beatType)
        let signatures = zip(beats, beatTypes).map { Time.Signature(beats: [$0], beatType: [$1]) }
    
        self.values = signatures
//        self.values = try decoder.collectArray()
        self.interchangeable = try container.decodeIfPresent(Interchangeable.self, forKey: .interchangeable)
    }
}

// MARK: - .Unmeasured Extensions

extension Time.Unmeasured: Equatable {}
extension Time.Unmeasured: Codable {
    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case symbol
    }
}

// MARK: - Time.Kind Extensions

extension Time.Kind: Equatable {}
extension Time.Kind: Codable {
    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case measured
        case unmeasured
    }

    // MARK: Encodable
    /// terminate the redundant `<measured>` & `<unmeasured>` keys in the encoded data
    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        
//        switch self {
//        case let .measured(value):
//            try container.encode(value, forKey: .measured)
//        case let .unmeasured(value):
//            try container.encode(value, forKey: .unmeasured)
//        }
    
        var container = encoder.singleValueContainer()
        
        switch self {
        case let .measured(value):
            try container.encode(value)
        case let .unmeasured(value):
            try container.encode(value)
        }
    }

    // MARK: Decodable

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            print("""
            **Time.Kind**
            decoded measured: \n\(try container.decode(Time.Measured.self, forKey: .measured))\n
            """)
            self = .measured(try container.decode(Time.Measured.self, forKey: .measured))
        } catch {
            print("""
            **Time.Kind**
            decoded unmeasured: \n\(try container.decode(Time.Unmeasured.self, forKey: .unmeasured))\n
            """)
            self = .unmeasured(try container.decode(Time.Unmeasured.self, forKey: .unmeasured))
        }
    }
}

extension Time.Kind: DynamicNodeEncoding {
    static public func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .element
    }
}
