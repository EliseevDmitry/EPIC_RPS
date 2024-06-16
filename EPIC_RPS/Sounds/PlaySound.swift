//
//  PlaySound.swift
//  EPIC_RPS
//
//  Created by Dmitriy Eliseev on 16.06.2024.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?
var timerAudioGame = Timer()

func playSound(_ soundName: String, timeInterval: Int) {
    guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
    
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        print("интервал времени таймера игры - \(timeInterval)")
        let timeLimit = timeInterval
        audioPlayer?.play()
        timerAudioGame = Timer.scheduledTimer(withTimeInterval: TimeInterval(timeLimit), repeats: false) { (timer) in
            stopMuzic()
            timerAudioGame.invalidate()
        }
    } catch {
        print("Failed to play sound: \(error)")
    }
    
}

func pause() {
    audioPlayer?.pause()
}
func stopMuzic() {
    audioPlayer?.stop()
}
