//
//  AudioViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-06-15.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit
import CoreAudio
import AVFoundation

class AudioViewController: BaseViewController {
    
    override var name: String { return "Audio and Microphone" }

    var recorder: AVAudioRecorder?
    var levelTimer = Timer()
    var lowPassResults: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        recorder?.stop()
        levelTimer.invalidate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func detechMicrophone(_ sender: Any) {
        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
            if granted {
                self.initAudio()
            } else {
                print("no permission")
            }
        }
    }
    private func initAudio() {
        //make an AudioSession, set it to PlayAndRecord and make it active
        guard levelTimer.isValid == false else {
            print("already started")
            return
        }
        
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setActive(true)
        
            //set up the URL for the audio file
            let documents = NSSearchPathForDirectoriesInDomains( FileManager.SearchPathDirectory.documentDirectory,  FileManager.SearchPathDomainMask.userDomainMask, true)[0]
            let str =  (documents as NSString).appendingPathComponent("recordTest.caf")
            let url = NSURL.fileURL(withPath: str)
            
            // make a dictionary to hold the recording settings so we can instantiate our AVAudioRecorder
            let recordSettings:[String: Any] = [AVFormatIDKey:kAudioFormatAppleIMA4,
                                  AVSampleRateKey:44100.0,
                                  AVNumberOfChannelsKey:2,AVEncoderBitRateKey:12800,
                                  AVLinearPCMBitDepthKey:16,
                                  AVEncoderAudioQualityKey:AVAudioQuality.max.rawValue
                
            ]
            
            //Instantiate an AVAudioRecorder
            recorder = try AVAudioRecorder(url:url, settings: recordSettings)
            
            recorder?.prepareToRecord()
            recorder?.isMeteringEnabled = true
            
            //start recording
            recorder?.record()
            
            //instantiate a timer to be called with whatever frequency we want to grab metering values
            self.levelTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(AudioViewController.levelTimerCallback), userInfo: nil, repeats: true)
                
        } catch {
            print("something is wrong")
        }

    }
    
    func levelTimerCallback() {
        //we have to update meters before we can get the metering values
        recorder?.updateMeters()
        
        if let value = recorder?.averagePower(forChannel: 0) {
            //print to the console if we are beyond a threshold value. Here I've used -7
            if value > -20 {
                print("Dis be da level I'm hearin' you in dat mic: \(value) ")
            }
        }
    }
    
}
