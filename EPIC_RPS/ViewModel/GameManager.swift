
import Foundation
import SwiftUI

class GameManager: ObservableObject {
    //New
    @Published var currentTopHand = Image(.femaleHand)
    @Published var currentBottomHand = Image(.maleHand)
    @Published var showClash = false
    @Published var topPlayerWin = false
    @Published var isAnimating = false
    @Published var navigate = false
    @Published var winLabel = ""
    @Published var isHidden = false
    @Published var isLabelAnimating = false
    
    //временно
    let playMelody = SoundManager.shared
    
    @Published var computer: ComputerGame = ComputerGame(
        arr: ["rock","scissors","paper"],
        randomSelect: nil,
        score: 0,
        win: false
    )
    
    @Published var people: PeopleGame = PeopleGame(
        arr: ["rock","scissors","paper"],
        select: nil,
        score: 0,
        win: false
    )
    
    @Published var scoreLevels: SaveGameResult = SaveGameResult(
        computerScore: 0,
        peopleScore: 0,
        melodyNumber: 0
    )
    
    @Published var gameTimer: GameTimer = GameTimer(
        isStop: false,
        totalTime: 5,
        gameTime: 5
    )
    
    @Published var soundManager: Sounds = Sounds(
        tracks: ["Мелодия 1", "Мелодия 2", "Мелодия 3"],
        melodyNumber: 0,
        timeTrack: 30,
        indexTrack: 0
    )
    
    func playChangeTracks(at index: Int){
        playMelody.playSound(soundManager.tracks[index], timeInterval: soundManager.timeTrack)
        soundManager.melodyNumber = index
    }
    
    //для тестирования - 1 и 3 секунды
    func timeChangeTracks(at index: Int){
        switch index {
        case 0: soundManager.timeTrack = 30
            soundManager.indexTrack = index
        case 1: soundManager.timeTrack = 60
            soundManager.indexTrack = index
        default:
            return
        }
    }
    
    //сохранение игры
    func saveGame(){
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(scoreLevels) {
            UserDefaults.standard.set(data, forKey: "resultGame")
        }
        if let sondData = try? encoder.encode(soundManager) {
            UserDefaults.standard.set(sondData, forKey: "soundGame")
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
        guard let sondData = UserDefaults.standard.data(forKey: "soundGame") else { return }
        guard let loadSoundData = try? decoder.decode(Sounds.self, from: sondData) else {return}
        soundManager.indexTrack = loadSoundData.indexTrack
        soundManager.melodyNumber = loadSoundData.melodyNumber
        soundManager.timeTrack = loadSoundData.timeTrack
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
                    
                    withAnimation(.easeInOut(duration: 1)) {
                        updateHands(for: data, computerChoice: computerChoice)
                        showClash = false
                        winLabel = "DRAW"
                        isHidden = false
                        isLabelAnimating = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.updateHands(top: Image(.femaleHand), bottom: Image(.maleHand))
                            }
                        }
                    }
                    
                } else {
                    // Проверяем, выиграл ли пользователь
                    if winOrLose(data: data) {
                        addScorePeople()
                        print("Выиграл человек")
                        topPlayerWin = false // Пользователь внизу
                        withAnimation(.easeInOut(duration: 1)) {
                            winLabel = "YOU WIN"
                            isHidden = false
                            isLabelAnimating = false
                        }
                        
                    } else {
                        // Если нет, то выиграл компьютер
                        addScoreComputer()
                        print("Выиграл компьютер")
                        topPlayerWin = true // Компьютер вверху
                        withAnimation(.easeInOut(duration: 1)) {
                            winLabel = "YOU LOSE"
                            isHidden = false
                            isLabelAnimating = false
                        }
                    }
                    
                    // Обновляем руки и анимацию для выигрыша/проигрыша
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.updateHands(for: data, computerChoice: computerChoice)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                withAnimation(.easeInOut(duration: 0.7)) {
                                    self.showClash = true
                                    self.playMelody.playSound("Udar", timeInterval: 1)
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.updateHands(top: Image(.femaleHand), bottom: Image(.maleHand))
                                    self.winLabel = ""
                                }
                            }
                        }
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
    
    func addScoreComputer()->Bool{
        computer.score += 1
        if computer.score == 3 {
            gameTimer.isStop = true
            scoreLevels.computerScore += 1
            saveGame()
            computer.win = true
            playMelody.stop()
            print("увеличели - \(scoreLevels.computerScore)")
            return true
        }
        return false
    }
    
    func addScorePeople()->Bool{
        people.score += 1
        if people.score == 3 {
            gameTimer.isStop = true
            scoreLevels.peopleScore += 1
            saveGame()
            people.win = true
            playMelody.stop()
            print("увеличели - \(scoreLevels.peopleScore)")
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
        computer.win = false
        people.win = false
        gameTimer.isStop = true //ОБЯЗАТЕЛЬНО ТУТ true
        gameTimer.gameTime = 5
        currentBottomHand = Image(.maleHand)
        currentTopHand = Image(.femaleHand)
    }
    
    
    
    func updateHands(for data: ChoseData, computerChoice: Int) {
        switch data {
        case .rock:
            if computerChoice == 1 { // Компьютер выбрал ножницы
                updateHands(top: Image(.femaleHandScissors), bottom: Image(.maleHandRock))
            } else if computerChoice == 0 { // Компьютер выбрал камень
                updateHands(top: Image(.femaleHandRock), bottom: Image(.maleHandRock))
            } else { // Компьютер выбрал бумагу
                updateHands(top: Image(.femaleHandPaper), bottom: Image(.maleHandRock))
            }
        case .paper:
            if computerChoice == 0 { // Компьютер выбрал камень
                updateHands(top: Image(.femaleHandRock), bottom: Image(.maleHandPaper))
            } else if computerChoice == 1 { // Компьютер выбрал ножницы
                updateHands(top: Image(.femaleHandScissors), bottom: Image(.maleHandPaper))
            } else { // Ничья бумага
                updateHands(top: Image(.femaleHandPaper), bottom: Image(.maleHandPaper))
            }
        case .scissors:
            if computerChoice == 0 {
                // Компьютер выбрал камень
                updateHands(top: Image(.femaleHandRock), bottom: Image(.maleHandScissors))
            } else if computerChoice == 1 {
                // Оба выбрали ножницы
                updateHands(top: Image(.femaleHandScissors), bottom: Image(.maleHandScissors))
            } else {
                // Компьютер бумага
                updateHands(top: Image(.femaleHandPaper), bottom: Image(.maleHandScissors))
            }
        }
    }
    
    func updateHands( top: Image, bottom: Image) {
        currentBottomHand = bottom
        currentTopHand = top
    }
    
    
    
    func toggleAnimation() {
        isAnimating.toggle()
    }
    
    func nextScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigate = true
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



