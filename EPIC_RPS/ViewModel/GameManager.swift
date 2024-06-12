//
//  GameManager.swift
//  EPIC_RPS
//
//  Created by Dmitriy Eliseev on 12.06.2024.
//

import Foundation

class GameManager: ObservableObject {
    @Published var computer: ComputerGame = ComputerGame(
        arr: ["rock","scissors","paper"],
        randomSelect: nil,
        score: 0
    )
    
    @Published var people: PeopleGame = PeopleGame(
        arr: ["rock","scissors","paper"], 
        select: nil,
        score: 0
    )
    
    @Published var scoreLevels: SaveGameResult = SaveGameResult(
        computerScore: 0,
        peopleScore: 0
    )
    
    @Published var gameTimer: GameTimer = GameTimer(
        isStop: false,
        totalTime: 30, 
        gameTime: 30
        )
    
    func ComputerSelectQuestion(){
        computer.randomSelect = Int.random(in: 0...2)
    }
    
    func StartGame(data: ChoseData){
        print("сработала кнопка - \(data)")
        if computer.randomSelect != nil {
            if draw(data: data) {
                //отработка ничьей
            } else {
                if winOrLose(data: data) {
                    //выиграл человек
                    addScorePeople()
                    print("Выиграл человек")
                    if chooseWin() {
                        
                    }
                } else {
                    //выиграл компьютер
                    addScoreComputer()
                    print("Выиграл компьютер")
                    if chooseWin() {
                        
                    }
                }
            }
        }
        ComputerSelectQuestion()
        print("Компьютер загадал - \(computer.arr[computer.randomSelect!])")
    }
    
    func draw(data: ChoseData)->Bool{
        if let index = computer.randomSelect {
            if data.rawValue == index {
                return true
            }
        }
        return false
    }
    
    func winOrLose(data: ChoseData)->Bool{
        if let index = computer.randomSelect {
            if index == 0 && data.rawValue == 1 {
                return false
            } else if index == 0 && data.rawValue == 2 {
                return true
            } else if index == 1 && data.rawValue == 0 {
                return true
            } else if index == 1 && data.rawValue == 2 {
                return false
            } else if index == 2 && data.rawValue == 0 {
                return false
            } else if index == 2 && data.rawValue == 1 {
                return true
            }
        }
        return false
    }
    
    func addScoreComputer(){
        computer.score += 1
    }
    
    func addScorePeople(){
        people.score += 1
    }
    
    func chooseWin() -> Bool{
        if computer.score == 3 {
            scoreLevels.computerScore += 1
            return true
        } else if people.score == 3 {
            scoreLevels.peopleScore += 1
            return true
        }
        return false
    }
    
    //перезапуск игры
    func restartGame(){
        computer.score = 0
        ComputerSelectQuestion()
        people.score = 0
        people.select = nil
    }
    
    }
    
    
    
//    static func testState()->GameManager {
//        let manager = GameManager()
//        manager.computer = ComputerGame(
//            arr: ["rock","scissors","paper"],
//            randomSelect: nil
//            )
//        manager.people = PeopleGame(
//            arr: ["rock","scissors","paper"],
//            Select: nil
//        )
//        return manager
//    }
    
