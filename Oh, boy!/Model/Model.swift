//
//  Model.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 18/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

enum Level: Int {
    case easy, medium, hard
}

enum Background: Int {
    case bg1, bg2
}

class Model {
    
    static let sharedInstance = Model()
    
    // Variables
    var sound = true
    var score = 0
    var highScore = 0
    var totalscore = 0
       
    var level2UnlockValue = 200
}
