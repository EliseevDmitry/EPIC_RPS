import SwiftUI

struct FightLoadView: View {
    
    @ObservedObject var epicManager: GameManager
    
    var body: some View {
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
                        
                        Text("10 Victories/\n2 Lose")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
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
                        
                        Text("23 Victories/\n1 Lose")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                    
                    Text("Get ready...")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        .scaleEffect(epicManager.isAnimating ? 1.3 : 1.0)
                        .animation(.easeInOut(duration: 3), value: epicManager.isAnimating)
                    
                    NavigationLink(destination: StartGameView(epicManager: GameManager()), isActive: $epicManager.navigate) {
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
