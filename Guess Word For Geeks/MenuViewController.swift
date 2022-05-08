//
//  ViewController.swift
//  Guess Word For Geeks
//
//  Created by 林子轩 on 2022/4/30.
//

import UIKit
import CoreMotion

class MenuViewController: UIViewController {

    
    @IBOutlet var switches: [UISwitch]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func play(_ sender: Any) {
        var libs : [String] = []
        for s in switches {
            if s.isOn {
                libs.append(s.restorationIdentifier!)
            }
        }
        
        UserDefaults.set(value: libs, forKey: .selectedLibraries)
    }
    

}

