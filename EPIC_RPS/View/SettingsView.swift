//
//  SettingsView.swift
//  EPIC_RPS
//
//  Created by Юрий on 12.06.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var melodyNumber = 0
    @State private var playWithFriend = false
    @State private var melodyPlayTime = 0
    
    let melodies = ["Мелодия 1", "Мелодия 2", "Мелодия 3"]
    let playMelody = SoundManager.shared
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("ВРЕМЯ ИГРЫ")
                    
                    Picker("ВРЕМЯ ИГРЫ", selection: $melodyPlayTime) {
                        Text("30 сек.").tag(0)
                        Text("60 сек.").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .background(.orange)
                    .cornerRadius(7)
                }
                
                Section {
                    Picker("Фоновая музыка", selection: $melodyNumber) {
                        ForEach(0 ..< melodies.count, id: \.self) { index in
                            Text(melodies[index])
                        }
                    }
                    
                    .onChange(of: melodyNumber) { _ in
                        playMelody.playSound(melodies[melodyNumber])
                    }
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.orange)
                    .cornerRadius(15)
                    
                    Toggle("Игра с другом", isOn: $playWithFriend)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.orange)
                        .cornerRadius(15)
                }
            }
//            .onAppear {
//                playMelody.playSound("Мелодия 1")
//            }
        }
    }
}


#Preview {
    SettingsView()
}