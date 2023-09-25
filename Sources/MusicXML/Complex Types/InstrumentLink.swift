//
//  InstrumentLink.swift
//  
//
//  Created by Treata Norouzi on 9/25/23.
//

// FIXME: Implement the data type entirely

/// Multiple `part-link` elements can link a condensed part within a score file
/// to multiple MusicXML parts files. For example, a "Clarinet 1 and 2" part in a
/// score file could link to separate "Clarinet 1" and "Clarinet 2" part files.
/// The `instrument-link` element distinguishes which of
/// the `score-instrument`s within a `score-part` are in which part file.
public struct InstrumentLink {
    // MARK: - Instance Properties

    // MARK: Attributes
    /// Refers to a `score-instrument` **id** attribute.
    public var id: String
}

extension InstrumentLink: Equatable { }

extension InstrumentLink: Codable { }
