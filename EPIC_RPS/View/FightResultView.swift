
import SwiftUI

struct FightResultView: View {
    //MARK: - PROPERTIES
    var winOrLose = true
    let yourScore = 3
    let computerScore = 1
    
    //MARK: - BODY
    var body: some View {
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
                Text(winOrLose ? "You Win" : "You Lose")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(winOrLose ? Color(hex: 0xFFB24C) : .black)
                
                Text("\(yourScore) - \(computerScore)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                HStack(spacing: 40) {
                    Button {
                        print("home")
                    } label: {
                        Image(.home)
                    }
                    
                    Button {
                        print("restart")
                    } label: {
                        Image(.restart)
                    }
                }
                .padding()
            }
            
        }
        
    }
}

//MARK: - PREVIEW
#Preview {
    FightResultView()
}
