//
//  GameScene.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 17/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Variables
    var sound = true
    var death = false
    var moveEnemyY = SKAction()
    var gameViewControllerBridge: GameViewController!
    var animation = Animation()
    var shieldBool = false
    var score = 0
    var highScore = 0
    
    // Texture
    var bgSkyTexture: SKTexture!
    var bgMountainTexture: SKTexture!
    var bgGroundTexture: SKTexture!
    var jumpHeroTex: SKTexture!
    var runHeroTex: SKTexture!
    var coinTexture: SKTexture!
    var bigCoinTexture: SKTexture!
    var coinAnimateTexture: SKTexture!
    var bigCoinAnimateTexture: SKTexture!
    var wormTexture: SKTexture!
    var deadHeroTexture: SKTexture!
    var skullTexture: SKTexture!
    var slimeMonsterTexture: SKTexture!
    var greenMonsterTexture: SKTexture!
    var ufoTexture: SKTexture!
    var shieldTexture: SKTexture!
    var shieldBottleTexture: SKTexture!
    
    
    // Emitters node
    var shieldEmitter = SKEmitterNode()
    
    // Sprite Nodes
    var bgSky = SKSpriteNode()
    var bgMountain = SKSpriteNode()
    var bgGround = SKSpriteNode()
    var ground = SKSpriteNode()
    var sky = SKSpriteNode()
    var hero = SKSpriteNode()
    var coin = SKSpriteNode()
    var bigCoin = SKSpriteNode()
    var worm = SKSpriteNode()
    var skull = SKSpriteNode()
    var slimeMonster = SKSpriteNode()
    var greenMonster = SKSpriteNode()
    var ufo = SKSpriteNode()
    var shieldBottle = SKSpriteNode()
    
    // Label nodes
    var tapToPlayLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var highScoreLabel = SKLabelNode()
    var highScoreTextLabel = SKLabelNode()
    var stageLabel = SKLabelNode()
    
    // Sprites Objects
    var skyBgObject = SKNode()
    var mountainBgObject = SKNode()
    var groundBgObject = SKNode()
    var groundObject = SKNode()
    var skyObject = SKNode()
    var heroObject = SKNode()
    var coinObject = SKNode()
    var bigCoinObject = SKNode()
    var movingObject = SKNode()
    var shieldObject = SKNode()
    var shieldItemObject = SKNode()
    var shieldEmitterObject = SKNode()
    var labelObject = SKNode()
    
    // Bit masks
    var heroGroup: UInt32 = 0x1 << 1
    var groundGroup: UInt32 = 0x1 << 2
    var coinGroup: UInt32 = 0x1 << 3
    var bigCoinGroup: UInt32 = 0x1 << 4
    var objectGroup: UInt32 = 0x1 << 5
    var shieldGroup: UInt32 = 0x1 << 6
    
    // Textures array for animateWithTexture
    var heroflyTexturesArray = [SKTexture]()
    var heroRunTexturesArray = [SKTexture]()
    var coinTexturesArray = [SKTexture]()
    var wormTexturesArray = [SKTexture]()
    var slimeMonsterTexturesArray = [SKTexture]()
    var greenMonsterTexturesArray = [SKTexture]()
    var heroDeathTexturesArray = [SKTexture]()
    
    //Timers
    var timerAddCoin = Timer()
    var timerAddBigCoin = Timer()
    var timerAddWorm = Timer()
    var timerAddSkull = Timer()
    var timerAddShieldItem = Timer()
    var timerAddSlimeMonster = Timer()
    var timerAddGreenMonster = Timer()
    var timerAddUfo = Timer()
    
    // Sounds
//    var pickCoinPreload = SKAction()
    var wormPreload = SKAction()
    var deadPreload = SKAction()
    var skullPreload = SKAction()
    var slimeMonsterPreload = SKAction()
    var greenMonsterPreload = SKAction()
    var ufoPreload = SKAction()
    var shieldOnPreload = SKAction()
    var shieldOffPreload = SKAction()
    
    override func didMove(to view: SKView) {
        
        // Background texture
        bgSkyTexture = SKTexture(imageNamed: "sky.png")
        bgMountainTexture = SKTexture(imageNamed: "mountain.png")
        bgGroundTexture = SKTexture(imageNamed: "ground.png")
        
        // Hero texture
        jumpHeroTex = SKTexture(imageNamed: "jump_up.png")
        runHeroTex = SKTexture(imageNamed: "run_1.png")
        
        // Coin texture
        coinTexture = SKTexture(imageNamed: "Coin0.png")
        bigCoinTexture = SKTexture(imageNamed: "Coin0.png")
        coinAnimateTexture = SKTexture(imageNamed: "Coin0.png")
        bigCoinAnimateTexture = SKTexture(imageNamed: "Coin0.png")
        coinTexturesArray = [SKTexture(imageNamed: "Coin0.png"),
                             SKTexture(imageNamed: "Coin1.png"),
                             SKTexture(imageNamed: "Coin2.png"),
                             SKTexture(imageNamed: "Coin3.png")]
        
        // Enemies texture
        wormTexture = SKTexture(imageNamed: "worm_1.png")
        skullTexture = SKTexture(imageNamed: "skull.png")
        slimeMonsterTexture = SKTexture(imageNamed: "slimeMonster0.png")
        greenMonsterTexture = SKTexture(imageNamed: "greenMonster1.png")
        ufoTexture = SKTexture(imageNamed: "ufo.png")
        
        // Shield texture
        shieldTexture = SKTexture(imageNamed: "engine.sks")
        shieldBottleTexture = SKTexture(imageNamed: "shieldBottle.png")
        
        // Emitters
        shieldEmitter = SKEmitterNode(fileNamed: "engine.sks")!
        
        self.physicsWorld.contactDelegate = self
        
        createObjects()
        createGame()
        
//        pickCoinPreload = SKAction.playSoundFileNamed("pickCoin.mp3", waitForCompletion: false)
        wormPreload = SKAction.playSoundFileNamed("worm.mp3", waitForCompletion: false)
        deadPreload = SKAction.playSoundFileNamed("", waitForCompletion: false)
        skullPreload = SKAction.playSoundFileNamed("", waitForCompletion: false)
        slimeMonsterPreload = SKAction.playSoundFileNamed("", waitForCompletion: false)
        greenMonsterPreload = SKAction.playSoundFileNamed("", waitForCompletion: false)
        ufoPreload = SKAction.playSoundFileNamed("", waitForCompletion: false)
        shieldOnPreload = SKAction.playSoundFileNamed("", waitForCompletion: false)
        
    }
    
    func createObjects() {
        // Background objects
        self.addChild(skyBgObject)
        self.addChild(mountainBgObject)
        self.addChild(groundBgObject)
        
        self.addChild(skyObject)
        self.addChild(groundObject)
        self.addChild(heroObject)
        self.addChild(coinObject)
        self.addChild(bigCoinObject)
        self.addChild(movingObject)
        self.addChild(shieldObject)
        self.addChild(shieldItemObject)
        self.addChild(labelObject)
    }
    
    func createGame() {
        createBg()
        createGround()
        createSky()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.createHero()
            self.addTimer()
//            self.addWorm()
//            self.addSkull()
//            self.addSlimeMonster()
//            self.addGreenMonster()
//            self.addUfo()
        }
        
        gameViewControllerBridge.reloadButton.isHidden = true
    }
    
    func createBg() {
        
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
    
    func createGround() {
        ground = SKSpriteNode()
        let screenSize = UIScreen.main.bounds
        if screenSize.width > 800 {
            ground.position = CGPoint(x: 0, y: self.frame.minX + 40)
        } else {
            ground.position = CGPoint(x: 0, y: self.frame.minX)
        }
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: self.frame.height / 4 + self.frame.height/8))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = groundGroup
        ground.zPosition = 1
                  
        groundObject.addChild(ground)
    }
       
    func createSky() {
        sky = SKSpriteNode()
        sky.position = CGPoint(x: 0, y: self.frame.maxX)
        sky.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width + 100, height: self.frame.size.height))
        sky.physicsBody?.isDynamic = false
        sky.zPosition = 1
        skyObject.addChild(sky)
    }
    
    func addHero(heroNode: SKSpriteNode, atPosition position: CGPoint) {
        hero = SKSpriteNode(texture: jumpHeroTex)
        
        // Anim hero
        
        heroflyTexturesArray = [SKTexture(imageNamed: "jump_up.png")]
        let heroFlyAnimation = SKAction.animate(with: heroflyTexturesArray, timePerFrame: 0.1)
        let flyHero = SKAction.repeatForever(heroFlyAnimation)
        hero.run(flyHero)
        
        hero.position = position
        hero.size.height = 120
        hero.size.width = 85
        
        hero.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hero.size.width - 40, height: hero.size.height - 30))
        
        hero.physicsBody?.categoryBitMask = heroGroup
        hero.physicsBody?.contactTestBitMask = groundGroup | coinGroup | bigCoinGroup | objectGroup | shieldGroup 
        hero.physicsBody?.collisionBitMask = groundGroup
        
        hero.physicsBody?.isDynamic = true
        hero.physicsBody?.allowsRotation = false
        hero.zPosition = 1
        
        heroObject.addChild(hero)
    }
    
    func createHero() {
        addHero(heroNode: hero, atPosition: CGPoint(x: self.size.width / 4, y: 0 + jumpHeroTex.size().height))
    }
    
    @objc func addCoin() {
        coin = SKSpriteNode(texture: shieldTexture)
               
       
        let coinAnimation = SKAction.animate(with: coinTexturesArray, timePerFrame: 0.1)
        let coinRepeat = SKAction.repeatForever(coinAnimation)
        coin.run(coinRepeat)
               
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        coin.size.width = 40
        coin.size.height = 40
        coin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: coin.size.width - 20, height: coin.size.height - 20))
        coin.physicsBody?.restitution = 0
        coin.position = CGPoint(x: self.size.width + 50, y: 0 + coinTexture.size().height + 130 + pipeOffset)
               
        let moveCoin = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 5)
        let removeAction = SKAction.removeFromParent()
        let coinMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveCoin, removeAction]))
        coin.run(coinMoveBgForever)
               
        coin.physicsBody?.isDynamic = false
        coin.physicsBody?.categoryBitMask = coinGroup
        coin.zPosition = 1
        coinObject.addChild(coin)
    }
    
    @objc func bigCoinAdd() {
        bigCoin = SKSpriteNode(texture: bigCoinTexture)
           
        let bigCoinAnimation = SKAction.animate(with: coinTexturesArray, timePerFrame: 0.1)
        let bigCoinRepeat = SKAction.repeatForever(bigCoinAnimation)
        bigCoin.run(bigCoinRepeat)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        bigCoin.size.width = 40
        bigCoin.size.height = 40
        bigCoin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bigCoin.size.width - 10, height: bigCoin.size.height - 10))
        bigCoin.physicsBody?.restitution = 0
        bigCoin.position = CGPoint(x: self.size.width + 50, y: 0 + coinTexture.size().height + 90 + pipeOffset)
        
        let moveCoin = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 5)
        let removeAction = SKAction.removeFromParent()
        let coinMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveCoin, removeAction]))
        bigCoin.run(coinMoveBgForever)
        bigCoin.setScale(1.3)
        bigCoin.physicsBody?.isDynamic = false
        bigCoin.physicsBody?.categoryBitMask = bigCoinGroup
        bigCoin.zPosition = 1
        bigCoinObject.addChild(bigCoin)
    }
    
    @objc func addWorm() {
       if sound {
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
                 
        let screenSize = UIScreen.main.bounds
        if screenSize.width > 800 {
            worm.position = CGPoint(x: self.frame.size.width + 150, y: self.frame.size.height / 4 - self.frame.size.height / 24 + 30)
        } else {
            worm.position = CGPoint(x: self.frame.size.width + 150, y: self.frame.size.height / 4 - 30)
        }
                    
        let moveSpiderX = SKAction.moveTo(x: -self.frame.size.width / 4, duration: 4)
        worm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: worm.size.width - 40, height: worm.size.height - 30))
        worm.physicsBody?.categoryBitMask = objectGroup
        worm.physicsBody?.isDynamic = false
                    
        let removeAction = SKAction.removeFromParent()
        let wormMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveSpiderX, removeAction]))
                    
        worm.run(wormMoveBgForever)
        worm.zPosition = 1
        movingObject.addChild(worm)
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
        if sound {
            run(skullPreload)
        }
                         
        skull = SKSpriteNode(texture: skullTexture)
        skull.run(createMoveEnemyY(i: 6))
                
        skull.size.width = 100
        skull.size.height = 70
        skull.speed  = 2.3
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        skull.position = CGPoint(x: self.frame.size.width + 150, y: self.frame.size.height / 4 - self.frame.size.height / 24 + pipeOffset)
                         
        let moveSkullX = SKAction.moveTo(x: -self.frame.size.width / 2, duration: 8)
        skull.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: skull.size.width - 43, height: skull.size.height - 27))
        skull.physicsBody?.categoryBitMask = objectGroup
        skull.physicsBody?.isDynamic = false
                         
        let removeAction = SKAction.removeFromParent()
        let skullMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveSkullX, removeAction]))
                         
        skull.run(skullMoveBgForever)
        skull.zPosition = 1
        movingObject.addChild(skull)
    }
    
    @objc func addSlimeMonster() {
          if sound {
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
                    
           let screenSize = UIScreen.main.bounds
           if screenSize.width > 800 {
               slimeMonster.position = CGPoint(x: self.frame.size.width + 150, y: self.frame.size.height / 4 - self.frame.size.height / 24 + 30)
           } else {
               slimeMonster.position = CGPoint(x: self.frame.size.width + 150, y: self.frame.size.height / 4 )
           }
                       
           let moveSlimeMonsterX = SKAction.moveTo(x: -self.frame.size.width / 3, duration: 3)
           slimeMonster.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: slimeMonster.size.width - 40, height: slimeMonster.size.height - 30))
           slimeMonster.physicsBody?.categoryBitMask = objectGroup
           slimeMonster.physicsBody?.isDynamic = false
                       
           let removeAction = SKAction.removeFromParent()
           let slimeMonsterMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveSlimeMonsterX, removeAction]))
                       
           slimeMonster.run(slimeMonsterMoveBgForever)
           slimeMonster.zPosition = 1
           movingObject.addChild(slimeMonster)
       }
    
    @objc func addGreenMonster() {
        if sound {
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
        let spiderAnimation = SKAction.animate(with: greenMonsterTexturesArray, timePerFrame: 0.03)
        let spiderHero = SKAction.repeatForever(spiderAnimation)
        greenMonster.run(spiderHero)
        
        greenMonster.size.width = 90
        greenMonster.size.height = 62
        greenMonster.speed  = 1.5
        
        var scaleValue: CGFloat = 0.3
               
        let scaleRandom = arc4random() % UInt32(5)
        if scaleRandom == 1 { scaleValue = 0.9 }
        else  if scaleRandom == 2 { scaleValue = 0.6 }
        else if scaleRandom == 3 { scaleValue = 0.8 }
        else if scaleRandom == 4 { scaleValue = 0.7 }
        else if scaleRandom == 0 { scaleValue = 1.0 }
               
        greenMonster.setScale(scaleValue)
            
        let screenSize = UIScreen.main.bounds
        if screenSize.width > 800 {
             greenMonster.position = CGPoint(x: self.frame.size.width + 150, y: self.frame.size.height / 4 - self.frame.size.height / 24 + 40)
        } else {
            greenMonster.position = CGPoint(x: self.frame.size.width + 150, y: self.frame.size.height / 4 - self.frame.size.height / 24)
        }
               
        let moveGreenMonsterX = SKAction.moveTo(x: -self.frame.size.width / 4, duration: 2)
        greenMonster.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: greenMonster.size.width - 40, height: greenMonster.size.height - 30))
        greenMonster.physicsBody?.categoryBitMask = objectGroup
        greenMonster.physicsBody?.isDynamic = false
               
        let removeAction = SKAction.removeFromParent()
        let spiderMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveGreenMonsterX, removeAction]))
               
        greenMonster.run(spiderMoveBgForever)
        greenMonster.zPosition = 1
        movingObject.addChild(greenMonster)
    }
    
    @objc func addUfo() {
        if sound {
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
        ufo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ufo.size.width - 43, height: ufo.size.height - 27))
        ufo.physicsBody?.categoryBitMask = objectGroup
        ufo.physicsBody?.isDynamic = false
                  
        let removeAction = SKAction.removeFromParent()
        let ufoMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveUfoX, removeAction]))
                  
        ufo.run(ufoMoveBgForever)
        ufo.zPosition = 1
        movingObject.addChild(ufo)
    }
    
    func addShield() {
        if sound == true { run(shieldOnPreload) }
        createShieldEmitter()
    }
    
    @objc func addShieldItem() {
        shieldBottle = SKSpriteNode(texture: shieldBottleTexture)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        
        shieldBottle.size.width = 50
        shieldBottle.size.height = 65
        
        shieldBottle.position = CGPoint(x: self.size.width + 50, y: 0 + shieldBottleTexture.size().height - pipeOffset)
        shieldBottle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: shieldBottle.size.width - 20, height: shieldBottle.size.height - 20))
        shieldBottle.physicsBody?.restitution = 0
        
        let moveShield = SKAction.moveBy(x: -self.size.width * 2, y: 0, duration: 5)
        let removeAction = SKAction.removeFromParent()
        let shieldItemMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveShield, removeAction]))
        shieldBottle.run(shieldItemMoveBgForever)
        
        shieldBottle.setScale(0.9)
        
        shieldBottle.physicsBody?.isDynamic = false
        shieldBottle.physicsBody?.categoryBitMask = shieldGroup
        shieldBottle.zPosition = 1
        shieldItemObject.addChild(shieldBottle)
    }
    
    func createShieldEmitter() {
        shieldEmitter = SKEmitterNode(fileNamed: "engine.sks")!
        shieldObject.zPosition = 0
        shieldObject.addChild(shieldEmitter)
       }
    
    func deathAction() {
        mountainBgObject.isPaused = true
        groundBgObject.isPaused = true
        hero.texture = SKTexture(imageNamed: "fail3.png")
        scene?.speed = 0
        hero.speed = 0
        worm.removeAllChildren()
        hero.removeAllChildren()
    }
    
    func reloadGame() {
        death = false
        coinObject.removeAllChildren()
        bigCoinObject.removeAllChildren()
        
        scene?.isPaused = false
           
        movingObject.removeAllChildren()
        heroObject.removeAllChildren()
           
        coinObject.speed = 1
        heroObject.speed = 1
        movingObject.speed = 1
        groundBgObject.isPaused = false
        mountainBgObject.isPaused = false
        self.scene?.speed = 1
           
        createGround()
        createSky()
        createHero()
           
        timerAddCoin.invalidate()
        timerAddBigCoin.invalidate()
        timerAddSkull.invalidate()
        timerAddWorm.invalidate()
        timerAddSlimeMonster.invalidate()
        timerAddGreenMonster.invalidate()
        timerAddShieldItem.invalidate()
       
        addTimer()
    }
    
    func addTimer() {
        timerAddCoin.invalidate()
        timerAddBigCoin.invalidate()
        timerAddWorm.invalidate()
        timerAddSkull.invalidate()
        timerAddSlimeMonster.invalidate()
        timerAddGreenMonster.invalidate()
        timerAddShieldItem.invalidate()
           
        timerAddCoin = Timer.scheduledTimer(timeInterval: 2.83,
                                            target: self,
                                            selector: #selector(GameScene.addCoin),
                                            userInfo: nil,
                                            repeats: true)
        timerAddBigCoin = Timer.scheduledTimer(timeInterval: 9.114,
                                               target: self,
                                               selector: #selector(GameScene.bigCoinAdd),
                                               userInfo: nil,
                                               repeats: true)
        timerAddWorm = Timer.scheduledTimer(timeInterval: 4.56,
                                            target: self,
                                            selector: #selector(GameScene.addWorm),
                                            userInfo: nil,
                                            repeats: true)
        timerAddSkull = Timer.scheduledTimer(timeInterval: 8.54,
                                             target: self,
                                             selector: #selector(GameScene.addSkull),
                                             userInfo: nil, repeats: true)
        timerAddShieldItem = Timer.scheduledTimer(timeInterval: 3.45,
                                                  target: self,
                                                  selector: #selector(GameScene.addShieldItem),
                                                  userInfo: nil,
                                                  repeats: true)
        timerAddShieldItem = Timer.scheduledTimer(timeInterval: 6.825,
                                                  target: self,
                                                  selector: #selector(GameScene.addSlimeMonster),
                                                  userInfo: nil,
                                                  repeats: true)
        timerAddGreenMonster = Timer.scheduledTimer(timeInterval: 11.763,
                                                    target: self,
                                                    selector: #selector(GameScene.addGreenMonster),
                                                    userInfo: nil,
                                                    repeats: true)
        timerAddGreenMonster = Timer.scheduledTimer(timeInterval: 6.363,
                                                    target: self,
                                                    selector: #selector(GameScene.addUfo),
                                                    userInfo: nil,
                                                    repeats: true)
    }
    
    override func didFinishUpdate() {
        shieldEmitter.position = hero.position + CGPoint(x: 0, y: 0)
    }
}
