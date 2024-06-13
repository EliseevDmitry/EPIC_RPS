//
//  ModelGame.swift
//  EPIC_RPS
//
//  Created by Dmitriy Eliseev on 12.06.2024.
//

import Foundation

enum ChoseData: Int {
    case rock = 0
    case scissors = 1
    case paper = 2
}

struct ComputerGame {
    let arr: [String]
    var randomSelect: Int?
    var score: Int
}

struct PeopleGame {
    let arr: [String]
    var select: Int?
    var score: Int
}

struct SaveGameResult: Codable {
    var computerScore: Int
    var peopleScore: Int
    var melodyNumber: Int
}

struct GameTimer{
    var isStop: Bool
    let totalTime: Float
    var gameTime: Float
}

struct Sounds{
    let tracks: [String]
    let melodyNumber: Int
}
