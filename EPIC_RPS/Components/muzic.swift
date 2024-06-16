//
//  muzic.swift
//  EPIC_RPS
//
//  Created by Dmitriy Eliseev on 16.06.2024.
//

import SwiftUI
import AVKit

struct PlayerView: UIViewControllerRepresentable {
   var url = Bundle.main.url(forResource: "Мелодия 1", withExtension: "mp3")

  func makeUIViewController(context: Context) -> AVPlayerViewController {
    let controller = AVPlayerViewController()
    let player = AVPlayer(url: url!)
    controller.player = player
    controller.player?.play()
    controller.allowsPictureInPicturePlayback = true // enables PiP
    return controller
  }
  func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}


struct muzic: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    muzic()
}
