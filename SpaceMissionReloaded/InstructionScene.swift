//
//  InstructionScene.swift
//  SpaceMissionReloaded
//
//  Created by Yannick Klose on 04.11.16.
//  Copyright © 2016 Yannick Klose. All rights reserved.
//

import Foundation
import SpriteKit

class InstructionScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        var instructions = ""
        
        if gameModeChoice == 1 {
        instructions = "-- Classic Mode --  \n\n\ninstruction text\nis missing\n\n\n\n"
        }
        if gameModeChoice == 2 {
            instructions = "-- Time Mode -- \n\n\ninstruction text\nis missing\n\n\n\n"
        }
        
        let instructionMessage = SKLabelNode(fontNamed: "The Bold Font")
        instructionMessage.fontSize = 70
        //instructionMessage.horizontalAlignmentMode = .left
        instructionMessage.verticalAlignmentMode = .top
        instructionMessage.fontColor = UIColor.white
        instructionMessage.text = instructions
        let message = instructionMessage.multilined()
        message.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.65)
        message.zPosition = 1001
        self.addChild(message)
        
        
        let betaWarning1 = SKLabelNode(fontNamed: "The Bold Font")
        betaWarning1.text = "Let's Go!"
        betaWarning1.name = "continueButton"
        betaWarning1.fontSize = 140
        if gameModeChoice == 1{
            betaWarning1.fontColor = SKColor.cyan
        }
        if gameModeChoice == 2{
            betaWarning1.fontColor = SKColor.yellow
        }
        if gameModeChoice == 3{
            betaWarning1.fontColor = SKColor.red
        }
        betaWarning1.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.26)
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
                let myTransition = SKTransition.push(with: .right, duration: 0.38)
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
