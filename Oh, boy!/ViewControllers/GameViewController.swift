//
//  GameViewController.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 17/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene = GameScene(size: CGSize(width: 1024, height: 768))

    @IBOutlet weak var reloadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = self.view as! SKView
        view.ignoresSiblingOrder = true
            
        scene.scaleMode = .aspectFill
        scene.gameViewControllerBridge = self

        view.presentScene(scene)
    }
    
    @IBAction func reloadGameButtonPressed(_ sender: UIButton) {
        scene.reloadGame()
        scene.gameViewControllerBridge = self
        reloadButton.isHidden = true
    }
    

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
