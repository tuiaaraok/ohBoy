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
    var death = false
    var moveEnemyY = SKAction()
    var gameViewController: GameViewController!
    var animation = Animation()
    var shieldBool = false
    var gameOver = 0
    var level: Level!
    var background: Background!
    
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
    var leftShoeEmitter = SKEmitterNode()
    var rightShoeEmitter = SKEmitterNode()
    
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
    var shoeEmitterObject = SKNode()
    var coinObject = SKNode()
    var bigCoinObject = SKNode()
    var enemyObject = SKNode()
    var shieldObject = SKNode()
    var shieldBottleObject = SKNode()
    var labelObject = SKNode()
    
    // Bit masks
    var heroGroup: UInt32 = 0x1 << 1
    var groundGroup: UInt32 = 0x1 << 2
    var coinGroup: UInt32 = 0x1 << 3
    var bigCoinGroup: UInt32 = 0x1 << 4
    var objectGroup: UInt32 = 0x1 << 5
    var shieldGroup: UInt32 = 0x1 << 6
    
    // Textures array for animateWithTexture
    var heroFlyTexturesArray = [SKTexture]()
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
    var heroFlyPreload = SKAction()
    var pickCoinPreload = SKAction()
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
        leftShoeEmitter = SKEmitterNode(fileNamed: "shoeSpark.sks")!
        rightShoeEmitter = SKEmitterNode(fileNamed: "shoeSpark.sks")!
        
        self.physicsWorld.contactDelegate = self
        
        createObjects()
        
        if UserDefaults.standard.object(forKey: "highScore") != nil {
            Model.sharedInstance.highScore = UserDefaults.standard.object(forKey: "highScore") as! Int
            highScoreLabel.text = "\( Model.sharedInstance.highScore)"
        }
        
        if UserDefaults.standard.object(forKey: "totalScore") != nil {
            Model.sharedInstance.totalscore = UserDefaults.standard.object(forKey: "totalScore") as! Int
        }
        
        if gameOver == 0 {
            createGame()
        }
        
        heroFlyPreload = SKAction.playSoundFileNamed("fly.mp3", waitForCompletion: false)
        pickCoinPreload = SKAction.playSoundFileNamed("pickCoin.mp3", waitForCompletion: false)
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
        self.addChild(shoeEmitterObject)
        self.addChild(coinObject)
        self.addChild(bigCoinObject)
        self.addChild(enemyObject)
        self.addChild(shieldObject)
        self.addChild(shieldBottleObject)
        self.addChild(labelObject)
    }
    
    func createGame() {
        createBg()
        createGround()
        createSky()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.createHero()
            self.createShoeEmitter()
            self.addTimer()
        }
        showTapToPlay()
        showScore()
        showStage()
        highScoreTextLabel.isHidden = true
        
        gameViewController.reloadButton.isHidden = true
        gameViewController.toMainMenuButton.isHidden = true
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
    
    func createShoeEmitter() {
        leftShoeEmitter = SKEmitterNode(fileNamed: "shoeSpark.sks")!
        rightShoeEmitter = SKEmitterNode(fileNamed: "shoeSpark.sks")!
        shoeEmitterObject.zPosition = 1
        shoeEmitterObject.addChild(leftShoeEmitter)
        shoeEmitterObject.addChild(rightShoeEmitter)
        
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
    
    func addShield() {
        if Model.sharedInstance.sound { run(shieldOnPreload) }
        createShieldEmitter()
    }
    
    @objc func addShieldBottle() {
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
        let shieldBottleMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveShield, removeAction]))
        shieldBottle.run(shieldBottleMoveBgForever)
        
        shieldBottle.setScale(0.9)
        
        shieldBottle.physicsBody?.isDynamic = false
        shieldBottle.physicsBody?.categoryBitMask = shieldGroup
        shieldBottle.zPosition = 1
        shieldBottleObject.addChild(shieldBottle)
    }
    
    func createShieldEmitter() {
        shieldEmitter = SKEmitterNode(fileNamed: "engine.sks")!
        shieldObject.zPosition = 0
        shieldObject.addChild(shieldEmitter)
       }
    
    func deathAction() {
        mountainBgObject.isPaused = true
        groundBgObject.isPaused = true
        hero.texture = SKTexture(imageNamed: "fail.png")
        scene?.speed = 0
        hero.speed = 0
        worm.removeAllChildren()
        hero.removeAllChildren()
    }
    
    func showTapToPlay() {
        tapToPlayLabel.text = "Tap to fly!"
        tapToPlayLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        tapToPlayLabel.fontSize = 75
        tapToPlayLabel.fontColor = .black
        tapToPlayLabel.fontName = "Astounder Squared BB"
        tapToPlayLabel.zPosition = 1
        self.addChild(tapToPlayLabel)
    }
    
    func showScore() {
        scoreLabel.fontName = "Astounder Squared BB"
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 200)
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = .black
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
    }
    
    func showHighScore() {
        highScoreLabel = SKLabelNode()
        let screenSize = UIScreen.main.bounds
        if screenSize.width > 800 {
            highScoreLabel.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.maxY - 245)
        } else {
            highScoreLabel.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.maxY - 210)
        }
        
        highScoreLabel.fontSize = 40
        highScoreLabel.fontName = "Astounder Squared BB"
        highScoreLabel.fontColor = .black
        highScoreLabel.isHidden = true
        highScoreLabel.zPosition = 1
        labelObject.addChild(highScoreLabel)
    }
    
    func showHighScoreText() {
        highScoreTextLabel = SKLabelNode()
        let screenSize = UIScreen.main.bounds
        if screenSize.width > 800 {
            highScoreTextLabel.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.maxY - 200)
        } else {
            highScoreTextLabel.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.maxY - 150)
        }
       
        highScoreTextLabel.fontSize = 40
        highScoreTextLabel.fontName = "Astounder Squared BB"
        highScoreTextLabel.fontColor = .black
        highScoreTextLabel.text = "HighScore"
        highScoreTextLabel.zPosition = 1
        labelObject.addChild(highScoreTextLabel)
    }
    
    func showStage() {
        let screenSize = UIScreen.main.bounds
        if screenSize.width > 800 {
            stageLabel.position = CGPoint(x: self.frame.maxX - 60, y: self.frame.maxY - 200)
        } else {
            stageLabel.position = CGPoint(x: self.frame.maxX - 75, y: self.frame.maxY - 150)
        }
        stageLabel.fontSize = 40
        stageLabel.fontName = "Astounder Squared BB"
        stageLabel.fontColor = .black
        stageLabel.text = "Stage 1"
        stageLabel.zPosition = 1
        self.addChild(stageLabel)
    }
    
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
            enemyObject.speed = -1.22
            self.speed = 1.22
        } else if 40 <= Model.sharedInstance.score && Model.sharedInstance.score < 59 {
            stageLabel.text = "Stage 3"
            coinObject.speed = 1.3
            bigCoinObject.speed = 1.42
            enemyObject.speed = 1.3
            self.speed = 1.22
        } else if 60 <= Model.sharedInstance.score && Model.sharedInstance.score < 100 {
            stageLabel.text = "Stage 4"
            coinObject.speed = 1.4
            bigCoinObject.speed = 1.5
            enemyObject.speed = 1.5
            self.speed = 1.22
        }
    }
    
    override func didFinishUpdate() {
        leftShoeEmitter.position = hero.position - CGPoint(x: 23, y: 60)
        rightShoeEmitter.position = hero.position - CGPoint(x: -8, y: 53)
        shieldEmitter.position = hero.position + CGPoint(x: 0, y: 0)
    }
}
