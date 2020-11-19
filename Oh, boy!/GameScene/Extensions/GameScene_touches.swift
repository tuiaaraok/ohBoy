//
//  GameScene_touches.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 17/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        leftShoeEmitter.isHidden = false
        rightShoeEmitter.isHidden = false
        
       if gameOver == 0 {
           if !tapToPlayLabel.isHidden {
               tapToPlayLabel.isHidden = true
           }
           
           if gameOver == 0{
               hero.physicsBody?.velocity = CGVector.zero
               hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
                                 
               heroFlyTexturesArray = [SKTexture(imageNamed: "jump_up.png")]
               let heroFlyAnimation = SKAction.animate(with: heroFlyTexturesArray, timePerFrame: 0.02)
               let flyHero = SKAction.repeatForever(heroFlyAnimation)
               hero.run(flyHero)
               run(heroFlyPreload)
           }
       }
   }
}
