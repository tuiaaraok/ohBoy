//
//  Animation.swift
//  Oh, boy!
//
//  Created by Айсен Шишигин on 18/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation
import SpriteKit

class Animation {
    
    func shakeAndFlashAnimation(view: SKView) {
        // white flash
        let aView = UIView(frame: view.frame)
        aView.backgroundColor = .white
        view.addSubview(aView)
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            aView.alpha = 0.0
        }) { (done) in
            aView.removeFromSuperview()
        }
        
        // Shake animation
        let shake = CAKeyframeAnimation(keyPath: "transform")
        shake.values = [
        NSValue(caTransform3D: CATransform3DMakeTranslation(-15, 5, 5)),
         NSValue(caTransform3D: CATransform3DMakeTranslation(15, 5, 5))
        ]
        shake.autoreverses = true
        shake.repeatCount = 2
        shake.duration = 7/100
        
        view.layer.add(shake, forKey: nil)
    }
}
