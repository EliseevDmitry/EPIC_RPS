//SoundManager


import Foundation
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?
    
    private init() {}
    
    func playSound(_ soundName: String, timeInterval: Int) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            let timeLimit = timeInterval
            player?.play()
            Timer.scheduledTimer(withTimeInterval: TimeInterval(timeLimit), repeats: false) { (timer) in
                stop()
            }
        } catch {
            print("Failed to play sound: \(error)")
        }
        
        func pause() {
            player?.pause()
        }
        func stop() {
            player?.stop()
        }
    }
}

