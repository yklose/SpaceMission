//
//  GameScene.swift
//  SpaceMissionReloaded
//
//  Created by Yannick Klose on 07.10.16.
//  Copyright © 2016 Yannick Klose. All rights reserved.
//

import SpriteKit
import CoreMotion


fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}



var gameScore = 0



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    
    
    let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    var levelNumber = 0                             // Four Levels
    
    var livesNumber = 3                             // Amount of Enemys who left the screen
    
    let livesLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    var protection = 0                              // 0 --> OFF , 1 --> ON
    
    let pauseLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    let player = SKSpriteNode(imageNamed: "newShip")
    
    let tapToStartLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    let protectionPlayer = SKSpriteNode(imageNamed: "icon")
    
    var motionManager = CMMotionManager()           // control the player via accelerometer
    
    var destX:CGFloat  = 0.0                        // startpoint for player
    
    var vmaxEnemy: CGFloat = 2.5                    // default velocity of Enemy Ships -> changes in different levels
    
    var highscoreReached = 0                        // 1 --> New Highscore in current Game
    
    var fireLimit = 0                               //default, 1 -> allows only one shot (for SingleShot Gamemode)
    
    let remainingTimeForTimeMode = SKLabelNode(fontNamed: "The Bold Font")               //remaing Time in Seconds -> ONLY FOR TIME MODE
    
    let resumeLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    let menueLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    var gameTimer: Timer!
    
    var remainingTimeInteger = 20
    
    var timerSpawn = 0
    
    var timeBonus = 0                               //Bonus Seconds in Time Mode
    
    
    
    enum gameState{
        
        case preGame                                //before start oft game
        case inGame                                 //during the game
        case pauseGame                              //Game is in pause
        case aftergame                              //after the game
        
    }
    
    var currentGameState = gameState.preGame
    
    
    struct PhysicsCategories{
        static let None : UInt32 = 0
        static let Player : UInt32 = 0b1            //1
        static let Bullet : UInt32 = 0b10           //2
        static let Enemy : UInt32 = 0b100           //4
        static let Protection: UInt32 = 0b101       //5
        static let TimeIcon : UInt32 = 0b111        //6
        static let MinusTimeIcon : UInt32 = 0b1000  //7
        
    }
    
    
    //----------------- generates Random numbers
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat , max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    
    
    //----------------- Set Game Area
    var gameArea: CGRect
    
    override init(size: CGSize) {
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        
        
        
        gameScore = 0
        
        self.physicsWorld.contactDelegate = self
        
        
        
        for i in 0...1{                                     //Scrolling Background
            
            let background = SKSpriteNode(imageNamed: "background")
            background.size = self.size
            background.name = "Background"
            background.anchorPoint = CGPoint(x: 0.5, y: 0)
            background.position = CGPoint(x: self.size.width/2,
                                          y: self.size.height*CGFloat(i))
            background.zPosition = 0
            self.addChild(background)
            
        }
        
        
        player.setScale(0.16)
        player.position = CGPoint(x: self.size.width/2, y: 0 - player.size.height)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        player.constraints = [SKConstraint.positionX(SKRange(lowerLimit: gameArea.minX + player.size.width/2, upperLimit: gameArea.maxX - player.size.width/2))]
        self.addChild(player)
        
        
        protectionPlayer.name = "ProtectionPlayer"          //ProtectionBubble
        protectionPlayer.setScale(0.55)
        protectionPlayer.position = player.position
        protectionPlayer.zPosition = 2
        protectionPlayer.alpha = 0                          //is always active -> can't see it
        protectionPlayer.constraints = [SKConstraint.positionX(SKRange(lowerLimit: gameArea.minX + player.size.width/2, upperLimit: gameArea.maxX - player.size.width/2))]
        self.addChild(protectionPlayer)
        
        
        
        pauseLabel.text = "Pause"
        pauseLabel.name = "PauseLabel"
        pauseLabel.fontSize = 70
        pauseLabel.fontColor = SKColor.white
        pauseLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        pauseLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height + pauseLabel.frame.size.height)
        pauseLabel.zPosition = 100
        self.addChild(pauseLabel)
        
        
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 70
        scoreLabel.fontColor = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width*0.15, y: self.size.height + scoreLabel.frame.size.height)
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        
        if gameModeChoice != 2{                     //livesLabel not in TIME MODE!
            
            livesLabel.text = "Lives: 3"
            livesLabel.fontSize = 70
            livesLabel.fontColor = SKColor.white
            livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            livesLabel.position = CGPoint(x: self.size.width*0.85, y: self.size.height + livesLabel.frame.size.height)
            livesLabel.zPosition = 100
            self.addChild(livesLabel)
        }
        
        if gameModeChoice == 2 {                    //only for TIME MODE
            
            remainingTimeForTimeMode.text = "20"
            remainingTimeForTimeMode.fontSize = 90
            remainingTimeForTimeMode.fontColor = SKColor.white
            remainingTimeForTimeMode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            remainingTimeForTimeMode.position = CGPoint(x: self.size.width*0.85, y: self.size.height + livesLabel.frame.size.height)
            remainingTimeForTimeMode.zPosition = 100
            self.addChild(remainingTimeForTimeMode)
            
            
        }
        
        
        let moveToScreenAction = SKAction.moveTo(y: self.size.height*0.9, duration: 0.3)
        scoreLabel.run(moveToScreenAction)
        livesLabel.run(moveToScreenAction)
        
        remainingTimeForTimeMode.run(moveToScreenAction)
        
        
        tapToStartLabel.text = "Tap To Begin"
        tapToStartLabel.fontSize = 100
        tapToStartLabel.fontColor = SKColor.white
        tapToStartLabel.zPosition = 1
        tapToStartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        tapToStartLabel.alpha = 0
        self.addChild(tapToStartLabel)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 0.3)
        tapToStartLabel.run(fadeInAction)
        
        
        
        
        
        
        
        
        
        
        
        //------------- CoreMotion
        
        
        if selectedControlMode == 0{
            
            motionManager.startAccelerometerUpdates()
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: OperationQueue.main ) {
                (data, error) in
                
                guard let data = self.motionManager.accelerometerData else { return }
                
                
                
                let action = SKAction.moveTo(x: (self.player.position.x + (CGFloat(data.acceleration.x)*CGFloat(selectedAMeterVar))), duration: selectedTimeInterval)
                
                if self.currentGameState == gameState.inGame{
                    
                    self.player.run(action)
                    if self.protection == 1{
                        self.protectionPlayer.alpha = 1
                        self.protectionPlayer.position = self.player.position  //eventually problems with data management
                        self.protectionPlayer.run(action)
                    }
                }
                
            }
            
            
        }
        
        
        
        
    }
    
    var lastUpdateTime: TimeInterval = 0
    var deltaFrameTime: TimeInterval = 0
    var amountToMovePerSecound: CGFloat = 500.0
    
    
    override func update(_ currentTime: TimeInterval) {
        
        if lastUpdateTime == 0{
            lastUpdateTime = currentTime
        }
        else{
            deltaFrameTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
        }
        
        let amountToMoveBackground = (amountToMovePerSecound )*CGFloat(deltaFrameTime) //adjust the speed of the scolling background [+ (vmaxEnemy*5 - 2.6*5)]
        
        
        
        self.enumerateChildNodes(withName: "Background"){
            background, stop in
            
            if self.currentGameState == gameState.inGame{
                background.position.y -= amountToMoveBackground
            }
            if background.position.y < -self.size.height{
                background.position.y += self.size.height*2
            }
            
        }
        
        
    }
    
    
    
    
    func startGame(){
        
        currentGameState = gameState.inGame
        
        let moveToScreenAction = SKAction.moveTo(y: self.size.height*0.9, duration: 0.3)
        pauseLabel.run(moveToScreenAction)
        
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let deleteAction = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([fadeOutAction, deleteAction])
        tapToStartLabel.run(deleteSequence)
        
        let moveShipOntoScreenAction = SKAction.moveTo(y: self.size.height*0.2, duration: 0.5)
        let startLevelAction = SKAction.run(startNewLevel)
        let startGameSequence = SKAction.sequence([moveShipOntoScreenAction,startLevelAction])
        player.run(startGameSequence)
        
        if gameModeChoice == 2 {                                    //Timer Funktion
            
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimeCode), userInfo: nil, repeats: true)
            
        }
        
        
    }
    

    func runTimeCode(){
        
        timerSpawn = timerSpawn + 1
        
        if remainingTimeInteger >= 0{
    
            remainingTimeForTimeMode.text = String(remainingTimeInteger)
            remainingTimeInteger = remainingTimeInteger - 1
            
            if timerSpawn > 6{
                
                spawnTime()
                timerSpawn = 0
                
            }
            
            if timerSpawn == 5{
                spawnMinusTime()
            
            }
        
        }
        
        else{
            gameTimer.invalidate()
            runGameOver()
        }
    }
        
    
    
    func loseALife(){
        
        livesNumber -= 1
        livesLabel.text = "Lives: \(livesNumber)"
        
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown   = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
        
        if livesNumber == 0 {
            runGameOver()
        }
        
        fireLimit = 0               //player gets a bullet if he loses a live (ONLY IN SINGLE SHOT MODE)
        
    }
    
    
    func addScore(){
        gameScore += 1
        scoreLabel.text = "Score: \(gameScore)"
        
        if gameScore == 10 || gameScore == 25 || gameScore == 50 { //Level Borders ranges...
            startNewLevel()
        }
        
        if gameModeChoice == 1{
            if gameScore > highScoreNumberClassic && highscoreReached == 0{
                
                scoreLabel.fontColor = SKColor.yellow
                let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleDown   = SKAction.scale(to: 1, duration: 0.2)
                let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
                scoreLabel.run(scaleSequence)
                highscoreReached = 1                //performs Action only once
            }}
        
        if gameModeChoice == 2{
            if gameScore > highScoreNumberTimeMode && highscoreReached == 0{
                
                scoreLabel.fontColor = SKColor.yellow
                let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleDown   = SKAction.scale(to: 1, duration: 0.2)
                let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
                scoreLabel.run(scaleSequence)
                highscoreReached = 1                //performs Action only once
            }}
        
        if gameModeChoice == 3{
            if gameScore > highScoreNumberSingelShot && highscoreReached == 0{
                
                scoreLabel.fontColor = SKColor.yellow
                let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleDown   = SKAction.scale(to: 1, duration: 0.2)
                let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
                scoreLabel.run(scaleSequence)
                highscoreReached = 1                //performs Action only once
            }}
        
    }
    
    
    
    
    
    func runGameOver(){
        
        currentGameState = gameState.aftergame
        
        self.removeAllActions()
        
        self.enumerateChildNodes(withName: "Bullet"){
            bullet, stop in //calls all objects bullets...
            bullet.removeAllActions()
            
        }
        
        self.enumerateChildNodes(withName: "Enemy"){
            enemy, stop in
            enemy.removeAllActions()
            
        }
        
        self.enumerateChildNodes(withName: "ProtectionItem"){
            protection, stop in
            protection.removeAllActions()
            
        }
        
        self.enumerateChildNodes(withName: "timerIcon"){
            timeIcon, stop in
            timeIcon.removeAllActions()
            
        }
        
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSceneSequence)
        
    }
    
    
    func changeScene(){
        
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{ //because Enemy is always higher than player or bullet
            body1 = contact.bodyA
            body2 = contact.bodyB
        }
        else{
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Enemy { //if player hits enemy
            
            if protection == 0{
                
                if body1.node != nil {
                    
                    spawnExplosion(body1.node!.position)
                }
                
                if body2.node != nil {
                    spawnExplosion(body2.node!.position)
                }
                
                body1.node?.removeFromParent() //player
                body2.node?.removeFromParent() //enemy
                
                runGameOver()
            }
            
            if protection == 1{
                
                if body2.node != nil {
                    spawnExplosion(body2.node!.position)
                }
                
                body2.node?.removeFromParent() //enemy
                
                fireLimit = 0
                
                
            }
            
            
            
            
        }
        
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.Enemy && body2.node?.position.y < self.size.height { //if bullet hits enemy
            
            addScore()
            
            fireLimit = 0
            
            if body2.node != nil {
                spawnExplosion(body2.node!.position)
            }
            
            body1.node?.removeFromParent() //player
            body2.node?.removeFromParent() //enemy
            
        }
        
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Protection {
            
            protection = 1
            
            let timeLeft = SKLabelNode(fontNamed: "The Bold Font")
            timeLeft.text = "active Shield"
            timeLeft.fontSize = 50
            timeLeft.fontColor = SKColor.white
            timeLeft.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.8)
            timeLeft.zPosition = 100
            self.addChild(timeLeft)
            
            let fadeIn = SKAction.fadeIn(withDuration: 0.2)
            let fadeOut = SKAction.fadeOut(withDuration: 0.2)
            let fadeSequence = SKAction.sequence([fadeOut,fadeIn,fadeOut,fadeIn,fadeOut])
            
            let protectionTime = SKAction.wait(forDuration: 5)                //set protection time
            let deleteProtectionLabel = SKAction.removeFromParent()
            let protectionOff = SKAction.run{self.protection = 0}
            
            
            
            
            let protectionSequence = SKAction.sequence([protectionTime,fadeSequence,deleteProtectionLabel,protectionOff])
            timeLeft.run(protectionSequence)
            
            body2.node?.removeFromParent() //Protection
            
            let startProtection = SKAction.fadeAlpha(to: 1, duration: 0.1)
            let waitBeforeProtectionOff = SKAction.wait(forDuration: 5)
            let fadeOutProtection = SKAction.fadeAlpha(to: 0.1, duration: 0.2)
            let fadeInProtection = SKAction.fadeAlpha(to: 1, duration: 0.2)
            let fadeSequenceForProtection = SKAction.sequence([fadeOutProtection,fadeInProtection,fadeOutProtection,fadeInProtection,fadeOutProtection])
            let deleteCoverFromPlayer = SKAction.fadeAlpha(to: 0, duration: 0.1) //Maybe just make alpha to 0 and fade it in every time the player gets the Protection icon
            //if protectionPlayer will be deleted, no way of creating a new one (global)
            let deleteCoverSequence = SKAction.sequence([startProtection,waitBeforeProtectionOff,fadeSequenceForProtection,deleteCoverFromPlayer])
            
            protectionPlayer.run(deleteCoverSequence)
            
        }
        
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.TimeIcon {
        
            let randomBonusTime = random(min: 5, max: 15)
            
            remainingTimeInteger = remainingTimeInteger + Int(round(randomBonusTime))
            
            print(randomBonusTime)
            print(round(randomBonusTime))
            
            
            let extraBonus = SKLabelNode(fontNamed: "The Bold Font")
            extraBonus.text = "+ \(String(describing: round(randomBonusTime)))"
            extraBonus.fontSize = 90
            extraBonus.fontColor = SKColor.yellow
            extraBonus.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            extraBonus.position = CGPoint(x: self.size.width*0.85, y: self.size.height*0.85 )
            extraBonus.zPosition = 100
            self.addChild(extraBonus)
            
            let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
            let wait = SKAction.wait(forDuration: 0.8)
            let moveOverLabel = SKAction.moveTo(y: remainingTimeForTimeMode.position.y, duration: 0.2)
            let fadeOutAction = SKAction.fadeOut(withDuration: 0.2)
            let delete = SKAction.removeFromParent()
            let sequence = SKAction.sequence([fadeInAction,wait,moveOverLabel,fadeOutAction,delete])
            
            extraBonus.run(sequence)
            
            let waitUp = SKAction.wait(forDuration: 1.2)
            let performAction = SKAction.run {
                self.remainingTimeForTimeMode.text = String(self.remainingTimeInteger)
            }
            let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
            let scaleDown   = SKAction.scale(to: 1, duration: 0.2)
            let remainingTimeSequence = SKAction.sequence([waitUp,performAction,scaleUp,scaleDown])
            remainingTimeForTimeMode.run(remainingTimeSequence)
            
            body2.node?.removeFromParent() //TimeIcon
            
        
        
        
        }
        
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.MinusTimeIcon {
            
            let randomBonusTime = random(min: 10, max: 5)
            
            remainingTimeInteger = remainingTimeInteger - Int(round(randomBonusTime))
            
            print(randomBonusTime)
            print(round(randomBonusTime))
            
            
            let extraBonus = SKLabelNode(fontNamed: "The Bold Font")
            extraBonus.text = "- \(String(describing: round(randomBonusTime)))"
            extraBonus.fontSize = 90
            extraBonus.fontColor = SKColor.red
            extraBonus.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            extraBonus.position = CGPoint(x: self.size.width*0.85, y: self.size.height*0.85 )
            extraBonus.zPosition = 100
            self.addChild(extraBonus)
            
            let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
            let wait = SKAction.wait(forDuration: 0.8)
            let moveOverLabel = SKAction.moveTo(y: remainingTimeForTimeMode.position.y, duration: 0.2)
            let fadeOutAction = SKAction.fadeOut(withDuration: 0.2)
            let delete = SKAction.removeFromParent()
            let sequence = SKAction.sequence([fadeInAction,wait,moveOverLabel,fadeOutAction,delete])
            
            extraBonus.run(sequence)
            
            let waitUp = SKAction.wait(forDuration: 1.2)
            let performAction = SKAction.run {
                self.remainingTimeForTimeMode.text = String(self.remainingTimeInteger)
            }
            let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
            let scaleDown   = SKAction.scale(to: 1, duration: 0.2)
            let remainingTimeSequence = SKAction.sequence([waitUp,performAction,scaleUp,scaleDown])
            remainingTimeForTimeMode.run(remainingTimeSequence)
            
            
            body2.node?.removeFromParent() //TimeIcon
            
            
            
            
        }
        
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.TimeIcon && body2.node?.position.y < self.size.height { //if bullet hits timeIcons
        
            /*
            let scaleDown = SKAction.scale(to: 0, duration: 0.2)
            let action = SKAction.fadeOut(withDuration: 0.2)
            let delete = SKAction.removeFromParent()
            let sequence = SKAction.sequence([scaleDown,action,delete])
            */
            
            body2.node?.removeFromParent() //TimeIcon
            
            
        }
        
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.MinusTimeIcon && body2.node?.position.y < self.size.height { //if bullet hits timeIcons
            
            /*
             let scaleDown = SKAction.scale(to: 0, duration: 0.2)
             let action = SKAction.fadeOut(withDuration: 0.2)
             let delete = SKAction.removeFromParent()
             let sequence = SKAction.sequence([scaleDown,action,delete])
             */
            
            body2.node?.removeFromParent() //TimeIcon
            
            
        }
    }
    
    func spawnExplosion(_ spawnPosition: CGPoint){
        
        let explosion = SKSpriteNode(imageNamed: "explosion")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0)
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1.5, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([scaleIn, fadeOut, delete])
        explosion.run(explosionSequence)
        
    }
    
    
    
    func fireBullet() {
        
        if fireLimit == 0{
            
            let bullet = SKSpriteNode(imageNamed: "bullet")
            
            bullet .name = "Bullet"
            bullet.setScale(1) //size
            bullet.position = player.position
            bullet.zPosition = 1
            bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
            bullet.physicsBody!.affectedByGravity = false
            bullet.physicsBody!.categoryBitMask = PhysicsCategories.Bullet
            bullet.physicsBody!.collisionBitMask = PhysicsCategories.None
            bullet.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
            self.addChild(bullet)
            
            let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1) //makes the bullet fly to the top of the screen. duration is the time it takes
            let deleteBullet = SKAction.removeFromParent()
            let bulletSequence = SKAction.sequence([moveBullet,deleteBullet])
            bullet.run(bulletSequence)
        }
        
    }
    
    func spawnTime(){
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let timeIcon = SKSpriteNode(imageNamed: "explosion")
        
        timeIcon.name = "timerIcon"
        timeIcon.setScale(0.6)
        timeIcon.position = startPoint
        timeIcon.zPosition = 2
        timeIcon.physicsBody = SKPhysicsBody(rectangleOf: timeIcon.size)
        timeIcon.physicsBody!.affectedByGravity = false
        timeIcon.physicsBody!.categoryBitMask = PhysicsCategories.TimeIcon
        timeIcon.physicsBody!.collisionBitMask = PhysicsCategories.None
        timeIcon.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(timeIcon)
        
        let moveIcon = SKAction.move(to: endPoint, duration: TimeInterval(vmaxEnemy))
        let deleteIcon = SKAction.removeFromParent()
        let iconSequence = SKAction.sequence([moveIcon,deleteIcon])
        
        
        
        
        timeIcon.run(iconSequence)
        
        
    }
    
    func spawnMinusTime(){
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let timeIcon = SKSpriteNode(imageNamed: "explosionRed")
        
        timeIcon.name = "timerIcon"
        timeIcon.setScale(0.6)
        timeIcon.position = startPoint
        timeIcon.zPosition = 2
        timeIcon.physicsBody = SKPhysicsBody(rectangleOf: timeIcon.size)
        timeIcon.physicsBody!.affectedByGravity = false
        timeIcon.physicsBody!.categoryBitMask = PhysicsCategories.MinusTimeIcon
        timeIcon.physicsBody!.collisionBitMask = PhysicsCategories.None
        timeIcon.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(timeIcon)
        
        let moveIcon = SKAction.move(to: endPoint, duration: TimeInterval(vmaxEnemy))
        let deleteIcon = SKAction.removeFromParent()
        let iconSequence = SKAction.sequence([moveIcon,deleteIcon])
        
        
        
        
        timeIcon.run(iconSequence)
        
        
    }
    
    func spawnEnemy(){
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let enemy = SKSpriteNode(imageNamed: "newEnemy")
        
        enemy.name = "Enemy"
        enemy.setScale(0.6)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCategories.Enemy
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: TimeInterval(vmaxEnemy))
        let deleteEnemy = SKAction.removeFromParent()
        let loseALifeAction = SKAction.run(loseALife)
        let enemySequence = SKAction.sequence([moveEnemy,deleteEnemy, loseALifeAction])
        let enemySequenceTimeMode = SKAction.sequence([moveEnemy,deleteEnemy])
        
        
        
        if currentGameState == gameState.inGame && gameModeChoice != 2{
            enemy.run(enemySequence)
        }
        if currentGameState == gameState.inGame && gameModeChoice == 2{         //you don't lose a life
            enemy.run(enemySequenceTimeMode)
        }
        
        
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let amountToRotate = atan2(dy, dx)
        enemy.zRotation = amountToRotate
        
        
    }
    
    
    func spawnProtection(){
        
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let protectionItem = SKSpriteNode(imageNamed: "icon")
        
        protectionItem.name = "ProtectionItem"
        protectionItem.setScale(0.3)
        protectionItem.position = startPoint
        protectionItem.zPosition = 2
        protectionItem.physicsBody = SKPhysicsBody(rectangleOf: protectionItem.size)
        protectionItem.physicsBody!.affectedByGravity = false
        protectionItem.physicsBody!.categoryBitMask = PhysicsCategories.Protection
        protectionItem.physicsBody!.collisionBitMask = PhysicsCategories.None
        protectionItem.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(protectionItem)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 4)
        let deleteEnemy = SKAction.removeFromParent()
        let waitForDuration = SKAction.wait(forDuration: 1)
        let enemySequence = SKAction.sequence([waitForDuration, moveEnemy,deleteEnemy])
        
        
        
        
        if currentGameState == gameState.inGame{
            protectionItem.run(enemySequence)
        }
        
        
        
    }
    
    
    func startNewLevel() {
        
        print("NEW LEVEL REACHED")
        
        levelNumber += 1
        
        if self.action(forKey: "spawningEnemie") != nil{
            self.removeAction(forKey: "spawningEnemies")
        }
        
        let spawnp = SKAction.run(spawnProtection)                 // Spawn Protection
        self.run(spawnp)
        
        
        
        var levelDuration = TimeInterval()
        
        //-------------------- EASY
        
        if selectedLevelMode == 0 {
            
            switch levelNumber {
            case 1: levelDuration = 2.0
            vmaxEnemy = 3.5
            case 2: levelDuration = 1.8
                
            case 3: levelDuration = 1.5
            vmaxEnemy = vmaxEnemy - 0.3
            case 4: levelDuration = 1.2
                
                
            //add here new level
            default:
                levelDuration = 0.5
                print("Cannot find level info")
            }
        }
        
        //------------------- MEDIUM
        
        if selectedLevelMode == 1 {
            
            switch levelNumber {
            case 1: levelDuration = 1.3
            vmaxEnemy = 2.6
            case 2: levelDuration = 1.1
                
            case 3: levelDuration = 0.9
            vmaxEnemy = vmaxEnemy - 0.3
            case 4: levelDuration = 0.7
                
                
            //add here new level
            default:
                levelDuration = 0.5
                print("Cannot find level info")
            }
        }
        
        //-------------------- HARD
        
        if selectedLevelMode == 2 {
            
            switch levelNumber {
            case 1: levelDuration = 1.1
            vmaxEnemy = 2.3
            case 2: levelDuration = 0.8
                
            case 3: levelDuration = 0.6
            vmaxEnemy = vmaxEnemy - 0.3
            case 4: levelDuration = 0.4
                
                
            //add here new level
            default:
                levelDuration = 0.5
                print("Cannot find level info")
            }
        }
            
            //-------------------- DEFAULT
            
        else{
            switch levelNumber {
            case 1: levelDuration = 1.2
            case 2: levelDuration = 1.0
            case 3: levelDuration = 0.8
            case 4: levelDuration = 0.5
            //add here new level
            default:
                levelDuration = 0.5
                print("Cannot find level info")
            }
        }
        
        
        
        
        let spawn = SKAction.run(spawnEnemy)                       //Spawn Enemy
        let waitToSpawn = SKAction.wait(forDuration: levelDuration)
        let spawnSequence = SKAction.sequence([waitToSpawn, spawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever, withKey: "spawningEnemies")
        
    }
    
    func pauseGame(){
        
        self.view?.isPaused = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self)
            let NodeITapped = atPoint(pointOfTouch)
            
            if currentGameState == gameState.inGame{
                
                if NodeITapped.name == "PauseLabel"{
                    
                    currentGameState = gameState.pauseGame
                    
                    
                    
                    
                    
                    self.run(SKAction.run(self.pauseGame))
                    
                    // let moveToCenter = SKAction.moveTo(x: 0.5, duration: 0.5)
                    
                    resumeLabel.text = "Resume"
                    resumeLabel.name = "ResumeLabel"
                    resumeLabel.fontSize = 120
                    resumeLabel.fontColor = SKColor.white
                    resumeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                    resumeLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
                    resumeLabel.zPosition = 100
                    self.addChild(resumeLabel)
                    
                    
                    menueLabel.text = "Menue"
                    menueLabel.name = "MenueLabel"
                    menueLabel.fontSize = 70
                    menueLabel.fontColor = SKColor.white
                    menueLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                    menueLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.4)
                    menueLabel.zPosition = 100
                    self.addChild(menueLabel)
                    
                    pauseLabel.alpha = 0
                    pauseLabel.name = "DifferentName"
                    
                    
                    
                    // resumeLabel.run(moveToCenter)
                    // menueLabel.run(moveToCenter)
                    
                }
                
            }
            
            if NodeITapped.name == "ResumeLabel"{
                
                currentGameState = gameState.inGame
                
                resumeLabel.removeFromParent()
                menueLabel.removeFromParent()
                
                self.view?.isPaused = false
                
                pauseLabel.alpha = 1
                pauseLabel.name = "PauseLabel"
                
                
            }
            
            if NodeITapped.name == "MenueLabel"{                    //Does not work yet!!
                
                self.view?.isPaused = false
                
                let sceneToMoveTo = MainMenueScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
            
            
        }
        
        if currentGameState == gameState.preGame{
            startGame()
        }
            
        else if currentGameState == gameState.inGame{
            
            if gameModeChoice == 3{
                fireBullet()
                fireLimit = 1
            }
            else{
                fireBullet()
                
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
            //print(controlMode)
            
            if selectedControlMode == 1 {
                
                
                
                if currentGameState == gameState.inGame{
                    player.position.x += amountDragged
                    if protection == 1{
                        protectionPlayer.position.x = player.position.x
                        protectionPlayer.position.y = player.position.y
                    }
                }
            }
            
            if player.position.x > gameArea.maxX - player.size.width/2 {
                player.position.x = gameArea.maxX - player.size.width/2
            }
            
            if player.position.x < gameArea.minX + player.size.width/2 {
                player.position.x = gameArea.minX + player.size.width/2
            }
            
        }
        
    }
    
    
    
    
}

