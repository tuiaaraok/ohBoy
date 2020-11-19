//
//  SelectBgViewController.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 18/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit
import SpriteKit

class SelectBgViewController: UIViewController {
    
    var level: Level!
    
    @IBOutlet weak var totalPoint: UILabel!
    @IBOutlet weak var bg1: UIButton!
    @IBOutlet weak var bg2: UIButton!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Model.sharedInstance.sound == true {
            SKTAudio.sharedInstance().resumeBackgroundMusic()
        }
        
        totalPoint.text = "\(Model.sharedInstance.totalscore)"
        
        if Model.sharedInstance.totalscore > Model.sharedInstance.level2UnlockValue {
            let image = UIImage(named: "bg2.png")
            bg2.setBackgroundImage(image, for: .normal)
        }
    }
    
    @IBAction func selectBg(sender: UIButton) {
        SKTAudio.sharedInstance().playSoundEffect(filename: "")
               
        if let storyboard = storyboard {
            let gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
                   
            gameViewController.selectedBg = Background(rawValue: sender.tag)!
            gameViewController.selectedLevel = level
                   
            if gameViewController.selectedBg.rawValue == 0 {
                navigationController?.pushViewController(gameViewController, animated: true)
            } else if gameViewController.selectedBg.rawValue == 1 && Model.sharedInstance.totalscore > Model.sharedInstance.level2UnlockValue {
                navigationController?.pushViewController(gameViewController, animated: true)
            }
        }
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
