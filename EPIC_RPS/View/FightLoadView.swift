import SwiftUI

struct FightLoadView: View {
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // Content
            VStack {
                Spacer()
                
                VStack(spacing: 10) {
                    Image("player1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
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
                
                Spacer()
            }
        }
    }
}

//MARK: - PREVIEW
#Preview {
    FightLoadView()
}
