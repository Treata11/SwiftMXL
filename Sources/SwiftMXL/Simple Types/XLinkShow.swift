//
//  XLinkShow.swift
//  
//
//  Created by Treata Norouzi on 9/25/23.
//

// FIXME: Implement the data type entirely

/// See the definition in the XML [Linking Language recommendation](https://www.w3.org/TR/xlink11/#link-behaviors).
///
/// Base type: [NMTOKEN](https://www.w3.org/2021/06/musicxml40/musicxml-reference/data-types/xsd-NMTOKEN/)
public enum XLinkShow {
    case new
    case replace
    case embed
    case other
    case non
}

// MARK: - Extensions

extension XLinkShow: Equatable { }

extension XLinkShow: Codable { }
