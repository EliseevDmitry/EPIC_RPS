//
//  TimerView.swift
//  EPIC_RPS
//
//  Created by Dmitriy Eliseev on 10.06.2024.
//

import SwiftUI

struct TimerView: View {
    let timerTotal: Float
    let timerValue: Float
    var body: some View {
        VStack{
            GeometryReader { screen in
                ZStack(alignment: .bottom){
                    RoundedRectangle(cornerRadius: .infinity)
                        .foregroundStyle(.timerempty)
                    RoundedRectangle(cornerRadius: .infinity)
                        .foregroundStyle(.timerfull)
                        .frame(height: screen.size.height * CGFloat(timerValue) / CGFloat(timerTotal))
                }//: ZSTACK ProgressBar
            }
            .frame(width: 12)
            Text("0:\(timerValue.formatted())")
                .font(.system(size: 12))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    TimerView(timerTotal: 30, timerValue: 15)
}
