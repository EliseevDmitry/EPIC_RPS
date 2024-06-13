
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

struct SaveGameResult{
    var computerScore: Int
    var peopleScore: Int
}

struct GameTimer{
    var isStop: Bool
    let totalTime: Float
    var gameTime: Float
}
