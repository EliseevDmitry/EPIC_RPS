//
//  FightResultView.swift
//  EPIC_RPS
//
//  Created by Dmitriy Eliseev on 09.06.2024.
//

import SwiftUI

struct FightResultView: View {
    //MARK: - PROPERTIES
    var winOrLose = true
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: 0x2B2870))
            .frame(width: 176, height: 176)
            Image(winOrLose ? .player2 : .player1)
                .resizable()
                .frame(width: 66.89, height: 77.9)
        }
        
    }
}

//MARK: - PREVIEW
#Preview {
    FightResultView()
}
