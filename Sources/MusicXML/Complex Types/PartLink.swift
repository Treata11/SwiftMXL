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
    
    public var hRef: URL    // Any URI
    
    public var actuate: XLinkActuate? 
    
    public var role: String?   // token?
    
    public var show: XLinkShow?
    
    public var title: String?   // token?
    
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
