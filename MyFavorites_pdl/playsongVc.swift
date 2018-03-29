//
//  playsongVc.swift
//  MyFavorites_pdl
//
//  Created by Ravi Pinamacha on 7/7/17.
//  Copyright © 2017 Ravi Pinamacha. All rights reserved.
//

import UIKit
import AVFoundation

class playsongVc: UIViewController {
    
    @objc var trackId: Int = 0
    @objc var albumName : String = ""
    
    @objc var filePath: String?
    @objc var dictArray: [[String: String]] = []
   
    @objc var audioPlayer : AVAudioPlayer!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
   // @IBOutlet weak var shuffle: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     print(albumName)
        filePath = Bundle.main.path(forResource: albumName, ofType: "plist")
        dictArray = NSArray(contentsOfFile: filePath!) as! [[String: String]]
        
        guard  let title = dictArray[trackId]["title"] else { return }
        textView.text = load(file: title)
        getTitle(titleName:title)
       
    }
    
    //to start text  view from starting
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    //this action for whenever click back audio will stop
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
       
    }

    @objc func updateProgressView(){
        if audioPlayer.isPlaying {
            progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
        }
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
           
           textView.text = load(file: dictArray[trackId]["title"]!)
        case 1:
            textView.text = load(file: "\(dictArray[trackId]["title"]!)English")
            print("\(dictArray[trackId]["title"]!)English")
        default:
            break; 
        }
    }
    
    @IBAction func playClicked(_ sender: Any) {
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
    }
    @IBAction func stopClicked(_ sender: Any) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        progressView.progress = 0
    }
    @IBAction func pauseClicked(_ sender: Any) {
        audioPlayer.pause()
    }
    @IBAction func rewindClicked(_ sender: Any) {
        var time :TimeInterval = audioPlayer.currentTime
        time -= 5.0
        if time < 0 {
            stopClicked(self)
        }else {
            audioPlayer.currentTime = time
        }
    }
    @IBAction func fastForwardClicked(_ sender: Any) {
        var time :TimeInterval = audioPlayer.currentTime
        time += 5.0
        if time > audioPlayer.duration {
            stopClicked(self)
        }else {
            audioPlayer.currentTime = time
        }
    }
    @IBAction func preeviousClicked(_ sender: Any) {
      
        if trackId != 0 || trackId > 0 {
            
            //shuffle uiswitch on
            
//            if shuffle.isOn {
//                trackId = Int(arc4random_uniform(UInt32(dictArray.count)))
//            }else {
//                trackId -= 1
//            }
            
        trackId -= 1
        audioPlayer.currentTime = 0
        progressView.progress = 0
            print("Previous Clicked")
           print(segmentControl.selectedSegmentIndex)
            if segmentControl.selectedSegmentIndex == 0 {
                
                textView.text = load(file: dictArray[trackId]["title"]!)
            } else {
                textView.text = load(file: "\(dictArray[trackId]["title"]!)English")
            }
            
            //textView.text = load(file: dictArray[trackId]["title"]!)
            getTitle(titleName: dictArray[trackId]["title"]!)
            
        }

        
    }
    @IBAction func nextClicked(_ sender: Any) {
            
            if trackId == 0 || trackId < dictArray.count - 1 {
                
                //shuffle uiswitch on
//                if shuffle.isOn {
//                    trackId = Int(arc4random_uniform(UInt32(dictArray.count)))
//                }else {
//                trackId += 1
//                }
                
            trackId += 1
            audioPlayer.currentTime = 0
            progressView.progress = 0
               
               
                if segmentControl.selectedSegmentIndex == 0 {
                    
                    textView.text = load(file: dictArray[trackId]["title"]!)
                } else {
                    textView.text = load(file: "\(dictArray[trackId]["title"]!)English")
                }
                
                //textView.text = load(file: dictArray[trackId]["title"]!)
                getTitle(titleName: dictArray[trackId]["title"]!)
                
        }
   
    
    }
    
    //get selected song lyrics from rtf file
    @objc func load(file name:String) -> String {
        if let path = Bundle.main.path(forResource: name, ofType: "txt") {
            if let contents = try? String(contentsOfFile: path) {
                return contents
            } else {
                print("Error! - This file doesn't contain any text.")
            }
        } else {
            print("Error! - This file doesn't exist.")
        }
        return ""
    }
    //get song in mp3 formate
    @objc func getTitle(titleName:String){
        
        let path = Bundle.main.path(forResource: "\(titleName)", ofType: "mp3")
        
        if let path = path {
            let mp3URL = URL(fileURLWithPath: path)
          print(mp3URL);
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                audioPlayer.play()
                
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(playsongVc.updateProgressView), userInfo: nil, repeats: true)
                progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false) //need to cast it into float bcoz the result is in float type
                
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }

}
