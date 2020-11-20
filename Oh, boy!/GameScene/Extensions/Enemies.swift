//
//  Enemies.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 19/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    @objc func addWorm() {
        
        if Model.sharedInstance.sound {
            run(wormPreload)
        }
                       
        worm = SKSpriteNode(texture: wormTexture)
        wormTexturesArray = [
               SKTexture(imageNamed: "worm_1.png"), SKTexture(imageNamed: "worm_2.png"),
               SKTexture(imageNamed: "worm_3.png"), SKTexture(imageNamed: "worm_4.png"),
               SKTexture(imageNamed: "worm_5.png"), SKTexture(imageNamed: "worm_6.png"),
               SKTexture(imageNamed: "worm_7.png"), SKTexture(imageNamed: "worm_8.png"),
               SKTexture(imageNamed: "worm_9.png"), SKTexture(imageNamed: "worm_10.png")
        ]
           
        let wormAnimation = SKAction.animate(with: wormTexturesArray, timePerFrame: 0.04)
        let wormAnimationRepeat = SKAction.repeatForever(wormAnimation)
        worm.run(wormAnimationRepeat)
                
        worm.size.width = 130
        worm.size.height = 130
        worm.speed  = 1
                
        var scaleValue: CGFloat = 0.3
                       
        let scaleRandom = arc4random() % UInt32(5)
        if scaleRandom == 1 { scaleValue = 0.7 }
        else  if scaleRandom == 2 { scaleValue = 0.6 }
        else  { scaleValue = 0.5 }
        
        worm.setScale(scaleValue)
                    
        if screenSize.width > 800 {
            worm.position = CGPoint(x: self.frame.size.width + 150,
                                    y: self.frame.size.height / 4 - self.frame.size.height / 24 + 50)
        } else {
            worm.position = CGPoint(x: self.frame.size.width + 150,
                                    y: self.frame.size.height / 4 - 30)
        }
                       
        let moveSpiderX = SKAction.moveTo(x: -self.frame.size.width / 4, duration: 4)
        worm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: worm.size.width - 40,
                                                             height: worm.size.height - 30))
        worm.physicsBody?.categoryBitMask = objectGroup
        worm.physicsBody?.isDynamic = false
                       
        let removeAction = SKAction.removeFromParent()
        let wormMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveSpiderX, removeAction]))
                       
        worm.run(wormMoveBgForever)
        worm.zPosition = 1
        enemyObject.addChild(worm)
    }
       
    func createMoveEnemyY(i: UInt32) -> SKAction {
        let movementRandom = arc4random() % i
        if movementRandom == 0 {
            moveEnemyY = SKAction.moveTo(y: self.frame.height / 2 + 180, duration: 8)
        } else if movementRandom == 1 {
            moveEnemyY = SKAction.moveTo(y: self.frame.height / 2 - 180, duration: 5)
        } else if movementRandom == 2 {
            moveEnemyY = SKAction.moveTo(y: self.frame.height / 2 - 200, duration: 8)
        } else if movementRandom == 3 {
            moveEnemyY = SKAction.moveTo(y: self.frame.height / 2 + 200, duration: 5)
        } else if movementRandom == 4 {
            moveEnemyY = SKAction.moveTo(y: self.frame.height / 2 + 40, duration: 4)
        } else if movementRandom == 5 {
            moveEnemyY = SKAction.moveTo(y: self.frame.height / 2 - 35, duration: 5)
        } else {
            moveEnemyY = SKAction.moveTo(y: self.frame.height / 2, duration: 4)
        }
        return moveEnemyY
    }
       
    @objc func addSkull() {
        if Model.sharedInstance.sound {
            run(skullPreload)
        }
                            
        skull = SKSpriteNode(texture: skullTexture)
        skull.run(createMoveEnemyY(i: 11))
                   
        skull.size.width = 100
        skull.size.height = 70
        skull.speed  = 2.3
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        skull.position = CGPoint(x: self.frame.size.width + 150,
                                 y: 450 + pipeOffset)
                            
        let moveSkullX = SKAction.moveTo(x: -self.frame.size.width / 2, duration: 8)
        skull.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: skull.size.width - 43,
                                                              height: skull.size.height - 27))
        skull.physicsBody?.categoryBitMask = objectGroup
        skull.physicsBody?.isDynamic = false
                            
        let removeAction = SKAction.removeFromParent()
        let skullMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveSkullX, removeAction]))
                            
        skull.run(skullMoveBgForever)
        skull.zPosition = 1
        enemyObject.addChild(skull)
    }
       
    @objc func addSlimeMonster() {
        if Model.sharedInstance.sound {
            run(slimeMonsterPreload)
        }
                          
        slimeMonster = SKSpriteNode(texture: slimeMonsterTexture)
        slimeMonsterTexturesArray = [
                  SKTexture(imageNamed: "slimeMonster0.png"), SKTexture(imageNamed: "slimeMonster0.png"),
                  SKTexture(imageNamed: "slimeMonster0.png"), SKTexture(imageNamed: "slimeMonster1.png"),
                  SKTexture(imageNamed: "slimeMonster2.png"), SKTexture(imageNamed: "slimeMonster3.png"),
                  SKTexture(imageNamed: "slimeMonster4.png"), SKTexture(imageNamed: "slimeMonster5.png"),
                  SKTexture(imageNamed: "slimeMonster0.png"), SKTexture(imageNamed: "slimeMonster0.png"), SKTexture(imageNamed: "slimeMonster0.png"),   SKTexture(imageNamed: "slimeMonster0.png"),   SKTexture(imageNamed: "slimeMonster0.png")
              ]
              
        let slimeMonsterAnimation = SKAction.animate(with: slimeMonsterTexturesArray, timePerFrame: 0.1)
        let slimeMonsterAnimationRepeat = SKAction.repeatForever(slimeMonsterAnimation)
        slimeMonster.run(slimeMonsterAnimationRepeat)
                   
        slimeMonster.size.width = 130
        slimeMonster.size.height = 130
        slimeMonster.speed  = 1
                       
        if screenSize.width > 800 {
            slimeMonster.position = CGPoint(x: self.frame.size.width + 150,
                                            y: self.frame.size.height / 4 - self.frame.size.height / 24 + 80)
        } else {
            slimeMonster.position = CGPoint(x: self.frame.size.width + 150,
                                            y: self.frame.size.height / 4 )
        }
                          
        let moveSlimeMonsterX = SKAction.moveTo(x: -self.frame.size.width / 3, duration: 3)
        slimeMonster.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: slimeMonster.size.width - 40, height: slimeMonster.size.height - 30))
        slimeMonster.physicsBody?.categoryBitMask = objectGroup
        slimeMonster.physicsBody?.isDynamic = false
                          
        let removeAction = SKAction.removeFromParent()
        let slimeMonsterMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveSlimeMonsterX, removeAction]))
                          
        slimeMonster.run(slimeMonsterMoveBgForever)
        slimeMonster.zPosition = 1
        enemyObject.addChild(slimeMonster)
        }
       
    @objc func addGreenMonster() {
        if Model.sharedInstance.sound {
            run(greenMonsterPreload)
        }
                  
        greenMonster = SKSpriteNode(texture: greenMonsterTexture)
        greenMonsterTexturesArray = [
               SKTexture(imageNamed: "greenMonster1.png"),
               SKTexture(imageNamed: "greenMonster2.png"),
               SKTexture(imageNamed: "greenMonster3.png"),
               SKTexture(imageNamed: "greenMonster4.png"),
               SKTexture(imageNamed: "greenMonster5.png"),
               SKTexture(imageNamed: "greenMonster6.png")
        ]
        let greenMonsterAnimation = SKAction.animate(with: greenMonsterTexturesArray, timePerFrame: 0.03)
        let greenMonsterAnimationRepeat = SKAction.repeatForever(greenMonsterAnimation)
        greenMonster.run(greenMonsterAnimationRepeat)
           
        greenMonster.size.width = 80
        greenMonster.size.height = 65
        greenMonster.speed  = 1.5
           
        var scaleValue: CGFloat = 0.3
                  
        let scaleRandom = arc4random() % UInt32(5)
        if scaleRandom == 1 { scaleValue = 0.9 }
        else  if scaleRandom == 2 { scaleValue = 0.6 }
        else if scaleRandom == 3 { scaleValue = 0.8 }
        else if scaleRandom == 4 { scaleValue = 0.7 }
        else if scaleRandom == 0 { scaleValue = 1.0 }
                  
        greenMonster.setScale(scaleValue)
               
        if screenSize.width > 800 {
            greenMonster.position = CGPoint(x: self.frame.size.width + 150,
                                            y: self.frame.size.height / 4 - self.frame.size.height / 24 + 40)
        } else {
            greenMonster.position = CGPoint(x: self.frame.size.width + 150,
                                            y: self.frame.size.height / 4 - self.frame.size.height / 24)
        }
                  
        let moveGreenMonsterX = SKAction.moveTo(x: -self.frame.size.width / 4, duration: 2)
        greenMonster.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: greenMonster.size.width - 40, height: greenMonster.size.height - 30))
        greenMonster.physicsBody?.categoryBitMask = objectGroup
        greenMonster.physicsBody?.isDynamic = false
                  
        let removeAction = SKAction.removeFromParent()
        let spiderMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveGreenMonsterX, removeAction]))
                  
        greenMonster.run(spiderMoveBgForever)
        greenMonster.zPosition = 1
        enemyObject.addChild(greenMonster)
    }
       
    @objc func addUfo() {
        if Model.sharedInstance.sound {
            run(ufoPreload)
        }
                     
        ufo = SKSpriteNode(texture: ufoTexture)
        ufo.run(createMoveEnemyY(i: 9))
              
        ufo.size.width = 70
        ufo.size.height = 50
        ufo.speed  = 2.8
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        ufo.position = CGPoint(x: self.frame.size.width + 150, y: self.frame.size.height / 3 - self.frame.size.height / 24 + pipeOffset)
                     
        let moveUfoX = SKAction.moveTo(x: -self.frame.size.width / 2, duration: 3.7)
        ufo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ufo.size.width - 43,
                                                            height: ufo.size.height - 27))
        ufo.physicsBody?.categoryBitMask = objectGroup
        ufo.physicsBody?.isDynamic = false
                     
        let removeAction = SKAction.removeFromParent()
        let ufoMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveUfoX, removeAction]))
                     
        ufo.run(ufoMoveBgForever)
        ufo.zPosition = 1
        enemyObject.addChild(ufo)
    }
}
