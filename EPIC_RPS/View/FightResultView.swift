
import SwiftUI

struct FightResultView: View {
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @State private var showStartGameView = false
    @ObservedObject var epicManager: GameManager
    
    var winOrLose = true
    let yourScore = GameManager().scoreLevels.peopleScore
    let computerScore = GameManager().scoreLevels.computerScore
    
    //MARK: - BODY
    var body: some View {
        NavigationLink(destination: StartGameView(epicManager: epicManager), isActive: $showStartGameView) {
                            EmptyView()
                        }
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: winOrLose ?
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
                    Image(winOrLose ? .player2 : .player1)
                        .resizable()
                        .frame(width: 66.89, height: 77.9)
                }
                //Text(winOrLose ? "You Win" : "You Lose")
                Text(epicManager.computer.win ? "You Win" : "You Lose") // - логику
                    .font(.title2)
                    .bold()
                    .foregroundStyle(winOrLose ? Color(hex: 0xFFB24C) : .black)
                
                Text("\(epicManager.scoreLevels.peopleScore) - \(epicManager.scoreLevels.computerScore)")
                //Text("\(yourScore) - \(computerScore)")
                //scoreLevels.computerScore
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                HStack(spacing: 40) {
                    Button {
                        
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(.home)
                    }
                    
                    Button {
//                        presentationMode.wrappedValue.dismiss()
                        epicManager.gameTimer.isStop = false
                        showStartGameView = true
                    } label: {
                        Image(.restart)
                    }
                }
                .padding()
            }
            .navigationBarBackButtonHidden()
        }//: ZStack
        .onAppear{
//            if !epicManager.people.win {
//                epicManager.people.win.toggle()
//            }
//            if !epicManager.computer.win {
//                epicManager.computer.win.toggle()
//            }
            epicManager.restartGame()
        }
        
    }
}

//MARK: - PREVIEW
#Preview {
    FightResultView( epicManager: GameManager())
}
