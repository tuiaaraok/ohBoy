//
//  MainViewController.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 18/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit
import SpriteKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "totalScore") != nil {
            Model.sharedInstance.totalscore = UserDefaults.standard.object(forKey: "totalScore") as! Int
        }
        
        if Model.sharedInstance.sound {
            SKTAudio.sharedInstance().playBackgroundMusic(filename: "backgr.mp3")
        }
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        SKTAudio.sharedInstance().playSoundEffect(filename: "")
        if let storyboard = storyboard {
            let gameViewController = storyboard.instantiateViewController(identifier: "DifficultyViewController") as! LevelViewController
            navigationController?.pushViewController(gameViewController, animated: true)
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
