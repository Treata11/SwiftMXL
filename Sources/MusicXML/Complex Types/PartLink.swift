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
    
    public var hRef: URL    //
    
    public var actuate: XLinkActuate? 
    
    public var role: String?   // token?
    
    public var show: XLinkShow?
    
    public var title: String?
    
    public var type: XLinkType?
    
    // MARK: Elements
    
    public var instrumentLink: [String]
    public var groupLink: [String]
    
}

// MARK: - PartLink Extensions

extension PartLink: Equatable { }

extension PartLink: Codable { }
