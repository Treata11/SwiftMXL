//
//  FormattedText.swift
//  MusicXML
//
//  Created by James Bean on 5/15/19.
//

/// The `formatted-text` type represents a text element with `text-formatting` attributes.
public struct FormattedText {
    // MARK: - Instance Properties

    // MARK: Attributes

    public let direction: TextDirection?
    public let enclosure: EnclosureShape?
    public let hAlign: LeftCenterRight?
    public let justify: LeftCenterRight?
    public let letterSpacing: NumberOrNormal?
    public let lineHeight: NumberOrNormal?
    /// Int substituted instead of original Type, NumberOfLines.
    public let lineThrough: Int?
    /// Int substituted instead of original Type, NumberOfLines.
    public let overline: Int?
    public let rotation: Double?
    /// Int substituted instead of original Type, NumberOfLines.
    public let underline: Int?
    public let vAlign: VAlign?
    // FIXME: XMLLang?
    public let xmlLang: String?
    // FIXME: XMLSpace?
    public let xmlSpace: String?

    // MARK: Attribute Groups
    /// Encapsulates Color, Position and Font related attributes
    public let printStyle: PrintStyle

    // MARK: Value

    public let value: String

    // MARK: - Initializers

    public init(
        _ value: String,
        justify: LeftCenterRight? = nil,
        printStyle: PrintStyle = PrintStyle(),
        hAlign: LeftCenterRight? = nil,
        vAlign: VAlign? = nil,
        underline: Int? = nil,
        overline: Int? = nil,
        lineThrough: Int? = nil,
        rotation: Double? = nil,
        letterSpacing: NumberOrNormal? = nil,
        lineHeight: NumberOrNormal? = nil,
        direction: TextDirection? = nil,
        enclosure: EnclosureShape? = nil,
        xmlLang: String? = nil,
        xmlSpace: String? = nil
    ) {
        self.value = value
        self.justify = justify
        self.printStyle = printStyle
        self.hAlign = hAlign
        self.vAlign = vAlign
        self.underline = underline
        self.overline = overline
        self.lineThrough = lineThrough
        self.rotation = rotation
        self.letterSpacing = letterSpacing
        self.lineHeight = lineHeight
        self.direction = direction
        self.enclosure = enclosure
        self.xmlLang = xmlLang
        self.xmlSpace = xmlSpace
    }
}

extension FormattedText: Equatable { }

extension FormattedText: Codable {
    // MARK: - Codable

    private enum CodingKeys: String, CodingKey, XMLChoiceCodingKey {
        case justify
        case hAlign = "halign"
        case vAlign = "valign"
        case underline
        case overline
        case lineThrough = "line-through"
        case rotation
        case letterSpacing = "letter-spacing"
        case lineHeight = "line-height"
        case direction = "dir"
        case enclosure
        case value = ""
        case xmlLang = "xml:lang"
        case xmlSpace = "xml:space"
    }

    // MARK: Decodable

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode value
        self.value = try container.decode(String.self, forKey: .value)

        // Decode attribute groups
        self.printStyle = try PrintStyle(from: decoder)

        // Decode one-off attributes
        self.justify = try container.decodeIfPresent(LeftCenterRight.self, forKey: .justify)
        self.hAlign = try container.decodeIfPresent(LeftCenterRight.self, forKey: .hAlign)
        self.vAlign = try container.decodeIfPresent(VAlign.self, forKey: .vAlign)
        self.underline = try container.decodeIfPresent(Int.self, forKey: .underline)
        self.overline = try container.decodeIfPresent(Int.self, forKey: .overline)
        self.lineThrough = try container.decodeIfPresent(Int.self, forKey: .lineThrough)
        self.rotation = try container.decodeIfPresent(Double.self, forKey: .rotation)
        self.letterSpacing = try container.decodeIfPresent(NumberOrNormal.self, forKey: .letterSpacing)
        self.lineHeight = try container.decodeIfPresent(NumberOrNormal.self, forKey: .lineHeight)
        self.direction = try container.decodeIfPresent(TextDirection.self, forKey: .direction)
        self.enclosure = try container.decodeIfPresent(EnclosureShape.self, forKey: .enclosure)
        self.xmlLang = try container.decodeIfPresent(String.self, forKey: .xmlLang)
        self.xmlSpace = try container.decodeIfPresent(String.self, forKey: .xmlSpace)
    }
}

extension FormattedText: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

import XMLCoder

extension FormattedText: DynamicNodeEncoding {
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        switch key {
        case CodingKeys.value:
            return .element
        default:
            return .attribute
        }
    }
}
