//
//  Decoding.swift
//  MusicXML
//
//  Created by James Bean on 12/17/18.
//

import Foundation
import XMLCoder

extension Score {
    public static let topLevelTagKey = "topLevelTagKey"

    public enum Error: Swift.Error {
        case invalidMusicXMLString(Swift.String)
    }

// MARK: - From String
    /// Creates a `MusicXML` model from the given MusicXML-formatted `string`.
    public init(string: Swift.String) throws {
        guard let data = string.data(using: .utf8) else {
            throw Error.invalidMusicXMLString(string)
        }
        try self.init(data: data)
    }

// MARK: - From URL
    /// Creates a `MusicXML` model from the given MusicXML-formatted file at the given `url`.
    public init(url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

// MARK: - From Data
    /// Creates a `MusicXML` model from the given MusicXML-formatted `data`.
    ///
    /// > Used to **fail**; **`.partwise`** & **`.timewise`** decoding cases were not handled seperately;
    /// > `removeWhitespaceElements` was not set **true** on the `decoder`
    public init(data: Data) throws {
        var tag: Score.CodingKeys?
        let decoder = XMLDecoder(trimValueWhitespaces: false, removeWhitespaceElements: true)

        if let topLevelTag = Score.probeTopLevelTag(data: data) {
            decoder.userInfo[CodingUserInfoKey(rawValue: Score.topLevelTagKey)!] = topLevelTag
            tag = topLevelTag
        }
        
        if tag == Score.CodingKeys.partwise {
            let decodedPartwise = try decoder.decode(Partwise.self, from: data)
            self = .partwise(decodedPartwise)
        } else if tag == Score.CodingKeys.timewise {
            let decodedTimewise = try decoder.decode(Timewise.self, from: data)
            self = .timewise(decodedTimewise)
        } else {
            throw DecodingError.typeMismatch(
                Score.self,
                DecodingError.Context(
                    codingPath: [Score.CodingKeys.partwise, Score.CodingKeys.timewise],
                    debugDescription: """
                    Decoding from data failed; neither partwise nor timewise traversal was recognized
                    tag: \(String(describing: tag))
                    \(String(describing: decoder.userInfo[CodingUserInfoKey(rawValue: Score.topLevelTagKey)!]))
                    """
                )
            )
        }
    }
    
    // FIXME: There might be problems with the following funcs while attempting to find the toplvl tag in older versions of MusicXML

    /// A data probe that reads 64 bytes each pass to try to find the top level tag within the MusicXML
    private static func probeTopLevelTag(data: Data) -> Score.CodingKeys? {
        let input = InputStream(data: data)
        input.open()

        var data = Data()
        let bufferSize = 64
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)

        defer {
            buffer.deallocate()
            input.close()
        }

        while input.hasBytesAvailable {
            let read = input.read(buffer, maxLength: bufferSize)
            if read == 0 {
                return nil
            }
            data.append(buffer, count: read)

            let docTypeProbe: String
            if let probed = String(data: data, encoding: .utf8) {
                docTypeProbe = probed
            } else if let probed = String(data: data, encoding: .utf16) {
                docTypeProbe = probed
            } else {
                return nil
            }

            if let tag = findTopLevelTag(pattern: #"<!DOCTYPE ((?:score-partwise|score-timewise))"#, in: docTypeProbe) {
                return tag
            } else if let tag = findTopLevelTag(pattern: #"<((?:score-partwise|score-timewise)) version="[\d.]+">"#, in: docTypeProbe) {
                return tag
            }
        }
        return nil
    }

    /// Find top level tag provided with a pattern and a string, the pattern should contain exactly one capture group
    private static func findTopLevelTag(pattern: String, in string: String) -> Score.CodingKeys? {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsrange = NSRange(string.startIndex..<string.endIndex, in: string)
            if let match = regex.firstMatch(in: string, options: [], range: nsrange), match.numberOfRanges == 2, let captureRange = Range(match.range(at: 1), in: string), let key = Score.CodingKeys(rawValue: String(string[captureRange])) {
                return key
            }
            return nil
        } catch {
            return nil
        }
    }
}
