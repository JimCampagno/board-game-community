//  BoardGame.swift

import Foundation

struct PlayingTime {
    let min: Int
    let max: Int?
}

struct PlayerCount {
    let min: Int
    let max: Int?
    let recommended: Recommended?
}

extension PlayerCount {
    struct Recommended {
        let min: Int
        let max: Int?
    }
}

struct Ages {
    let min: Int?
}

struct Release {
    let year: Date
}


struct BoardGame {
    let title: String
    let release: Release
    let playingTime: PlayingTime
    let playerCount: PlayerCount
    let ages: Ages
    var recommendedPlayerCount: PlayerCount.Recommended? { playerCount.recommended }
}
