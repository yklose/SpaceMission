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
        
        let instructions = "-- SPECIAL THANKS --\n\n I really want to thank \nsome people, who made \nthis game possible! \n\nFirst of there is my \nbrother LOUIS KLOSE, who \nmade this insane grafic! \n\nBut then there is also my \nuncle RALF TAPPMEYER, who \nhelped me whenever I \nneeded him.\n\n Thank you! \n"
        let instructionMessage = SKLabelNode(fontNamed: "The Bold Font")
        instructionMessage.fontSize = 70
        //instructionMessage.horizontalAlignmentMode = .left
        //instructionMessage.verticalAlignmentMode = .top
        instructionMessage.fontColor = UIColor.white
        instructionMessage.text = instructions
        let message = instructionMessage.multilined()
        message.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        message.zPosition = 1001
        self.addChild(message)
        
        //test test 
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self)
            let NodeITapped = atPoint(pointOfTouch)
            
            if NodeITapped.name == "back"{
                
                let sceneToMoveTo = MainMenueScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
                
            }
        }}
    
    
}
