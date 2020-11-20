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
    
    //Variables
    var selectedBg: Background!
    var selectedLevel: Level!
    var isPlay: Bool!

    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var toMainMenuButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.isHidden = false
        reloadButton.isHidden = true
        pauseButton.isHidden = false
        continueButton.isHidden = true
        
        let view = self.view as! SKView
        view.ignoresSiblingOrder = true
            
        scene.scaleMode = .aspectFill
        scene.background = selectedBg
        scene.level = selectedLevel
        scene.gameViewController = self
        
        textureAtlas.preload {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.loadingView.isHidden = true
                view.presentScene(self.scene)
                self.pauseButton.isHidden = false
                self.isPlay = true
            } 
        }
    }
    
    @IBAction func reloadGameButtonPressed(_ sender: UIButton) {
        SKTAudio.sharedInstance().playSoundEffect(filename: "push.mp3")
        scene.reloadGame()
        scene.gameViewController = self
        reloadButton.isHidden = true
        continueButton.isHidden = true
        pauseButton.isHidden = false
    }
    
    @IBAction func mainMenuButtonPressed() {
        SKTAudio.sharedInstance().playSoundEffect(filename: "push.mp3")
        navigationController?.popViewController(animated: false)
        navigationController?.dismiss(animated: false, completion: nil)
        
        DispatchQueue.main.async {
            self.scene.removeAll()
        }
    }
    
    @IBAction func pause() {
        
        SKTAudio.sharedInstance().playSoundEffect(filename: "push.mp3")
        scene.isPaused = true
        scene.timerInvalidate()
        scene.tapToPlayLabel.isHidden = true
        reloadButton.isHidden = false
        toMainMenuButton.isHidden = false
        continueButton.isHidden = false
        pauseButton.isHidden = true
    }
    
    @IBAction func continueButtonPressed () {
        
        SKTAudio.sharedInstance().playSoundEffect(filename: "push.mp3")
        reloadButton.isHidden = true
        toMainMenuButton.isHidden = true
        pauseButton.isHidden = false
        continueButton.isHidden = true
        scene.isPaused = false
        scene.addTimer()
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
