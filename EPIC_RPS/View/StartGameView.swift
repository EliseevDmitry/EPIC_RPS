//
//  StartGameView.swift
//  EPIC_RPS
//
//  Created by Dmitriy Eliseev on 09.06.2024.
//

import SwiftUI

struct StartGameView: View {
    //MARK: - PROPERTIES
    
    //MARK: - BODY
    var body: some View {
        NavigationView{
            VStack {
                ZStack{
                    Image(.fill1)
                        .resizable()
                        .scaledToFit()
                    HStack{
                        TimerView(timerTotal: 30, timerValue: 20)
                            .frame(height: 300)
                            .padding(.leading, 5)
                        Spacer()
                        Text("Fight")
                            .textCase(.uppercase)
                            .font(.system(size: 60).bold())
                            .foregroundStyle(.yellowGame)
                       Spacer()
                        GameStatusView(barTotal: 6, barValueOne: 2, barValueTwo: 1)
                            .frame(height: 400)
                            .padding(.trailing, 20)
                    }
                }//: ZSTACK
                .overlay(alignment: .leading) {
                    Image(.rectangle)
                        .resizable()
                        .scaledToFill()
                        .frame(width:20, height: 20)
                        .padding(.leading, -1)
                        .padding(.top, -150)
                }
                //мужская рука снизу
                .overlay(alignment: .bottom){
                    HStack {
                        Spacer()
                        Spacer()
                        Image(.maleHand)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 155, height: 550)
                            .padding(.bottom, -350)
                        Spacer()
                    }
                }//: OVERLAY
                //женская рука сверху
                .overlay(alignment: .top){
                    HStack {
                        Spacer()
                        Image(.femaleHand)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 155, height: 550)
                            .padding(.top, -350)
                        Spacer()
                        Spacer()
                    }
                }//: OVERLAY
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(RadialGradient(colors: [.gradientOne, .gradientTwo], center: .center, startRadius: .zero, endRadius: 350))
            .overlay(alignment: .bottom){
                    GameButtons()
            }//: OVERLAY
            .ignoresSafeArea()
        }
    }
//MARK: - FUNCTIONS
    
}

//MARK: - PREVIEW
#Preview {
    StartGameView()
}
