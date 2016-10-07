//
//  PauseMenueScene.swift
//  SpaceMissionReloaded
//
//  Created by Yannick Klose on 07.10.16.
//  Copyright © 2016 Yannick Klose. All rights reserved.
//

import Foundation
import SpriteKit


let defaults = UserDefaults()
var selectedControlMode = defaults.integer(forKey: "controlModeSaved")
var selectedLevelMode = defaults.integer(forKey: "levelModeSaved")

class PauseMenueScene: SKScene{
    
    let controlSelection = SKLabelNode(fontNamed: "The Bold Font")
    
    let levelSelection = SKLabelNode(fontNamed: "The Bold Font")
    
    var controlSelectionMode: String = ""
    
    var levelSelectionMode: String = ""
    
    let resetHighscore = SKLabelNode(fontNamed: "The Bold Font")
    
    
    
    override func didMove(to view: SKView) {
        
        
        if selectedLevelMode == 0{
            levelSelectionMode = "easy"
        }
        if selectedLevelMode == 1{
            levelSelectionMode = "medium"
        }
        if selectedLevelMode == 2{
            levelSelectionMode = "hard"
        }
        
        
        if selectedControlMode == 1{
            controlSelectionMode = "touch"
        }
        
        if selectedControlMode == 0{
            controlSelectionMode = "A-Meter"
        }
        
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 4
        self.addChild(background)
        
        
        
        let optionLabel = SKLabelNode(fontNamed: "The Bold Font")
        optionLabel.text = "Options"
        optionLabel.fontSize  = 200
        optionLabel.fontColor = SKColor.white
        optionLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        optionLabel.zPosition = 5
        self.addChild(optionLabel)
        
        
        
        let backToMenue = SKLabelNode(fontNamed: "The Bold Font")
        backToMenue.text = "back to menue"
        backToMenue.name = "back"
        backToMenue.fontSize  = 60
        backToMenue.fontColor = SKColor.white
        backToMenue.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.1)
        backToMenue.zPosition = 5
        self.addChild(backToMenue)
        
        let control = SKLabelNode(fontNamed: "The Bold Font")
        control.text = "Control:"
        control.name = "control"
        control.fontSize  = 90
        control.fontColor = SKColor.white
        control.position = CGPoint(x: self.size.width*0.35, y: self.size.height*0.5)
        control.zPosition = 5
        self.addChild(control)
        
        
        controlSelection.text = controlSelectionMode
        controlSelection.name = "controlSelection"
        controlSelection.fontSize  = 70
        controlSelection.fontColor = SKColor.white
        controlSelection.position = CGPoint(x: self.size.width*0.66, y: self.size.height*0.5)
        controlSelection.zPosition = 5
        self.addChild(controlSelection)
        
        
        let level = SKLabelNode(fontNamed: "The Bold Font")
        level.text = "Level:"
        level.name = "level"
        level.fontSize  = 90
        level.fontColor = SKColor.white
        level.position = CGPoint(x: self.size.width*0.35, y: self.size.height*0.4)
        level.zPosition = 5
        self.addChild(level)
        
        
        levelSelection.text = levelSelectionMode
        levelSelection.name = "levelSelection"
        levelSelection.fontSize  = 70
        levelSelection.fontColor = SKColor.white
        levelSelection.position = CGPoint(x: self.size.width*0.66, y: self.size.height*0.4)
        levelSelection.zPosition = 5
        self.addChild(levelSelection)
        
        resetHighscore.text = "Reset Highscore"
        resetHighscore.name = "resetHighscore"
        resetHighscore.fontSize  = 60
        resetHighscore.fontColor = SKColor.red
        resetHighscore.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.2)
        resetHighscore.zPosition = 5
        self.addChild(resetHighscore)
        
        
        
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
            
            if NodeITapped.name == "controlSelection"{
                
                var doubleCheck = 0
                
                if controlSelectionMode == "touch" && doubleCheck == 0{
                    
                    selectedControlMode = 0
                    defaults.set(selectedControlMode, forKey: "controlModeSaved")
                    
                    controlSelectionMode = "A-Meter"
                    doubleCheck = 1
                    
                }
                
                if controlSelectionMode == "A-Meter" && doubleCheck == 0{
                    
                    
                    selectedControlMode = 1
                    defaults.set(selectedControlMode, forKey: "controlModeSaved")
                    
                    controlSelectionMode = "touch"
                    doubleCheck = 1
                    
                }
                
                controlSelection.text = controlSelectionMode
            }
            
            if NodeITapped.name == "levelSelection"{
                
                var doubleCheck = 0
                
                if levelSelectionMode == "easy" && doubleCheck == 0{
                    
                    selectedLevelMode = 1
                    defaults.set(selectedLevelMode, forKey: "levelModeSaved")
                    
                    levelSelectionMode = "medium"
                    doubleCheck = 1
                    
                }
                
                if levelSelectionMode == "medium" && doubleCheck == 0{
                    
                    
                    selectedLevelMode = 2
                    defaults.set(selectedLevelMode, forKey: "levelModeSaved")
                    
                    levelSelectionMode = "hard"
                    doubleCheck = 1
                    
                }
                if levelSelectionMode == "hard" && doubleCheck == 0{
                    
                    
                    selectedLevelMode = 0
                    defaults.set(selectedLevelMode, forKey: "levelModeSaved")
                    
                    levelSelectionMode = "easy"
                    doubleCheck = 1
                    
                }
                
                
                levelSelection.text = levelSelectionMode
            }
            
            if NodeITapped.name == "resetHighscore"{
                
                //Does not work... self.presentViewController is no member of PauseMenueScene!
                
                
                /*
                 let alert = UIAlertController(title: "UIAlertController", message: "Do you really want to reset the highscore?", preferredStyle: UIAlertControllerStyle.alert)
                 
                 alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: nil))
                 alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                 
                 
                 
                 self.presentViewController(alert, animated: true, completion: nil)
                 */
                
                
                highScoreNumberClassic = 0
                highScoreNumberTimeMode = 0
                highScoreNumberSingelShot = 0
                
            }
            
            
            
            
        }
        
        
        
    }
    
    
}

