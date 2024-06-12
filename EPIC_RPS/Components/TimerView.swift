//
//  TimerView.swift
//  EPIC_RPS
//
//  Created by Dmitriy Eliseev on 10.06.2024.
//

import SwiftUI

struct TimerView: View {
    var epicManager: GameManager
    @State private var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var index: CGFloat = 1.0
    var body: some View {
        VStack{
            GeometryReader { screen in
                ZStack(alignment: .bottom){
                    RoundedRectangle(cornerRadius: .infinity)
                        .foregroundStyle(.timerempty)
                    RoundedRectangle(cornerRadius: .infinity)
                        .foregroundStyle(.timerfull)
                        .frame(height: (screen.size.height * CGFloat(self.index)))
                }//: ZSTACK ProgressBar
            }
            .frame(width: 12)
            Text("0:\(epicManager.gameTimer.gameTime.formatted())")
                .font(.system(size: 12))
                .foregroundStyle(.white)
        }
        .onReceive(self.time, perform: { time in
            if !epicManager.gameTimer.isStop{
                if self.epicManager.gameTimer.gameTime != 0 {
                    self.epicManager.gameTimer.gameTime -= 1
                    self.index = CGFloat((self.epicManager.gameTimer.gameTime/self.epicManager.gameTimer.totalTime))
                }
            } else if epicManager.gameTimer.isStop {
                return
            }
        })
        
    }
}

#Preview {
    TimerView(epicManager: GameManager())
}
