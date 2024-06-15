
import SwiftUI

struct FightResultView: View {
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @State private var showStartGameView = false
    @State private var showSplashView = false
    @ObservedObject var epicManager: GameManager
    
    //MARK: - BODY
    var body: some View {
        
        NavigationLink(destination: StartGameView(epicManager: epicManager)
            .navigationBarBackButtonHidden(), isActive: $showStartGameView) { }
        
        NavigationLink(destination: SplashView(epicManager: epicManager), isActive: $showSplashView) { }
        
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: epicManager.people.win ?
                                   [Color(hex: 0x2D2599), Color(hex: 0x656DF4)]
                                   : [Color(hex: 0xFFB600), Color(hex: 0xEE413C)]),
                center: .center,
                startRadius: 20,
                endRadius: 300
            )
            .ignoresSafeArea()
            
            VStack {
                ZStack {
                    Circle()
                        .fill(Color(hex: 0x2B2870))
                    .frame(width: 176, height: 176)
                    Image(epicManager.people.win ? .player2 : .player1)
                        .resizable()
                        .frame(width: 66.89, height: 77.9)
                }
                Text(epicManager.people.win ? "You Win" : "You Lose")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(epicManager.people.win ? Color(hex: 0xFFB24C) : .black)
                
                Text("\(epicManager.scoreLevels.peopleScore) - \(epicManager.scoreLevels.computerScore)")
                //Text("\(yourScore) - \(computerScore)")
                //scoreLevels.computerScore
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                HStack(spacing: 40) {
                    Button {
                        epicManager.gameTimer.isStop = false
                        showSplashView = true
                        //epicManager.resetScore()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(.home)
                    }
                    
                    Button {
                        //epicManager.resetScore()
                        epicManager.gameTimer.isStop = false
                        showStartGameView = true
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(.restart)
                    }
                }
                .padding()
            }
            .navigationBarBackButtonHidden()
        }
        .onAppear{
            epicManager.restartGame()
        }
        
    }
}

//MARK: - PREVIEW
#Preview {
    FightResultView( epicManager: GameManager())
}
