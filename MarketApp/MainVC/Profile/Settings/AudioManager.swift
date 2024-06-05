//
//  AudioManager.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 01.06.2024.
//

import Foundation
import AVFoundation
class AudioManager {
    static let shared = AudioManager()
    var audioPlayer: AVAudioPlayer?
    
    private init() {}
    
    func playAudio() {
           guard let path = Bundle.main.path(forResource: "first", ofType: "mp3") else {
               print("Audio file not found")
               return
           }
           let url = URL(fileURLWithPath: path)
           
           do {
               audioPlayer = try AVAudioPlayer(contentsOf: url)
               audioPlayer?.numberOfLoops = -1 // Loop indefinitely
               audioPlayer?.play()
           } catch {
               print("Couldn't load the file")
           }
       }
       
       func stopAudio() {
           audioPlayer?.stop()
           audioPlayer = nil
       }
}
