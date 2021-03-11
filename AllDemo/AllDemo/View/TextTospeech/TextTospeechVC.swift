//
//  TextTospeechVC.swift
//  AllDemo
//
//  Created by NgocNB on 1/26/21.
//

import UIKit
import AVFoundation
import Speech

class TextTospeechVC: UIViewController, SFSpeechRecognizerDelegate {

    let speechSynthesizer = AVSpeechSynthesizer()
    let audio = AVAudioEngine()
    
    let speedReconiger: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var regconitionTask: SFSpeechRecognitionTask?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func speaking(withStr str: String) {
        let speechUtterance = AVSpeechUtterance(string: "You just said: \(str)")
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        speechUtterance.rate = 0.5
        speechUtterance.pitchMultiplier = 0.25
        speechUtterance.volume = 0.75
        
        speechSynthesizer.speak(speechUtterance)
    }
    
    func recordAndReconiger() {
        audio.inputNode.removeTap(onBus: 0)
         let node = audio.inputNode
        let outputFomat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 4096, format: outputFomat) { buffer, _ in
            self.request.append(buffer)
        }
        
        audio.prepare()
        do {
            try audio.start()
        } catch {
            print(error)
        }
        guard let myReconiger = SFSpeechRecognizer() else {
            print("a regconozer is not supported for the curretn local")
            return
        }
        
        if !myReconiger.isAvailable {
            print("a regconizer is not availabel right now")
            return
        }
        regconitionTask = speedReconiger?.recognitionTask(with: request, resultHandler: { (result, error) in
            if let result = result {
                let bestStr = result.bestTranscription.formattedString
                print("You just said: \(bestStr)")
                self.speaking(withStr: bestStr)
            } else if let yourErr = error {
                print(yourErr)
            }
        })
        
        
    }
    
    func stopAudio() {
        request.endAudio()
        audio.stop()
        
        if audio.inputNode.numberOfInputs > 0 {
            audio.inputNode.removeTap(onBus: 0)
        }
        regconitionTask?.cancel()
    }
    
    @IBAction func onspeakAction(_ sender: Any) {
        
        
    }

    @IBAction func onListen(_ sender: Any) {
        self.recordAndReconiger()
    }
}
