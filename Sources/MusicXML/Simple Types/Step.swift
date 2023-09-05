//
//  Step.swift
//  MusicXML
//
//  Created by James Bean on 5/14/19.
//

/// The step type represents a step of the diatonic scale, represented using the English letters A
/// through G.
public enum Step: String, CaseIterable {
    case a = "A"
    case b = "B"
    case c = "C"
    case d = "D"
    case e = "E"
    case f = "F"
    case g = "G"
}

extension Step: Equatable {}
extension Step: Codable {}

extension Step {    // SyntacticSugar
    public func nextCase() -> Step {
        let allCases = Step.allCases
        guard let currentIndex = allCases.firstIndex(of: self) else {
            return self
        }
        let nextIndex = (currentIndex + 1) % allCases.count
        return allCases[nextIndex]
    }
}
