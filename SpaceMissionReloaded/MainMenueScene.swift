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
    let gameBy = SKLabelNode(fontNamed: "The Bold Font")
    let gameName1 = SKLabelNode(fontNamed: "The Bold Font")
    let gameName2 = SKLabelNode(fontNamed: "The Bold Font")
    let beta = SKLabelNode(fontNamed: "The Bold Font")
    let optionLabel = SKLabelNode(fontNamed: "The Bold Font")
    let startGame = SKLabelNode(fontNamed: "The Bold Font")
    
    //---------------------for scrolling background
    
    var lastUpdateTime: TimeInterval = 0
    var deltaFrameTime: TimeInterval = 0
    var amountToMovePerSecound: CGFloat = 40.0          //very slow
    
    
    
    
    
    override func didMove(to view: SKView) {
        
        
        //----------- scrolling Background --START
        
        let backgroundBlack = SKSpriteNode(imageNamed: "black")
        backgroundBlack.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        backgroundBlack.zPosition = -1
        backgroundBlack.size = self.size
        self.addChild(backgroundBlack)

 
        for i in 0...1{                                     //Scrolling Background
            
            let background = SKSpriteNode(imageNamed: "background")
            background.size = self.size
            background.name = "Background"
            background.anchorPoint = CGPoint(x: 0.5, y: 0)
            background.position = CGPoint(x: self.size.width/2,
                                          y: self.size.height*CGFloat(i))
            background.zPosition = 0
            background.alpha = 0
            self.addChild(background)
            let fadeInBackground = SKAction.fadeAlpha(to: 1, duration: 0.2) 
            background.run(fadeInBackground)
            
            
            
        }
        
        let wait = SKAction.wait(forDuration: 0.4)
        let delete = SKAction.removeFromParent()
        let sequence = SKAction.sequence([wait,delete])
        backgroundBlack.run(sequence)
        
        //------------ scrolling Background --END
        
        gameBy.text = "Yannick Klose's"
        gameBy.fontSize = 50
        gameBy.fontColor = SKColor.white
        gameBy.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.78)
        gameBy.zPosition = 1
        self.addChild(gameBy)
        
        
        gameName1.text = "Space"
        gameName1.fontSize  = 200
        gameName1.fontColor = SKColor.white
        gameName1.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        gameName1.zPosition = 1
        self.addChild(gameName1)
        
        
        gameName2.text = "Mission"
        gameName2.fontSize  = 200
        gameName2.fontColor = SKColor.white
        gameName2.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.625)
        gameName2.zPosition = 1
        self.addChild(gameName2)
        
        
        beta.text = "BETA"
        beta.fontSize  = 70
        beta.fontColor = SKColor.red
        beta.position = CGPoint(x: self.size.width*0.29, y: self.size.height*0.74)
        beta.zPosition = 1
        beta.zRotation = 45
        self.addChild(beta)
        
        
        startGame.text = "Start Game"
        startGame.name = "startButton"
        startGame.fontSize  = 150
        startGame.fontColor = SKColor.white
        startGame.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.4)
        startGame.zPosition = 1
        self.addChild(startGame)
        
        
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
    
    func moveToGameScene(){
    
        let sceneToMoveTo = GameModeScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch: AnyObject in touches{
        
            let pointOfTouch = touch.location(in: self)
            let NodeITapped = atPoint(pointOfTouch)
            
            
            if NodeITapped.name == "startButton"{
                
                
                
                let prepareGameScene = SKAction.moveBy(x: 0, y: 1000, duration: 0.5)
                gameBy.run(prepareGameScene)
                gameName1.run(prepareGameScene)
                gameName2.run(prepareGameScene)
                beta.run(prepareGameScene)
                let prepareGameSceneTwo = SKAction.moveBy(x: 0, y: -1000, duration: 0.5)
                optionLabel.run(prepareGameSceneTwo)
                highScorePic.run(prepareGameSceneTwo)
                let fadeOutStartButton = SKAction.fadeOut(withDuration: 0.5)
                startGame.run(fadeOutStartButton)
                
                
                
                
                
                let wait = SKAction.wait(forDuration: 0.5)
                let moveToScene = SKAction.run {
                    self.moveToGameScene()
                }
                let sequence = SKAction.sequence([wait,moveToScene])
                self.run(sequence)
                
            }
            
            
            if NodeITapped.name == "optionButton"{
                
                let sceneToMoveTo = PauseMenueScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.flipVertical(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        
        }
            
            
            if highScorePic.contains(pointOfTouch){
                
                let sceneToMoveTo = HighScoreScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: myTransition)
                
                
            }
            
            if gameName1.contains(pointOfTouch){
                
                let sceneToMoveTo = SpecialThanksCreditsScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: myTransition)
            }
            if gameName2.contains(pointOfTouch){
                
                let sceneToMoveTo = SpecialThanksCreditsScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
    }

    }

    override func update(_ currentTime: TimeInterval) {
        
        if lastUpdateTime == 0{
            lastUpdateTime = currentTime
        }
        else{
            deltaFrameTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
        }
        
        let amountToMoveBackground = (amountToMovePerSecound)*CGFloat(deltaFrameTime) //adjust the speed of the scolling background [+ (vmaxEnemy*5 - 2.6*5)]
        
        
        
        self.enumerateChildNodes(withName: "Background"){
            background, stop in
            
            
            background.position.y -= amountToMoveBackground
            
            if background.position.y < -self.size.height{
                background.position.y += self.size.height*2
            }
            
        }
        
        
    }
    



}
