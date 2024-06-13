import SwiftUI

struct SettingsView: View {
    //MARK: - PROPERTIES
    @ObservedObject var epicManager: GameManager

    @State private var melodyNumber = 0
    
    @State private var playWithFriend = false
    @State private var melodyPlayTime = 0
    
    //let melodies = ["Мелодия 1", "Мелодия 2", "Мелодия 3"]
    let playMelody = SoundManager.shared
    //MARK: - BODY
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
                        ForEach(0 ..< epicManager.soundManager.tracks.count, id: \.self) { index in
                            Text(epicManager.soundManager.tracks[index])
                        }
                    }
                    .onChange(of: melodyNumber){_ in
                        epicManager.playChangeTracks(at: melodyNumber)
                    }
//                    .onChange(of: melodyNumber) { _ in
//                                            playMelody.playSound(epicManager.soundManager.tracks[melodyNumber])
//                                        }
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
            .shadow(radius: 10)
//            .onAppear {
//                playMelody.playSound("Мелодия 1")
//            }
        }
    }
}

//MARK: - PREVIEW
#Preview {

        SettingsView(epicManager: GameManager())

}
