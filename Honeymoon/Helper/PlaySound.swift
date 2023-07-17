//
//  PlaySound.swift
//  Honeymoon
//
//  Created by Lori Rothermel on 7/16/23.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?


func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }  // do...catch
    }
}
