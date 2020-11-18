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
    var textureAtlas = SKTextureAtlas(named: "scene.atlas")

    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.isHidden = false
        reloadButton.isHidden = true
        
        let view = self.view as! SKView
        view.ignoresSiblingOrder = true
            
        scene.scaleMode = .aspectFill
        scene.gameViewControllerBridge = self
        
        textureAtlas.preload {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.loadingView.isHidden = true
                view.presentScene(self.scene)
            } 
        }
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
