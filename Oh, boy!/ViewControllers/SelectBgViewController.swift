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
    @IBOutlet weak var bg3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonLayer(button: bg1)
        configureButtonLayer(button: bg2)
        configureButtonLayer(button: bg3)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Model.sharedInstance.sound == true {
            SKTAudio.sharedInstance().resumeBackgroundMusic()
        }
        
        totalPoint.text = "\(Model.sharedInstance.totalscore)"
        
        if Model.sharedInstance.totalscore > Model.sharedInstance.level2UnlockValue {
            let image = UIImage(named: "bg2.png")
            bg2.setBackgroundImage(image, for: .normal)
            bg2.setTitle("", for: .normal)
        }
        
        if Model.sharedInstance.totalscore > Model.sharedInstance.level3UnlockValue {
            let image = UIImage(named: "bg3.png")
            bg3.setBackgroundImage(image, for: .normal)
            bg3.setTitle("", for: .normal)
        }
    }
    
    @IBAction func selectBg(sender: UIButton) {
        SKTAudio.sharedInstance().playSoundEffect(filename: "push.mp3")
               
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
        SKTAudio.sharedInstance().playSoundEffect(filename: "push.mp3")
        navigationController?.popViewController(animated: true)
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func configureButtonLayer(button: UIButton) {

        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 5
    }
}
