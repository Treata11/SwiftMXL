//
// Player.swift
// SwiftMXL
//
//  Created by Treata Norouzi on 9/30/23.
//

public struct Player {
    // MARK: - Instance Properties

    // MARK: - Attributes
    
    /// An identifier for this `player` that is unique within this document.
    public var id: String
    
    /// The `player-name` element is typically used within a software application,
    /// rather than appearing on the printed page of a score.
    public var name: String
    
    // MARK: - Initializers
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

// MARK: - Player Extensions

extension Player: Equatable { }

extension Player: Codable {
    public enum CodingKeys: String, CodingKey {
        case id
        case name = "player-name"
    }
}
