import SwiftUI

struct FightLoadView: View {
    
    @ObservedObject var epicManager: GameManager
    
    var body: some View {
        let compScore = epicManager.scoreLevels.computerScore
        let personScore = epicManager.scoreLevels.peopleScore
        
        NavigationView {
            ZStack {
                // Background gradient
                RadialGradient(colors: [.gradientOne, .gradientTwo], center: .center, startRadius: .zero, endRadius: 350)
                    .ignoresSafeArea()
                // Content
                VStack {
                    Spacer()
                    
                    VStack(spacing: 10) {
                        Image("player1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(epicManager.isAnimating ? 360 : 0))
                            .animation(.easeInOut(duration: 3), value: epicManager.isAnimating)
                        
                        VStack {
                                   
                                   (Text("\(compScore) ")
                                       .foregroundColor(.yellow) +
                                   Text("Victories/\n")
                                       .foregroundColor(.white) +
                                   Text("\(compScore) ")
                                       .foregroundColor(.red) +
                                   Text("Lose")
                                       .foregroundColor(.white))
                                       .font(.title2)
                                       .fontWeight(.bold)
                                       .multilineTextAlignment(.center)
                               }
                    }
                    
                    Spacer()
                    
                    Text("VS")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        Image("player2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(epicManager.isAnimating ? 360 : 0))
                            .animation(.easeInOut(duration: 3), value: epicManager.isAnimating)
                        
                        VStack {
                                   
                                   (Text("\(personScore) ")
                                       .foregroundColor(.yellow) +
                                   Text("Victories/\n")
                                       .foregroundColor(.white) +
                                   Text("\(compScore) ")
                                       .foregroundColor(.red) +
                                   Text("Lose")
                                       .foregroundColor(.white))
                                       .font(.title2)
                                       .fontWeight(.bold)
                                       .multilineTextAlignment(.center)
                               }
                            .onAppear{
                                epicManager.loadGame()
                            }
                    }
                    
                    Spacer()
                    
                    Text("Get ready...")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        .scaleEffect(epicManager.isAnimating ? 1.3 : 1.0)
                        .animation(.easeInOut(duration: 3), value: epicManager.isAnimating)
                    

                    NavigationLink(destination: StartGameView(epicManager: epicManager).navigationBarBackButtonHidden(true), isActive: $epicManager.navigate) {
                        EmptyView()
                    }
                    
                    Spacer()
                }
                .onAppear {
                    epicManager.toggleAnimation()
                    epicManager.nextScreen()
                }
            }
        }
    }
}

//MARK: - PREVIEW
#Preview {
    FightLoadView(epicManager: GameManager())
}
