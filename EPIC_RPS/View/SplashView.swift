
import SwiftUI

struct SplashView: View {

    @ObservedObject var epicManager: GameManager
    //MARK: - BODY

    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    NavigationLink(destination: SettingsView(epicManager: epicManager)){
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(.black)
                    }
                    .padding(.leading, 20)  
                    
                    Spacer()
                    
                    NavigationLink(destination: RulesView()){
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(.black)
                    }
                    .padding(.trailing, 20)
                }
                .padding(.top, 15)
                
                Spacer()
                
                Image(.epicRPSLogo)
                    .resizable()
                    .scaledToFit()
                
                Spacer().frame(height: 100)
                
                VStack(spacing: 15) {
                    GameControlButtons(buttonText: "Start game", destination: FightLoadView(epicManager: GameManager()))
                    GameControlButtons(buttonText: "Results",destination: FightResultView())
                }
            }
            .padding(.bottom,20)
        } 
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(
            gradient: Gradient(colors: [.splashBG1, .splashBG2]),
            startPoint: .top,
            endPoint: .bottom
        ))
    }

}


#Preview {
    SplashView(epicManager: GameManager())
}
