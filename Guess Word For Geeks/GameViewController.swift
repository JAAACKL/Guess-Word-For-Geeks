//
//  ViewController.swift
//  Guess Word For Geeks
//
//  Created by 林子轩 on 2022/4/30.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController {
    
    var guessing : Bool = false
    var gameStart : Bool = false
    
    var score : Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var time : Int = 300 {
        didSet {
            timeLabel.text = "Time: \(time)"
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let motionManager = CMMotionManager()
    let wordManager = WordManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        motionManager.startDeviceMotionUpdates()
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [self] timer in
            if gameStart {
                if let data = self.motionManager.deviceMotion {
                    let tilt = data.attitude.roll / -.pi
                    print(tilt)
                    if tilt > 0.7 {
                        view.backgroundColor = .green
                        if guessing {
                            score += 1
                            wordManager.record(true)
                            guessing = false
                        }
                    } else if tilt < 0.3  {
                        view.backgroundColor = .red
                        if guessing {
                            wordManager.record(false)
                            guessing = false
                        }
                    } else {
                        view.backgroundColor = .white
                        if !guessing {
                            guessing = true
                            let nextWord = wordManager.next()
                            wordLabel.text = nextWord[0]
                            descriptionLabel.text = nextWord[1]
                        }
                    }
                }
            }
            if time == 0 {
                timer.invalidate()
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            if gameStart {
                time -= 1
            }
            if time == 0 {
                timer.invalidate()
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "end") as! ResultsViewController
                nextViewController.modalPresentationStyle = .fullScreen
                nextViewController.score = self.score
                nextViewController.summary = wordManager.getSummary()
                self.present(nextViewController, animated:true, completion:nil)
            }
        }
        
        var countDown : Int = 3
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            descriptionLabel.text = "Get Ready"
            countDown -= 1
            wordLabel.text = "\(countDown)"
            if countDown == 0 {
                timer.invalidate()
                gameStart = true
            }
        }
        
        
    }

    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    

}

