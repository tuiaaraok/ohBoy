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
  func didBegin(_ contact: SKPhysicsContact) {
         
         let objectNode = contact.bodyA.categoryBitMask == objectGroup ? contact.bodyA.node : contact.bodyB.node
         
         if contact.bodyA.categoryBitMask == objectGroup || contact.bodyB.categoryBitMask == objectGroup {
            death = true
            hero.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
                             
            if sound {
            run(deadPreload)
            }
                             
            hero.physicsBody?.allowsRotation = false
                             
            timerAddCoin.invalidate()
            timerAddBigCoin.invalidate()
            timerAddWorm.invalidate()
            timerAddSkull.invalidate()
                             
            heroDeathTexturesArray = [
                             SKTexture(imageNamed: "fail.png"),
                             SKTexture(imageNamed: "fail2.png"),
                             SKTexture(imageNamed: "fail3.png")
                 ]
            hero.size.height = 85
            hero.size.width = 130
            hero.position = CGPoint(x: self.size.width - 100, y: 0)
            let heroDeathAnimation = SKAction.animate(with: heroDeathTexturesArray,
                                                     timePerFrame: 0.1)
            hero.run(heroDeathAnimation)
                 
            if death {
                deathAction()
                                           
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.gameViewControllerBridge.reloadButton.isHidden = false
                }
            }
         }
         
         if contact.bodyA.categoryBitMask == groundGroup || contact.bodyB.categoryBitMask == groundGroup {
                 if death {
                     deathAction()
                 } else {
                     heroRunTexturesArray = [
                     SKTexture(imageNamed: "run_1.png"),
                     SKTexture(imageNamed: "run_2.png"),
                     SKTexture(imageNamed: "run_3.png"),
                     SKTexture(imageNamed: "run_4.png"),
                     SKTexture(imageNamed: "run_5.png"),
                     SKTexture(imageNamed: "run_6.png"),
                                ]
                     let heroRunAnimation = SKAction.animate(with: heroRunTexturesArray, timePerFrame: 0.08)
                     let heroRun = SKAction.repeatForever(heroRunAnimation)
                                
                     hero.run(heroRun)
                 }
         }
         
         if contact.bodyA.categoryBitMask == coinGroup || contact.bodyB.categoryBitMask == coinGroup {
             let coinNode = contact.bodyA.categoryBitMask == coinGroup ? contact.bodyA.node : contact.bodyB.node
             
             if sound == true {
                 run(pickCoinPreload)
             }
             
             coinNode?.removeFromParent()
         }
         
         if contact.bodyA.categoryBitMask == bigCoinGroup || contact.bodyB.categoryBitMask == bigCoinGroup {
             let bigCoinNode = contact.bodyA.categoryBitMask == bigCoinGroup ? contact.bodyA.node : contact.bodyB.node
             
             if sound == true {
                 run(pickCoinPreload)
             }
             
             bigCoinNode?.removeFromParent()
         }
     }
}
