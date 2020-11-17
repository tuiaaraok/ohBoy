//
//  GameScene_physics.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 17/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    @objc(didBeginContact:)
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == groundGroup || contact.bodyB.categoryBitMask == groundGroup {
               
            heroRunTexturesArray =  [SKTexture(imageNamed: "run_1.png"), SKTexture(imageNamed: "run_2.png"), SKTexture(imageNamed: "run_3.png"), SKTexture(imageNamed: "run_4.png"), SKTexture(imageNamed: "run_5.png"), SKTexture(imageNamed: "run_6.png")]
            let heroRunAnimation = SKAction.animate(with: heroRunTexturesArray, timePerFrame: 0.08)
            let heroRun = SKAction.repeatForever(heroRunAnimation)
               
            hero.run(heroRun)
        }
    }
}
