//
//  XLinkType.swift
//  
//
//  Created by Treata Norouzi on 9/25/23.
//

// FIXME: Implement it completely

/// See the definition in the XML [Linking Language recommendation](https://www.w3.org/TR/xlink11/#link-types).
/// MusicXML only supports the simple type.
///
/// Base type: [NMTOKEN](https://www.w3.org/2021/06/musicxml40/musicxml-reference/data-types/xsd-NMTOKEN/)
public enum XLinkType {
    case simple
}

// MARK: - Extensions

extension XLinkType: Equatable { }

extension XLinkType: Codable { }
