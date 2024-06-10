//
//  ContentView.swift
//  EPIC_RPS
//
//  Created by Dmitriy Eliseev on 09.06.2024.
//

import SwiftUI

struct SplashView: View {
    //MARK: - PROPERTIES
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    NavigationLink(destination: SettingsView()){
                        Image(.settings)
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(.red)
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    NavigationLink(destination: RulesView()){
                        Image(.rules)
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                    .padding(.trailing, 20)
                }
                
                
                Spacer().frame(height: 80)
                
                Image(.epicRPSLogo)
                
                Spacer().frame(height: 30)
                
                VStack(spacing: 15) {
                    GameControlButtons(buttonText: "Start game", destination: StartGameView())
                    GameControlButtons(buttonText: "Results",destination: FightResultView())
                }
            }
        }
        
        .background(LinearGradient(
            gradient: Gradient(colors: [.splashBG1, .splashBG2]),
            startPoint: .top,
            endPoint: .bottom
        ))
    }
    //MARK: - FUNCTIONS
    
}

//MARK: - PREVIEW
#Preview {
    SplashView()
}
