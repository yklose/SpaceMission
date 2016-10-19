//
//  GameModeScene.swift
//  SpaceMissionReloaded
//
//  Created by Yannick Klose on 07.10.16.
//  Copyright © 2016 Yannick Klose. All rights reserved.
//

import Foundation
import CoreMotion
import SpriteKit


var gameModeChoice = 0                  //default, Classic = 1, TimeMode = 2, Single Shot = 3
var selectedGameModeChoise = defaults.integer(forKey: "gameModeChoiseSaved")

class GameModeScene: SKScene {          //Level Selectionmode
    
    
    let singleShot = SKLabelNode(fontNamed: "The Bold Font")
    let timeMode = SKLabelNode(fontNamed: "The Bold Font")
    let classic = SKLabelNode(fontNamed: "The Bold Font")
    
    let warning = SKLabelNode(fontNamed: "The Bold Font")
    var buttonPressed = 0
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let selection = SKLabelNode(fontNamed: "The Bold Font")
        selection.text = "Select a game mode"
        selection.fontSize = 100
        selection.fontColor = SKColor.white
        selection.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.78)
        selection.zPosition = 1
        self.addChild(selection)
        
        
        classic.text = "Classic"
        classic.name = "classicButton"
        classic.fontSize  = 130
        classic.fontColor = SKColor.cyan
        classic.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.6)
        classic.zPosition = 1
        self.addChild(classic)
        
        
        timeMode.text = "Time Mode"
        timeMode.name = "timeButton"
        timeMode.fontSize  = 130
        timeMode.fontColor = SKColor.yellow
        timeMode.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.4)
        timeMode.zPosition = 1
        self.addChild(timeMode)
        
        
        singleShot.text = "Single Shot"
        singleShot.name = "singleShotButton"
        singleShot.fontSize  = 130
        singleShot.fontColor = SKColor.red
        singleShot.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.2)
        singleShot.zPosition = 1
        self.addChild(singleShot)
        
        
        let back = SKLabelNode(fontNamed: "The Bold Font")
        back.text = "back to menue"
        back.name = "menueButton"
        back.fontSize  = 50
        back.fontColor = SKColor.white
        back.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.1)
        back.zPosition = 1
        self.addChild(back)
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self)
            let NodeITapped = atPoint(pointOfTouch)
            
            
            if NodeITapped.name == "classicButton"{
                
                gameModeChoice = 1
                defaults.set(gameModeChoice, forKey: "gameModeChoiseSaved")
                
                let scaleDown = SKAction.scale(to: 0.5, duration: 0.1)
                let scaleBack = SKAction.scale(to: 1, duration: 0.1)
                classic.run(scaleDown)
                
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
                classic.run(scaleBack)
                
            }
            
            if NodeITapped.name == "timeButton"{
                
                gameModeChoice = 2
                defaults.set(gameModeChoice, forKey: "gameModeChoiseSaved")
                
                let scaleDown = SKAction.scale(to: 0.5, duration: 0.1)
                let scaleBack = SKAction.scale(to: 1, duration: 0.1)
                timeMode.run(scaleDown)
                
                let sceneToMoveTo = BetaScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
                timeMode.run(scaleBack)
            }
            
            if NodeITapped.name == "singleShotButton"{
                
                if selectedControlMode == 1{
                    
                    if buttonPressed == 0{
                        warning.text = "Only Enabled in with Control 'A-Meter' selected"
                        warning.fontSize  = 40
                        warning.fontColor = SKColor.white
                        warning.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.18)
                        warning.zPosition = 1
                        self.addChild(warning)
                    }
                    
                    let scaleDown = SKAction.scale(to: 0.5, duration: 0.1)
                    let scaleBack = SKAction.scale(to: 1, duration: 0.1)
                    let scaleSequence = SKAction.sequence([scaleDown,scaleBack])
                    singleShot.run(scaleSequence)
                    
                    buttonPressed = 1
                    
                }
                    
                else{
                    
                    gameModeChoice = 3
                    defaults.set(gameModeChoice, forKey: "gameModeChoiseSaved")
                    
                    
                    let sceneToMoveTo = BetaScene(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    let myTransition = SKTransition.fade(withDuration: 0.5)
                    self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                    
                }}
            
            if NodeITapped.name == "menueButton"{
                
                
                
                
                let sceneToMoveTo = MainMenueScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
                warning.removeFromParent()
                
                
            }
            
            
        }
    }
}

