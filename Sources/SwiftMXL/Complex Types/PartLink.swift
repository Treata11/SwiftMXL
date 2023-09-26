//
//  PartLink.swift
//  
//
//  Created by Treata Norouzi on 9/25/23.
//

import Foundation

///The `part-link` element allows MusicXML data for both score and parts to be contained
///within a single compressed MusicXML file. It links a `score-part` from a score document to
///MusicXML documents that contain parts data. In the case of a single compressed MusicXML file,
///the link href values are paths that are relative to the root folder of the zip file.
public struct PartLink {
    // MARK: - Instance Properties

    // MARK: Attributes
    
    /// The href attribute provides the data that allows an application to find a remote resource
    /// or resource fragment. See the
    /// [definition in the XML Linking Language recommendation](https://www.w3.org/TR/xlink11/#link-locators).
    public var hRef: URL    // Any URI
    /// The actuate attribute is used to communicate the desired timing of traversal from the starting
    /// resource to the ending resource. The default value is onRequest. See the
    /// [definition in the XML Linking Language recommendation](https://www.w3.org/TR/xlink11/#link-behaviors).
    public var actuate: XLinkActuate? 
    /// The role attribute indicates a property of the link. See the
    /// [definition in the XML Linking Language recommendation](https://www.w3.org/TR/xlink11/#link-semantics).
    public var role: String?   // token?
    /// The show attribute is used to communicate the desired presentation of the ending
    /// resource on traversal from the starting resource. The default value is replace. See the
    /// [definition in the XML Linking Language recommendation](https://www.w3.org/TR/xlink11/#link-behaviors).
    public var show: XLinkShow?
    /// The title attribute describes the meaning of a link or resource in a human-readable fashion.
    /// See the
    /// [definition in the XML Linking Language recommendation](https://www.w3.org/TR/xlink11/#link-semantics).
    public var title: String?   // token?
    /// The type attribute identifies XLink element types. In MusicXML, the value is always simple. See the
    /// [definition in the XML Linking Language recommendation](https://www.w3.org/TR/xlink11/#link-types).
    public var type: XLinkType?
    
    // MARK: Elements
    
    public var instrumentLink: [InstrumentLink]
    /// Multiple `part-link` elements can reference different types of linked documents,
    /// such as parts and condensed score. The optional `group-link` elements identify
    /// the groups used in the linked document. The content of a `group-link` element
    /// should match the content of a `group` element in the linked document.
    public var groupLink: [String]
    
}

// MARK: - PartLink Extensions

extension PartLink: Equatable { }

extension PartLink: Codable { }

// TODO: Create a new type on PartLink that encapsulates instrumentLink & groupLink
// TODO: Implement the codable protocol

// Ref: https://www.w3.org/2021/06/musicxml40/musicxml-reference/elements/part-link/
