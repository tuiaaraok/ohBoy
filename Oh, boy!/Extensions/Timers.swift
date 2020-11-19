//
//  Timers.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 19/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func addTimer() {
        
        timerInvalidate()
              
        timerAddCoin = Timer.scheduledTimer(timeInterval: 1.83, target: self, selector: #selector(GameScene.addCoin), userInfo: nil,repeats: true)
        timerAddBigCoin = Timer.scheduledTimer(timeInterval: 9.114, target: self, selector: #selector(GameScene.bigCoinAdd), userInfo: nil,repeats: true)
           
        switch level.rawValue {
        case 0: // easy
            timerAddWorm = Timer.scheduledTimer(timeInterval: 4.56, target: self, selector: #selector(GameScene.addWorm), userInfo: nil, repeats: true)
            timerAddSkull = Timer.scheduledTimer(timeInterval: 3.54, target: self, selector: #selector(GameScene.addSkull), userInfo: nil, repeats: true)
            timerAddShieldItem = Timer.scheduledTimer(timeInterval: 8.45, target: self, selector: #selector(GameScene.addShieldBottle), userInfo: nil, repeats: true)
            timerAddSlimeMonster = Timer.scheduledTimer(timeInterval: 6.825, target: self, selector: #selector(GameScene.addSlimeMonster), userInfo: nil, repeats: true)
            timerAddGreenMonster = Timer.scheduledTimer(timeInterval: 11.763, target: self, selector: #selector(GameScene.addGreenMonster), userInfo: nil, repeats: true)
            timerAddUfo = Timer.scheduledTimer(timeInterval: 6.363, target: self, selector: #selector(GameScene.addUfo), userInfo: nil, repeats: true)
        case 1: // medium
            timerAddWorm = Timer.scheduledTimer(timeInterval: 3.56, target: self, selector: #selector(GameScene.addWorm), userInfo: nil, repeats: true)
            timerAddSkull = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(GameScene.addSkull), userInfo: nil, repeats: true)
            timerAddShieldItem = Timer.scheduledTimer(timeInterval: 15.45, target: self, selector: #selector(GameScene.addShieldBottle), userInfo: nil, repeats: true)
            timerAddSlimeMonster = Timer.scheduledTimer(timeInterval: 4.825, target: self, selector: #selector(GameScene.addSlimeMonster), userInfo: nil, repeats: true)
            timerAddGreenMonster = Timer.scheduledTimer(timeInterval: 8.763, target: self, selector: #selector(GameScene.addGreenMonster), userInfo: nil, repeats: true)
            timerAddUfo = Timer.scheduledTimer(timeInterval: 4.363, target: self, selector: #selector(GameScene.addUfo), userInfo: nil, repeats: true)
        case 2: // hard
            timerAddWorm = Timer.scheduledTimer(timeInterval: 3.034, target: self, selector: #selector(GameScene.addWorm), userInfo: nil, repeats: true)
            timerAddSkull = Timer.scheduledTimer(timeInterval: 2.987, target: self, selector: #selector(GameScene.addSkull), userInfo: nil, repeats: true)
            timerAddShieldItem = Timer.scheduledTimer(timeInterval: 30.45, target: self, selector: #selector(GameScene.addShieldBottle), userInfo: nil, repeats: true)
            timerAddSlimeMonster = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(GameScene.addSlimeMonster), userInfo: nil, repeats: true)
            timerAddGreenMonster = Timer.scheduledTimer(timeInterval: 6.763, target: self, selector: #selector(GameScene.addGreenMonster), userInfo: nil, repeats: true)
            timerAddUfo = Timer.scheduledTimer(timeInterval: 3.789, target: self, selector: #selector(GameScene.addUfo), userInfo: nil, repeats: true)
        default:
            break
        }
    }
       
    func timerInvalidate() {
        
        timerAddCoin.invalidate()
        timerAddBigCoin.invalidate()
        timerAddWorm.invalidate()
        timerAddSkull.invalidate()
        timerAddSlimeMonster.invalidate()
        timerAddGreenMonster.invalidate()
        timerAddShieldItem.invalidate()
        timerAddUfo.invalidate()
    }
}
