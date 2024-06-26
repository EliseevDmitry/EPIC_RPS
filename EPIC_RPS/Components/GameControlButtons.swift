import SwiftUI

struct GameControlButtons<Destination: View>: View {
    
    var buttonText: String
    var destination: Destination
    
    var body: some View {
        
        NavigationLink(destination: destination.navigationBarBackButtonHidden(true)) {
            ZStack {
                Image(.controllButtonBG)
                    .resizable()
                    .frame(width: 156, height: 53)
                Text(buttonText)
                    .fontWeight(.heavy)
                    .font(.system(size: 16))
                    .foregroundStyle(Color("FontColor"))
            }
        }
    }
}
#Preview {
    GameControlButtons(buttonText: "Start game", destination: RulesView())
}
