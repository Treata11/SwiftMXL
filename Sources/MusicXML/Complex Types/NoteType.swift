//
//  NoteType.swift
//  MusicXML
//
//  Created by James Bean on 5/19/19.
//

/// The note-type type indicates the graphic note type. Values range from 256th to long.
public struct NoteType {
    public let value: NoteTypeValue
    public let size: SymbolSize?
}

extension NoteType: Equatable { }
extension NoteType: Decodable { }
