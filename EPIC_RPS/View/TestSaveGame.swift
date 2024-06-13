//
//  TestSaveGame.swift
//  EPIC_RPS
//
//  Created by Dmitriy Eliseev on 14.06.2024.
//

import SwiftUI

struct TestSaveGame: View {
    //MARK: - PROPERTIES
    @ObservedObject var epicManager: GameManager
    //MARK: - BODY
    var body: some View {
        
        VStack{
            Text("Computer win - \(epicManager.scoreLevels.computerScore)")
            Button{
                epicManager.scoreLevels.computerScore += 1
            } label: {
                Text("Добовляем побед компьютеру")
            }
            Divider()
            Text("People win - \(epicManager.scoreLevels.peopleScore)")
            Button{
                epicManager.scoreLevels.peopleScore += 1
            } label: {
                Text("Добовляем побед человеку")
            }
            
            Button{
                epicManager.saveGame()
            } label: {
                Text("Сохраняем победы")
            }
        }
        .onAppear{
            epicManager.loadGame()
        }
        
    }
}

#Preview {
    TestSaveGame(epicManager: GameManager())
}
