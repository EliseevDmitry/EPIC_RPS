//SoundManager


import Foundation
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?
    private var timerGame = Timer()
    
    private init() {}
    
    func playSound(_ soundName: String, timeInterval: Int) {
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            print("интервал времени таймера игры - \(timeInterval)")
            let timeLimit = timeInterval
            player?.play()
            timerGame = Timer.scheduledTimer(withTimeInterval: TimeInterval(timeLimit), repeats: false) { (timer) in
                self.stop()
            }
        } catch {
            print("Failed to play sound: \(error)")
        }
        
    }
    
    func pause() {
        player?.pause()
    }
    func stop() {
        timerGame.invalidate()
        player?.stop()
    }
}

