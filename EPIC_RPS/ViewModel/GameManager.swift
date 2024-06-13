
import Foundation
import SwiftUI

class GameManager: ObservableObject {
    
    @Published var currentTopHand = Image(.femaleHand)
    @Published var currentBottomHand = Image(.maleHand)
    @Published var showClash = false
    @Published var topPlayerWin = false
    //временно
    let playMelody = SoundManager.shared
    
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
        peopleScore: 0,
        melodyNumber: 0
    )
    
    @Published var gameTimer: GameTimer = GameTimer(
        isStop: false,
        totalTime: 30,
        gameTime: 30
    )
    
    @Published var soundManager: Sounds = Sounds(
        tracks: ["Мелодия 1", "Мелодия 2", "Мелодия 3"],
        melodyNumber: 0
    )
    
    func playChangeTracks(at index: Int){
            playMelody.playSound(soundManager.tracks[index])
    }
    
    //сохранение игры
    func saveGame(){
        let encoder = JSONEncoder()

        if let data = try? encoder.encode(scoreLevels) {
            UserDefaults.standard.set(data, forKey: "resultGame")
        }
    }
    
    //загрузка игры
    func loadGame(){
        let decoder = JSONDecoder()
        guard let data = UserDefaults.standard.data(forKey: "resultGame") else { return }
        guard let loadData = try? decoder.decode(SaveGameResult.self, from: data) else {return}
        scoreLevels.computerScore = loadData.computerScore
        scoreLevels.peopleScore = loadData.peopleScore
        scoreLevels.melodyNumber = loadData.melodyNumber
    }
    
    func ComputerSelectQuestion(){
        computer.randomSelect = Int.random(in: 0...2)
    }
    
    func StartGame(data: ChoseData) {
            // Отображаем выбор пользователя
            print("сработала кнопка - \(data)")
            
            // Проверяем, что компьютер сделал выбор
            if let computerChoice = computer.randomSelect {
                if draw(data: data) {
                    // Отработка ничьей
                    withAnimation(.easeInOut(duration: 1)) {
                        updateHands(for: data, computerChoice: computerChoice)
                        showClash = false
                    }
                } else {
                    // Проверяем, выиграл ли пользователь
                    if winOrLose(data: data) {
                        addScorePeople()
                        print("Выиграл человек")
                        topPlayerWin = false // Пользователь внизу
                    } else {
                        // Если нет, то выиграл компьютер
                        addScoreComputer()
                        print("Выиграл компьютер")
                        topPlayerWin = true // Компьютер вверху
                    }
                    
                    // Обновляем руки и анимацию для выигрыша/проигрыша
                    withAnimation(.easeInOut(duration: 1)) {
                        updateHands(for: data, computerChoice: computerChoice)
                        showClash = true
                    }
                    
                    // Сброс анимации после задержки
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeInOut(duration: 1)) {
                            self.showClash = false
                        }
                    }
                }
            }
            // Компьютер снова выбирает значение для следующего раунда
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
        currentBottomHand = Image(.maleHand)
        currentTopHand = Image(.femaleHand)
    }
    
    func updateHands(for data: ChoseData, computerChoice: Int) {
        
        switch data {
        case .rock:
            if computerChoice == 1 {
                updateHands(top: Image(.femaleHandRock), bottom: Image(.maleHandScissors))
            } else {
                updateHands(top: Image(.femaleHandRock), bottom: Image(.maleHandPaper))
            }
        case .paper:
            if computerChoice == 0 {
                updateHands(top: Image(.femaleHandPaper), bottom: Image(.maleHandRock))
            } else {
                updateHands(top: Image(.femaleHandPaper), bottom: Image(.maleHandScissors))
            }
        case .scissors:
            if computerChoice == 0 {
                updateHands(top: Image(.femaleHandScissors), bottom: Image(.maleHandRock))
            } else {
                updateHands(top: Image(.femaleHandScissors), bottom: Image(.maleHandPaper))
            }
        }
        
        
        func updateHands( top: Image, bottom: Image) {
            currentBottomHand = bottom
            currentTopHand = top
        }
        
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
    

