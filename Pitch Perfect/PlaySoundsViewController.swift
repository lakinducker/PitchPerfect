//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Lakin Ducker on 1/15/15.
//  Copyright (c) 2015 Lakin Ducker. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    
    
    func playAudio(audioRate: Float) {
        stopAllAudio()
        audioPlayer.rate = audioRate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        // Play audio slowly...
        playAudio(0.5)
    }
    
    
    @IBAction func playFastAudio(sender: UIButton) {
        // Play audio quickly...
        playAudio(1.5)
    }
    
    
    @IBAction func playHighAudio(sender: UIButton) {
        // Play high pitch audio
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func playLowAudio(sender: UIButton) {
        // Play low pitch audio
        playAudioWithVariablePitch(-1000)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAllAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAllAudio()
    }
    
    func stopAllAudio(){
        // Stop all audio
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
