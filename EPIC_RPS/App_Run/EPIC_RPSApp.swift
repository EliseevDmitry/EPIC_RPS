import SwiftUI



@main
struct EPIC_RPSApp: App {
    @StateObject var epicManager = GameManager()
    var body: some Scene {
        WindowGroup {
            //MARK: - VIEWS run codebase separately
            
            SplashView()
            //RulesView()
            //FightLoadView()
            // StartGameView(epicManager: GameManager())
            //FightResultView()
            //SettingsView(epicManager: GameManager())
            // TestSaveGame(epicManager: GameManager())
            
            //MARK: - COMPONENTS run codebase
            // GameStatusView(barTotal: 30, barValueOne: 1, barValueTwo: 2)
            //TimerView(epicManager: GameManager())
            //GameButtons(epicManager: GameManager())
            
            SplashView(epicManager: epicManager)
        }
    }
}
