import SwiftUI

struct SettingsView: View {
    //MARK: - PROPERTIES
    @ObservedObject var epicManager: GameManager
    
    @State private var melodyNumber = 0
    @State private var playWithFriend = false
    @State private var melodyPlayTime = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    //let melodies = ["Мелодия 1", "Мелодия 2", "Мелодия 3"]
    let playMelody = SoundManager.shared
    
    var backButton : some View { Button(action: {
        playMelody.stop()
        self.presentationMode.wrappedValue.dismiss()
    }) {
        Image(systemName: "chevron.backward")
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.black)
        }
    }

        var body: some View {
            Form {
                Section {
                    Text("ВРЕМЯ ИГРЫ")
                    Picker("ВРЕМЯ ИГРЫ", selection: $melodyPlayTime) {
                        Text("30 сек.").tag(0)
                        Text("60 сек.").tag(1)
                    }
                    .onChange(of: melodyPlayTime, perform: { _ in
                        epicManager.timeChangeTracks(at: melodyPlayTime)
                        epicManager.saveGame()
                        print("Сохранен - \(epicManager.soundManager.indexTrack)")
                    })
                    .pickerStyle(.segmented)
                    .background(Color(hex: 0xF1AA83))
                    .cornerRadius(7)
                }
                Section {
                    Picker("Фоновая музыка", selection: $melodyNumber) {
                        ForEach(0 ..< epicManager.soundManager.tracks.count, id: \.self) { index in
                            Text(epicManager.soundManager.tracks[index])
                        }
                        .pickerStyle(.segmented)
                        .background(.orange)
                        .cornerRadius(7)
                    }
                    .onChange(of: melodyNumber) { _ in
                        epicManager.playChangeTracks(at: melodyNumber)
                        epicManager.saveGame()
                    }
                    .padding(8)
                    .foregroundColor(.white)
                    .background(Color(hex: 0xF1AA83))
                    .cornerRadius(15)
                    //multiplayerGame
                    Toggle("Игра с другом", isOn: $playWithFriend)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color(hex: 0xF1AA83))
                        .cornerRadius(15)
                }
                .navigationBarBackButtonHidden()
                .navigationBarItems(leading: backButton)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Settings").font(.title)
                    }
                }
                .onAppear{
                    epicManager.loadGame()
                    print("загружен - \(epicManager.soundManager.indexTrack)")
                    melodyPlayTime = epicManager.soundManager.indexTrack
                    melodyNumber = epicManager.soundManager.melodyNumber
                    print(epicManager.soundManager.melodyNumber)
                }
            }
            
        }
    }


//MARK: - PREVIEW
#Preview {
    
    SettingsView(epicManager: GameManager())
    
}
