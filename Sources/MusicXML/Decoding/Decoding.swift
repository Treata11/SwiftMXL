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

    // !!!: It's always failing!
    public enum Error: Swift.Error {
        case invalidMusicXMLString(Swift.String)
    }

    /// Creates a `MusicXML` model from the given MusicXML-formatted `string`.
    public init(string: Swift.String) throws {
        guard let data = string.data(using: .utf8) else {
            // !!!: The data couldn’t be read because it isn’t in the correct format.
            throw Error.invalidMusicXMLString(string)
        }
        try self.init(data: data)
    }

    /// Creates a `MusicXML` model from the given MusicXML-formatted file at the given `url`.
    public init(url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    /// Creates a `MusicXML` model from the given MusicXML-formatted `data`.
    public init(data: Data) throws {
        let decoder = XMLDecoder(trimValueWhitespaces: false)

        if let topLevelTag = Score.probeTopLevelTag(data: data) {
            decoder.userInfo[CodingUserInfoKey(rawValue: Score.topLevelTagKey)!] = topLevelTag
        }

        self = try decoder.decode(Score.self, from: data)
    }

    // A data probe that reads 64 bytes each pass to try to find the top level tag within the MusicXML
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

    // Find top level tag provided with a pattern and a string, the pattern should contain exactly one capture group
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
    
// MARK: - HearMeOut
    
//    func decodeScoreFrom(_ url: URL) {
//        measureIndex = 0
//        originalScore = parserManager.parseFromUrl(url: url)
//        generateStaffDictionary()
//
//        generateFocusArray()
//    }
    
    static func decode<T: Decodable>(type: T.Type, from url: URL) throws -> T {
        let string = try String(contentsOf: url)
        let data = string.data(using: .utf8)!
        let decoder = XMLDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type, from: data)
    }
    
}

// MARK: - ParserBase

// TODO: New File
// Base class that is used to consume foundCharacters via the parser
class ParserBase : NSObject, XMLParserDelegate  {

    var currentElement = ""
    var foundCharacters = ""
    weak var parent: ParserBase? = nil

    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String]
    ) {

        currentElement = elementName
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if (string.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
            foundCharacters += string
        }
        
    }
}

// MARK: - ParserManager

//class ParserManager {
//    let url: URL = Bundle.main.url(forResource: "Chant" , withExtension: "musicxml")!
//
//    init() { }
//
//    func parseFromUrl(url: URL) -> ScorePartwise? {
////        guard url.startAccessingSecurityScopedResource() else { return nil }
//        print("URL EXT 2 \(url)")
//
//        do {
//            let string = try String(contentsOf: url)
//            let data = string.data(using: .utf8)!
//            let parser = XMLParser(data: data)
//
//            let score = ScorePartwise
//            parser.delegate = score
//
//            parser.parse()
////            url.stopAccessingSecurityScopedResource()
//            return score
//            //print("SCORE: \(score.work.workTitle)")
//        } catch {
//            print(error.localizedDescription)
//        }
//        return nil
//    }
//}

// MARK: - ScoreModel

///import XMLCoder

struct MusicXMLDecoder {
    
    static func decode<T: Decodable>(type: T.Type, from url: URL) throws -> T {
        let string = try String(contentsOf: url)
        let data = string.data(using: .utf8)!
        let decoder = XMLDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type, from: data)
    }
}

struct Encoding_: Codable {
    let software: String?
    let encodingDate: String?
    let supports: [Supports]?
    
    enum CodingKeys: String, CodingKey {
        case software = "software"
        case encodingDate = "encoding-date"
        case supports = "supports"
    }
}
