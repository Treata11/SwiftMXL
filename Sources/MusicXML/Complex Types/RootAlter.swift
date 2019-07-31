//
//  RootAlter.swift
//  MusicXML
//
//  Created by James Bean on 5/28/19.
//

/// The root-alter type represents the chromatic alteration of the root of the current chord within
/// the harmony element. In some chord styles, the text for the root-step element may include
/// root-alter information. In that case, the print-object attribute of the root-alter element can
/// be set to no.
public struct RootAlter {
    public let value: Double?
    public let printObject: Bool?
    public let printStyle: PrintStyle?
    public let location: LeftRight?

}

extension RootAlter: Equatable { }
extension RootAlter: Decodable { }