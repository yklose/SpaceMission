//
//  GameOverScene.swift
//  SpaceMission
//
//  Created by Yannick Klose on 24.08.16.
//  Copyright © 2016 Yannick Klose. All rights reserved.
//

import Foundation
import SpriteKit


var highScoreNumberClassic = defaults.integer(forKey: "highScoreSavedClassic")
var highScoreNumberTimeMode = defaults.integer(forKey: "highScoreSavedTimeMode")
var highScoreNumberSingelShot = defaults.integer(forKey: "highScoreSavedSingelShot")

class GameOverScene: SKScene{
    
    
    
    let restartLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    let backToMenue = SKLabelNode(fontNamed: "The Bold Font")
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameOverLabel = SKLabelNode(fontNamed: "The Bold Font")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 200
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 125
        scoreLabel.fontColor = SKColor.white
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        self.addChild(scoreLabel)
        
        
        if gameModeChoice == 1{
            if gameScore > highScoreNumberClassic{
                highScoreNumberClassic = gameScore
                defaults.set(highScoreNumberClassic, forKey: "highScoreSavedClassic") //saves the Score
            }
        
            let highScoreLabel = SKLabelNode(fontNamed: "The Bold Font")
            highScoreLabel.text = "High Score: \(highScoreNumberClassic)"
            highScoreLabel.fontSize = 125
            highScoreLabel.fontColor = SKColor.white
            highScoreLabel.zPosition = 1
            highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.45)
            self.addChild(highScoreLabel)
        
        }
        
        if gameModeChoice == 2{
            if gameScore > highScoreNumberTimeMode{
                highScoreNumberTimeMode = gameScore
                defaults.set(highScoreNumberTimeMode, forKey: "highScoreSavedTimeMode") //saves the Score
            }
            
            let highScoreLabel = SKLabelNode(fontNamed: "The Bold Font")
            highScoreLabel.text = "High Score: \(highScoreNumberTimeMode)"
            highScoreLabel.fontSize = 125
            highScoreLabel.fontColor = SKColor.white
            highScoreLabel.zPosition = 1
            highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.45)
            self.addChild(highScoreLabel)
            
        }
        
        if gameModeChoice == 3{
            if gameScore > highScoreNumberSingelShot{
                highScoreNumberSingelShot = gameScore
                defaults.set(highScoreNumberSingelShot, forKey: "highScoreSavedSingelShot") //saves the Score
            }
            
            let highScoreLabel = SKLabelNode(fontNamed: "The Bold Font")
            highScoreLabel.text = "High Score: \(highScoreNumberSingelShot)"
            highScoreLabel.fontSize = 125
            highScoreLabel.fontColor = SKColor.white
            highScoreLabel.zPosition = 1
            highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.45)
            self.addChild(highScoreLabel)
            
        }
        
        
        

        restartLabel.text = "Restart"
        restartLabel.fontSize = 90
        restartLabel.fontColor = SKColor.white
        restartLabel.zPosition = 1
        restartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.3)
        self.addChild(restartLabel)
        
        
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
            
            if restartLabel.contains(pointOfTouch){
            
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: myTransition)
                
                
            }
            
            if backToMenue.contains(pointOfTouch){
                
                let sceneToMoveTo = MainMenueScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: myTransition)
                
                
            }
            
            
        }
    }
    
    
    
    
    
    
    
}
