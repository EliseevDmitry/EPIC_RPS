
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
    var win: Bool {
        if score == 3 {
            return true
        }
        return false
    }
}

struct PeopleGame {
    let arr: [String]
    var select: Int?
    var score: Int
    var win: Bool {
        if score == 3 {
            return true
        }
        return false
    }
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

struct Sounds: Codable{
    let tracks: [String]
    var melodyNumber: Int
    var timeTrack: Int
    var indexTrack: Int
}
