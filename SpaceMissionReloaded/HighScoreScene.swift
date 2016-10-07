//
//  HighScoreScene.swift
//  SpaceMission
//
//  Created by Yannick Klose on 02.10.16.
//  Copyright © 2016 Yannick Klose. All rights reserved.
//

import Foundation
import SpriteKit


class HighScoreScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 4
        self.addChild(background)
        
        let highScoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        highScoreLabel.text = "Highscores"
        highScoreLabel.fontSize  = 170
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.78)
        highScoreLabel.zPosition = 5
        self.addChild(highScoreLabel)
        
        let highScoreAmeterClassic = SKLabelNode(fontNamed: "The Bold Font")
        highScoreAmeterClassic.text =       "Classic:        \(highScoreNumberClassic)"
        highScoreAmeterClassic.fontSize  = 100
        highScoreAmeterClassic.fontColor = SKColor.cyan
        highScoreAmeterClassic.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.6)
        highScoreAmeterClassic.zPosition = 5
        self.addChild(highScoreAmeterClassic)
        
        let highScoreAmeterTimeMode = SKLabelNode(fontNamed: "The Bold Font")
        highScoreAmeterTimeMode.text =      "Time Mode:      \(highScoreNumberTimeMode)"
        highScoreAmeterTimeMode.fontSize  = 100
        highScoreAmeterTimeMode.fontColor = SKColor.yellow
        highScoreAmeterTimeMode.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.4)
        highScoreAmeterTimeMode.zPosition = 5
        self.addChild(highScoreAmeterTimeMode)
        
        let highScoreAmeterSingleShot = SKLabelNode(fontNamed: "The Bold Font")
        highScoreAmeterSingleShot.text =    "Singel Shot:    \(highScoreNumberSingelShot)"
        highScoreAmeterSingleShot.fontSize  = 100
        highScoreAmeterSingleShot.fontColor = SKColor.red
        highScoreAmeterSingleShot.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.2)
        highScoreAmeterSingleShot.zPosition = 5
        self.addChild(highScoreAmeterSingleShot)
        
        let backToMenue = SKLabelNode(fontNamed: "The Bold Font")
        backToMenue.text = "back to menue"
        backToMenue.name = "back"
        backToMenue.fontSize  = 60
        backToMenue.fontColor = SKColor.white
        backToMenue.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.1)
        backToMenue.zPosition = 5
        self.addChild(backToMenue)
        
        
        
    
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
