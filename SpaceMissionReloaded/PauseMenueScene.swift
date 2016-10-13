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
var selectedTimeInterval = defaults.double(forKey: "AMeterTimeIntervalSaved")
var selectedAMeterVar = defaults.integer(forKey: "AMeterVarSaved")

class PauseMenueScene: SKScene{
    
    //---------------- LabelNodes -> Button
    
    let controlSelection = SKLabelNode(fontNamed: "The Bold Font")          //select Touch (1) or AMeter (0)
    
    let levelSelection = SKLabelNode(fontNamed: "The Bold Font")            //select Easy Medium or Hard
    
    let timeIntervalLabel = SKLabelNode(fontNamed: "The Bold Font")         //select intensity of AMeter-Sensor
    
    let resetHighscore = SKLabelNode(fontNamed: "The Bold Font")            //reset the highscores (all)
    
    //----------------- PlaceHolder
    
    var controlSelectionMode: String = ""
    
    var levelSelectionMode: String = ""
    
    var timeInterval: String = ""
    
    var durationInterval: TimeInterval = 0.3
    
    //------------------ Other
    
    let accuracy = SKLabelNode(fontNamed: "The Bold Font")
    
    let level = SKLabelNode(fontNamed: "The Bold Font")
    
    
    override func didMove(to view: SKView) {
        
        
        //-------------------------------- difficulty Level
        
        if selectedLevelMode == 0{
            levelSelectionMode = "easy"
        }
        if selectedLevelMode == 1{
            levelSelectionMode = "medium"
        }
        if selectedLevelMode == 2{
            levelSelectionMode = "hard"
        }
        
        
        //-------------------------------- Control Mode Selection
        
        if selectedControlMode == 1{
            controlSelectionMode = "touch"
        }
        
        if selectedControlMode == 0{
            controlSelectionMode = "A-Meter"
        }
        
        
        
        
        //-------------------------------- Accuracy for Accelerationmeter
        
       
        print(selectedTimeInterval)
        
        if selectedTimeInterval == 0.3{
            timeInterval = "normal"
            selectedAMeterVar = 900
            
        }
        if selectedTimeInterval == 0.4{
            timeInterval = "slow"
            selectedAMeterVar = 800
            
        }
        if selectedTimeInterval == 0.2{
            timeInterval = "fast"
            selectedAMeterVar = 1050
            
        }
        
        if selectedTimeInterval == 0.0 { //for first use
            timeInterval = "normal"
            durationInterval = 0.3
            defaults.set(durationInterval, forKey: "AMeterTimeIntervalSaved")
            selectedAMeterVar = 900
            defaults.set(selectedAMeterVar, forKey: "AMeterVarSaved")
        }
        
        print(timeInterval)
        print(selectedTimeInterval)
        
        //-------------------------------- fixed Label
        
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
        
        
        
        
            accuracy.text = "Accuracy:"
            accuracy.fontSize  = 90
            accuracy.fontColor = SKColor.white
            accuracy.position = CGPoint(x: self.size.width*0.35, y: self.size.height*0.4)
            accuracy.zPosition = 5
            accuracy.alpha = 0
            self.addChild(accuracy)
        
        
        
        level.text = "Level:"
        level.name = "level"
        level.fontSize  = 90
        level.fontColor = SKColor.white
        if selectedControlMode == 0{
            level.position = CGPoint(x: self.size.width*0.35, y: self.size.height*0.3)
        }
        else{
            level.position = CGPoint(x: self.size.width*0.35, y: self.size.height*0.4)
        }
        level.zPosition = 5
        self.addChild(level)
        
        //-------------------------------- changing Label
        
        controlSelection.text = controlSelectionMode
        controlSelection.name = "controlSelection"
        controlSelection.fontSize  = 70
        controlSelection.fontColor = SKColor.white
        controlSelection.position = CGPoint(x: self.size.width*0.66, y: self.size.height*0.5)
        controlSelection.zPosition = 5
        self.addChild(controlSelection)
        
        
        
            timeIntervalLabel.text = timeInterval
            timeIntervalLabel.name = "timeIntervalSelectionNone"
            timeIntervalLabel.fontSize  = 70
            timeIntervalLabel.fontColor = SKColor.white
            timeIntervalLabel.position = CGPoint(x: self.size.width*0.66, y: self.size.height*0.4)
            timeIntervalLabel.zPosition = 5
            timeIntervalLabel.alpha = 0
            self.addChild(timeIntervalLabel)
        
        if selectedControlMode == 0{
            timeIntervalLabel.name = "timeIntervalSelection"
            timeIntervalLabel.alpha = 1
            accuracy.alpha = 1
            
        }
        
        
        levelSelection.text = levelSelectionMode
        levelSelection.name = "levelSelection"
        levelSelection.fontSize  = 70
        levelSelection.fontColor = SKColor.white
        if selectedControlMode == 0{
            levelSelection.position = CGPoint(x: self.size.width*0.66, y: self.size.height*0.3)
        }
        else{
            levelSelection.position = CGPoint(x: self.size.width*0.66, y: self.size.height*0.4)
        }
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
            
            //add here new "Buttons" (Label touched)
            
            if NodeITapped.name == "back"{
                
                let sceneToMoveTo = MainMenueScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.flipVertical(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            
            if NodeITapped.name == "controlSelection"{
                
                var doubleCheck = 0
                
                if controlSelectionMode == "touch" && doubleCheck == 0{
                    
                    selectedControlMode = 0
                    defaults.set(selectedControlMode, forKey: "controlModeSaved")
                    
                    controlSelectionMode = "A-Meter"
                    doubleCheck = 1
                    
                    let moveToYX = SKAction.moveTo(y: self.size.height*0.3, duration: 0.3)
                    level.run(moveToYX)
                    levelSelection.run(moveToYX)
                    
                    timeIntervalLabel.name = "timeIntervalSelection"
                    
                    let action  = SKAction.fadeAlpha(to: 1, duration: 0.3)
                    timeIntervalLabel.run(action)
                    accuracy.run(action)
                    
                    
                    
                    
                    
                }
                
                if controlSelectionMode == "A-Meter" && doubleCheck == 0{
                    
                    
                    selectedControlMode = 1
                    defaults.set(selectedControlMode, forKey: "controlModeSaved")
                    
                    controlSelectionMode = "touch"
                    doubleCheck = 1
                    
                    let moveToY = SKAction.moveTo(y: self.size.height*0.4, duration: 0.3)
                    level.run(moveToY)
                    levelSelection.run(moveToY)
                    
                    
                    timeIntervalLabel.name = "timeIntervalSelectionNone"
                    
                    let action  = SKAction.fadeAlpha(to: 0, duration: 0.6)
                    timeIntervalLabel.run(action)
                    accuracy.run(action)
                    
                    
                    
                    
                    
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
            
            if NodeITapped.name == "timeIntervalSelection"{
                
                var doubleCheck = 0
                
                if timeInterval == "slow" && doubleCheck == 0{
                    
                    selectedTimeInterval = 0.3
                    defaults.set(selectedTimeInterval, forKey: "AMeterTimeIntervalSaved")
                    selectedAMeterVar = 900
                    defaults.set(selectedAMeterVar, forKey: "AMeterVarSaved")
                    
                    timeInterval = "normal"
                    doubleCheck = 1
                    
                    
                }
                
                if timeInterval == "normal" && doubleCheck == 0{
                    
                    
                    selectedTimeInterval = 0.2
                    defaults.set(selectedTimeInterval, forKey: "AMeterTimeIntervalSaved")
                    selectedAMeterVar = 1200
                    defaults.set(selectedAMeterVar, forKey: "AMeterVarSaved")
                    
                    timeInterval = "fast"
                    doubleCheck = 1
                    
                    
                    
                }
                if timeInterval == "fast" && doubleCheck == 0{
                    
                    
                    selectedTimeInterval = 0.4
                    defaults.set(selectedTimeInterval, forKey: "AMeterTimeIntervalSaved")
                    selectedAMeterVar = 600
                    defaults.set(selectedAMeterVar, forKey: "AMeterVarSaved")
                    
                    timeInterval = "slow"
                    doubleCheck = 1
                    
                   
                    
                }
                
                timeIntervalLabel.text = timeInterval
                
            }
            
            
            
            
        }
        
        
        
    }
    
    
}

