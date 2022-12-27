//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

extension NSLayoutConstraint {

    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var processTitle: UILabel!
    
    @IBOutlet weak var vProgressBar: UIProgressView!
    
    let eggTimes = ["Soft": 2, "Medium":4, "Hard": 6]
    var secondRemaining = 0
    var totalTime = 0

    var player: AVAudioPlayer!
    
    var timer = Timer()
    
    
    @IBAction func clickEgg(_ sender: UIButton) {
        
        
        let urlString = Bundle.main.url(forResource:"alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: urlString!)
        player.stop()
        
        vProgressBar.progress = 0
        
        //Cancel & remove the timer
        timer.invalidate()
        let hardness =  sender.currentTitle!
        totalTime = eggTimes[hardness]!
        secondRemaining = 0
        
        processTitle.text = "How do you like your eggs?"
        
        /*Parameters:
         timeInterval: how often the timer is fired (e.g. it's every 1s)
         target: which object sends the message when the timer is fired
         selector: it's everytimeInterval, it calls to the selector function
         userInfo:
         repeats: we would it's re-fired after the first second, don't run only one-time after 1s
         */
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer(){
        if secondRemaining < totalTime {
            secondRemaining += 1
            vProgressBar.progress = Float(secondRemaining)/Float(totalTime)
            print("\(Float(secondRemaining)/Float(totalTime)) seconds.")


        } else {
            processTitle.text = "Done"
            timer.invalidate()
            secondRemaining = 0
            
           
            player.play()
            
            
        }

    }
    
}
