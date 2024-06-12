//
//  SoundManager.swift
//  EPIC_RPS
//
//  Created by Юрий on 12.06.2024.
//

import Foundation
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?
    
    private init() {}
    
    func playSound(_ soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
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
