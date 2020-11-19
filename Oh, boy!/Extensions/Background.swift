//
//  Background.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 19/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func createBg() {
        
        switch background.rawValue {
        case 0:
            bgSkyTexture = SKTexture(imageNamed: "sky.png")
            bgMountainTexture = SKTexture(imageNamed: "mountain.png")
            bgGroundTexture = SKTexture(imageNamed: "ground.png")
        case 1:
            bgSkyTexture = SKTexture(imageNamed: "sky_2.png")
            bgMountainTexture = SKTexture(imageNamed: "mountain_2.png")
            bgGroundTexture = SKTexture(imageNamed: "ground_2.png")
        default:
            break
        }
        
        let moveSky = SKAction.moveBy(x: -bgSkyTexture.size().width, y: 0, duration: 50)
        let moveMountain = SKAction.moveBy(x: -bgMountainTexture.size().width, y: 0, duration: 30)
        let moveGround = SKAction.moveBy(x: -bgGroundTexture.size().width, y: 0, duration: 3)
        
        let replaceSkyBg = SKAction.moveBy(x: bgSkyTexture.size().width, y: 0,  duration: 0)
        let replaceMountainBg = SKAction.moveBy(x: bgMountainTexture.size().width, y: 0,  duration: 0)
        let replaceGroundBg = SKAction.moveBy(x: bgGroundTexture.size().width, y: 0,  duration: 0)
        
        let moveSkyBgForever = SKAction.repeatForever(SKAction.sequence([moveSky, replaceSkyBg]))
        let moveMountainBgForever = SKAction.repeatForever(SKAction.sequence([moveMountain, replaceMountainBg]))
        let moveGroundBgForever = SKAction.repeatForever(SKAction.sequence([moveGround, replaceGroundBg]))
        
        bgSky.zPosition = -3
        bgMountain.zPosition = -2
        bgGround.zPosition = -1
        
        createBgForever(moveBgForever: moveSkyBgForever, bgTexture: bgSkyTexture, bgObject: skyBgObject, bg: &bgSky)
        createBgForever(moveBgForever: moveMountainBgForever, bgTexture: bgMountainTexture, bgObject: mountainBgObject, bg: &bgMountain)
        createBgForever(moveBgForever: moveGroundBgForever, bgTexture: bgGroundTexture, bgObject: groundBgObject, bg: &bgGround)
    }
    
    func createBgForever(moveBgForever: SKAction, bgTexture: SKTexture, bgObject: SKNode, bg: inout SKSpriteNode) {
        for i in 0..<3 {
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: size.width / 4 + bgTexture.size().width * CGFloat(i), y: size.height / 2.0)
            let screenSize = UIScreen.main.bounds
            if screenSize.width > 800 {
                bg.size.height = self.frame.height / 2
            } else {
                bg.size.height = self.frame.height / 1.35
            }
            bg.run(moveBgForever)
                       
            bgObject.addChild(bg)
        }
    }
}
