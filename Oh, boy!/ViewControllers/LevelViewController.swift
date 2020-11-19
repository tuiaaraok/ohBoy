//
//  DifficultyViewController.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 18/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit
import SpriteKit

class LevelViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func selectLevel(sender: UIButton) {
        SKTAudio.sharedInstance().playBackgroundMusic(filename: "")
        
        if let storyboard = storyboard {
            let selectBgViewController = storyboard.instantiateViewController(withIdentifier: "SelectBgViewController") as! SelectBgViewController
                   
            selectBgViewController.level = Level(rawValue: sender.tag)!
                   
            navigationController?.pushViewController(selectBgViewController, animated: true)
                   
        }
    }
    
    @IBAction func back() {
        navigationController?.popViewController(animated: true)
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
