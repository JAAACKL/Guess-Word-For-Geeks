//
//  ResultsViewController.swift
//  Guess Word For Geeks
//
//  Created by 林子轩 on 2022/5/3.
//

import Foundation
import UIKit
import CoreMotion

class ResultsViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    var score : Int = 0
    var summary : [(String, Bool)] = []
    @IBOutlet weak var summaryText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        var text = ""
        for entry in summary {
            text += "\(entry.0) \(entry.1 ? 1:0)\n"
        }
        summaryText.text = text
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

