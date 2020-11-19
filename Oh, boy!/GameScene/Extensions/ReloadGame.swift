//
//  ReloadGame.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 19/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func reloadGame() {
        
        if Model.sharedInstance.sound {
            SKTAudio.sharedInstance().resumeBackgroundMusic()
        }
        death = false
        coinObject.removeAllChildren()
        bigCoinObject.removeAllChildren()
        
        stageLabel.text = "Stage 1"
        gameOver = 0
        scene?.isPaused = false
           
        enemyObject.removeAllChildren()
        heroObject.removeAllChildren()
           
        coinObject.speed = 1
        heroObject.speed = 1
        enemyObject.speed = 1
        groundBgObject.isPaused = false
        mountainBgObject.isPaused = false
        self.scene?.speed = 1
        
        if labelObject.children.count != 0 {
            labelObject.removeAllChildren()
        }
           
        createGround()
        createSky()
        createHero()
        createShoeEmitter()
        
        gameViewController.toMainMenuButton.isHidden = true
        
        Model.sharedInstance.score = 0
        scoreLabel.text = "0"
        stageLabel.isHidden = false
        highScoreTextLabel.isHidden = true
        showHighScore()
        
        timerInvalidate()
       
        addTimer()
    }
    
    func removeAll() {
        Model.sharedInstance.score = 0
        scoreLabel.text = "0"
        
        gameOver = 0
        
        if labelObject.children.count != 0 {
            labelObject.removeAllChildren()
        }
        
        timerInvalidate()
        self.removeAllActions()
        self.removeAllChildren()
        self.removeFromParent()
        self.view?.removeFromSuperview()
        gameViewController = nil
    }
}
