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
        
        if Model.sharedInstance.score > Model.sharedInstance.highScore {
            Model.sharedInstance.highScore = Model.sharedInstance.score
        }
        UserDefaults.standard.set( Model.sharedInstance.highScore, forKey: "highScore")
         
         if contact.bodyA.categoryBitMask == objectGroup || contact.bodyB.categoryBitMask == objectGroup {
            death = true
            hero.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
            if !shieldBool {
                animation.shakeAndFlashAnimation(view: self.view!)
                leftShoeEmitter.isHidden = true
                rightShoeEmitter.isHidden = true
                
                if Model.sharedInstance.sound {
                    run(deadPreload)
                    death = false
                }
                
                Model.sharedInstance.totalscore = Model.sharedInstance.totalscore + Model.sharedInstance.score
                                 
                hero.physicsBody?.allowsRotation = false

                timerInvalidate()
                
                heroDeathTexturesArray = [SKTexture(imageNamed: "fail0.png"),
                                          SKTexture(imageNamed: "fail.png")]
                hero.size.height = 85
                hero.size.width = 130
                hero.position = CGPoint(x: self.size.width - 100, y: 0)
                let heroDeathAnimation = SKAction.animate(with: heroDeathTexturesArray,
                                                         timePerFrame: 0.1)
                hero.run(heroDeathAnimation)
                
                showHighScore()
                 gameOver = 1

                deathAction()
                                               
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showHighScoreText()
                    self.gameViewController.reloadButton.isHidden = false
                    self.gameViewController.toMainMenuButton.isHidden = false
                    self.gameViewController.pauseButton.isHidden = true
                    self.stageLabel.isHidden = true
                        
                    if Model.sharedInstance.score > Model.sharedInstance.highScore {
                        Model.sharedInstance.highScore = Model.sharedInstance.score
                    }
                        
                    self.highScoreLabel.isHidden = false
                    self.highScoreTextLabel.isHidden = false
                    self.highScoreLabel.text = "\( Model.sharedInstance.highScore)"
                }
                SKTAudio.sharedInstance().pauseBackgroundMusic()
            } else {
                death = false
                objectNode?.removeFromParent()
                shieldObject.removeAllChildren()
                shieldBool = false 
            }
         }
    
        if contact.bodyA.categoryBitMask == shieldGroup || contact.bodyB.categoryBitMask == shieldGroup {
            levelUp()
            let shieldNode = contact.bodyA.categoryBitMask == shieldGroup ? contact.bodyA.node : contact.bodyB.node
            if !shieldBool {
                if Model.sharedInstance.sound { run(shieldOnPreload) }
                shieldNode?.removeFromParent()
                addShield()
                shieldBool = true
            }
        }
         
         if contact.bodyA.categoryBitMask == groundGroup || contact.bodyB.categoryBitMask == groundGroup {
             leftShoeEmitter.isHidden = true
             rightShoeEmitter.isHidden = true
            if gameOver == 0 {
                if death {
                    deathAction()
                } else {
                    heroRunTexturesArray = [
                    SKTexture(imageNamed: "frame-1.png"),
                    SKTexture(imageNamed: "frame-2.png"),
                    SKTexture(imageNamed: "frame-3.png"),
                    SKTexture(imageNamed: "frame-4.png"),
                    SKTexture(imageNamed: "frame-5.png"),
                    SKTexture(imageNamed: "frame-6.png"),
                    ]
                    let heroRunAnimation = SKAction.animate(with: heroRunTexturesArray, timePerFrame: 0.08)
                    let heroRun = SKAction.repeatForever(heroRunAnimation)
                                            
                    hero.run(heroRun)
                }
            }
         }
         
         if contact.bodyA.categoryBitMask == coinGroup || contact.bodyB.categoryBitMask == coinGroup {
            levelUp()
             let coinNode = contact.bodyA.categoryBitMask == coinGroup ? contact.bodyA.node : contact.bodyB.node
             
             if Model.sharedInstance.sound {
                 run(pickCoinPreload)
             }
            
            switch stageLabel.text! {
            case "Stage 1":
                if level.rawValue == 0 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 1
                } else if level.rawValue == 1 {
                     Model.sharedInstance.score = Model.sharedInstance.score + 2
                } else if level.rawValue == 2 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 3
                }
            case "Stage 2":
                if level.rawValue == 0 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 2
                } else if level.rawValue == 1 {
                     Model.sharedInstance.score = Model.sharedInstance.score + 3
                } else if level.rawValue == 2 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 4
                }
            default:
                if level.rawValue == 0 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 3
                } else if level.rawValue == 1 {
                     Model.sharedInstance.score = Model.sharedInstance.score + 4
                } else if level.rawValue == 2 {
                    Model.sharedInstance.score = Model.sharedInstance.score + 5
                }
            }
        
             scoreLabel.text = "\(Model.sharedInstance.score)"
             
             coinNode?.removeFromParent()
         }
         
         if contact.bodyA.categoryBitMask == bigCoinGroup || contact.bodyB.categoryBitMask == bigCoinGroup {
            levelUp()
            
            let bigCoinNode = contact.bodyA.categoryBitMask == bigCoinGroup ? contact.bodyA.node : contact.bodyB.node
             
             if Model.sharedInstance.sound  {
                 run(pickCoinPreload)
             }
            
            switch stageLabel.text! {
                case "Stage 1":
                    if level.rawValue == 0 {
                        Model.sharedInstance.score = Model.sharedInstance.score + 2
                    } else if level.rawValue == 1 {
                        Model.sharedInstance.score = Model.sharedInstance.score + 3
                    } else if level.rawValue == 2 {
                        Model.sharedInstance.score = Model.sharedInstance.score + 4
                    }
                case "Stage 2":
                    if level.rawValue == 0 {
                        Model.sharedInstance.score = Model.sharedInstance.score + 3
                    } else if level.rawValue == 1 {
                        Model.sharedInstance.score = Model.sharedInstance.score + 4
                    } else if level.rawValue == 2 {
                        Model.sharedInstance.score = Model.sharedInstance.score + 5
                    }
                default:
                    if level.rawValue == 0 {
                        Model.sharedInstance.score = Model.sharedInstance.score + 4
                    } else if level.rawValue == 1 {
                        Model.sharedInstance.score = Model.sharedInstance.score + 5
                    } else if level.rawValue == 2 {
                        Model.sharedInstance.score = Model.sharedInstance.score + 6
                    }
                }
            scoreLabel.text = "\(Model.sharedInstance.score)"
             
             bigCoinNode?.removeFromParent()
         }
        UserDefaults.standard.set( Model.sharedInstance.totalscore, forKey: "totalScore")
     }
}
