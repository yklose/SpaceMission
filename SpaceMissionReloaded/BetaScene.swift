//
//  BetaScene.swift
//  SpaceMissionReloaded
//
//  Created by Yannick Klose on 07.10.16.
//  Copyright © 2016 Yannick Klose. All rights reserved.
//

import Foundation
import SpriteKit

class BetaScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        let betaWarning = SKLabelNode(fontNamed: "The Bold Font")
        betaWarning.text = "This Gamemode"
        betaWarning.fontSize = 120
        betaWarning.fontColor = SKColor.red
        betaWarning.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.78)
        betaWarning.zPosition = 1
        self.addChild(betaWarning)
        
        let betaWarning0 = SKLabelNode(fontNamed: "The Bold Font")
        betaWarning0.text = "is in progress!"
        betaWarning0.fontSize = 120
        betaWarning0.fontColor = SKColor.red
        betaWarning0.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        betaWarning0.zPosition = 1
        self.addChild(betaWarning0)
        
        
        let betaWarning1 = SKLabelNode(fontNamed: "The Bold Font")
        betaWarning1.text = "Continue"
        betaWarning1.name = "continueButton"
        betaWarning1.fontSize = 140
        betaWarning1.fontColor = SKColor.white
        betaWarning1.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.4)
        betaWarning1.zPosition = 1
        self.addChild(betaWarning1)
        
        let back = SKLabelNode(fontNamed: "The Bold Font")
        back.text = "back"
        back.name = "menueButton"
        back.fontSize  = 100
        back.fontColor = SKColor.white
        back.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.1)
        back.zPosition = 1
        self.addChild(back)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self)
            let NodeITapped = atPoint(pointOfTouch)
            
            
            if NodeITapped.name == "menueButton"{
                
                let sceneToMoveTo = GameModeScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
                
            }
            
            if NodeITapped.name == "continueButton"{
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
                
            }
            
        }
        
    }
    
    
}

