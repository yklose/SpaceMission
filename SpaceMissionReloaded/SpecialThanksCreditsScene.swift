//
//  SpecialThanksCreditsScene.swift
//  SpaceMission
//
//  Created by Yannick Klose on 02.10.16.
//  Copyright © 2016 Yannick Klose. All rights reserved.
//

import Foundation
import SpriteKit

class SpecialThanksCreditsScene: SKScene {              //Not finished yet
    
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let backToMenue = SKLabelNode(fontNamed: "The Bold Font")
        backToMenue.text = "back to menue"
        backToMenue.name = "back"
        backToMenue.fontSize  = 60
        backToMenue.fontColor = SKColor.white
        backToMenue.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.1)
        backToMenue.zPosition = 5
        self.addChild(backToMenue)
        
        //add here some Special Thanks
        
        //test test 
        
        
    }
    
    
}
