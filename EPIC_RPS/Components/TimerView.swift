//
//  TimerView.swift
//  EPIC_RPS
//
//  Created by Dmitriy Eliseev on 10.06.2024.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var epicManager: GameManager
    //@State var timeProgress = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
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
                .frame(width: 30) //отступ от левой части экрана
        }
        .onReceive(epicManager.timeProgress, perform: { time in
                if !epicManager.gameTimer.isStop{
                    if self.epicManager.gameTimer.gameTime != 0 {
                        self.epicManager.gameTimer.gameTime -= 1
                        self.index = CGFloat((self.epicManager.gameTimer.gameTime/self.epicManager.gameTimer.totalTime))
                    } else if epicManager.computer.score < 3 || epicManager.people.score < 3 {
                        print("человек проиграл")
                        if epicManager.addScoreComputer() {
                            epicManager.timeProgress.upstream.connect().cancel()
                            //epicManager.gameTimer.isStop = true
                        }
                        index = 1
                        self.epicManager.gameTimer.gameTime = 30
                        epicManager.gameTimer.isStop = false
                    }
                }
                
            }
        )}
}

#Preview {
    TimerView(epicManager: GameManager())
}
