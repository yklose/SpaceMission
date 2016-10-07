//
//  MainMenueScene.swift
//  SpaceMission
//
//  Created by Yannick Klose on 30.08.16.
//  Copyright © 2016 Yannick Klose. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenueScene: SKScene{                          //StartScreen
    
    
    
    
    let highScorePic = SKSpriteNode(imageNamed: "highscore")
    
    override func didMove(to view: SKView) {
        
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameBy = SKLabelNode(fontNamed: "The Bold Font")
        gameBy.text = "Yannick Klose's"
        gameBy.fontSize = 50
        gameBy.fontColor = SKColor.white
        gameBy.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.78)
        gameBy.zPosition = 1
        self.addChild(gameBy)
        
        let gameName1 = SKLabelNode(fontNamed: "The Bold Font")
        gameName1.text = "Space"
        gameName1.fontSize  = 200
        gameName1.fontColor = SKColor.white
        gameName1.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        gameName1.zPosition = 1
        self.addChild(gameName1)
        
        let gameName2 = SKLabelNode(fontNamed: "The Bold Font")
        gameName2.text = "Mission"
        gameName2.fontSize  = 200
        gameName2.fontColor = SKColor.white
        gameName2.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.625)
        gameName2.zPosition = 1
        self.addChild(gameName2)
        
        let beta = SKLabelNode(fontNamed: "The Bold Font")
        beta.text = "BETA"
        beta.fontSize  = 70
        beta.fontColor = SKColor.red
        beta.position = CGPoint(x: self.size.width*0.29, y: self.size.height*0.74)
        beta.zPosition = 1
        beta.zRotation = 45
        self.addChild(beta)
        
        let startGame = SKLabelNode(fontNamed: "The Bold Font")
        startGame.text = "Start Game"
        startGame.name = "startButton"
        startGame.fontSize  = 150
        startGame.fontColor = SKColor.white
        startGame.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.4)
        startGame.zPosition = 1
        self.addChild(startGame)
        
        let optionLabel = SKLabelNode(fontNamed: "The Bold Font")
        optionLabel.text = "Options"
        optionLabel.name = "optionButton"
        optionLabel.fontSize  = 90
        optionLabel.fontColor = SKColor.white
        optionLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.1)
        optionLabel.zPosition = 1
        self.addChild(optionLabel)
        
        
        
        
        highScorePic.name = "ProtectionPlayer"
        highScorePic.setScale(0.2)
        highScorePic.position = CGPoint(x: self.size.width*0.75, y: self.size.height*0.12)
        highScorePic.zPosition = 2
    
        self.addChild(highScorePic)
        
        
        
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch: AnyObject in touches{
        
            let pointOfTouch = touch.location(in: self)
            let NodeITapped = atPoint(pointOfTouch)
            
            
            if NodeITapped.name == "startButton"{
            
                let sceneToMoveTo = GameModeScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
            
            
            if NodeITapped.name == "optionButton"{
                
                let sceneToMoveTo = PauseMenueScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        
        }
            
            
            if highScorePic.contains(pointOfTouch){
                
                let sceneToMoveTo = HighScoreScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: myTransition)
                
                
            }
            
    }

    }




}
