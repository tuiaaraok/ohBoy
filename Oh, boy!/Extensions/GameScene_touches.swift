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
           
        hero.physicsBody?.velocity = CGVector.zero
        hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 180))
           
        heroflyTexturesArray = [SKTexture(imageNamed: "jump_up.png")]
        let heroFlyAnimation = SKAction.animate(with: heroflyTexturesArray, timePerFrame: 0.1)
        let flyHero = SKAction.repeatForever(heroFlyAnimation)
        hero.run(flyHero)
           
    }
}
