//
//  Level.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 20/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func levelUp() {
        
        if 1 <= Model.sharedInstance.score && Model.sharedInstance.score < 20 {
            stageLabel.text = "Stage 1"
            coinObject.speed = 1.05
            bigCoinObject.speed = 1.1
            enemyObject.speed = 1.05
            self.speed = 1.05
        } else if 20 <= Model.sharedInstance.score && Model.sharedInstance.score < 39 {
            stageLabel.text = "Stage 2"
            coinObject.speed = 1.22
            bigCoinObject.speed = 1.32
            enemyObject.speed = 1.22
            self.speed = 1.22
        } else if 40 <= Model.sharedInstance.score && Model.sharedInstance.score < 59 {
            stageLabel.text = "Stage 3"
            coinObject.speed = 1.3
            bigCoinObject.speed = 1.42
            enemyObject.speed = 1.3
            self.speed = 1.22
        } else if 60 <= Model.sharedInstance.score && Model.sharedInstance.score < 99 {
            stageLabel.text = "Stage 4"
            coinObject.speed = 1.4
            bigCoinObject.speed = 1.5
            enemyObject.speed = 1.5
            self.speed = 1.3
        } else if 100 <= Model.sharedInstance.score && Model.sharedInstance.score < 149 {
            stageLabel.text = "Stage 5"
            coinObject.speed = 1.5
            bigCoinObject.speed = 1.7
            enemyObject.speed = 1.8
            self.speed = 1.34
        } else if 150 <= Model.sharedInstance.score && Model.sharedInstance.score < 200 {
            stageLabel.text = "Stage 6"
            coinObject.speed = 1.6
            bigCoinObject.speed = 1.7
            enemyObject.speed = 2
            self.speed = 1.38
        }
    }
}
