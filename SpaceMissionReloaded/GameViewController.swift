//
//  GameViewController.swift
//  SpaceMissionReloaded
//
//  Created by Yannick Klose on 07.10.16.
//  Copyright © 2016 Yannick Klose. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion








class GameViewController: UIViewController, UIAlertViewDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let scene = MainMenueScene(size: CGSize(width: 1536 , height: 2048)) //makes Game universal, one size
        // Configure the view.
        let skView = self.view as! SKView
        
        // Uncommented these two lines to prevent the FPS and Sprite count display (before posting to GitHub)
        //skView.showsFPS = true
        //skView.showsNodeCount = true
        //skView.showsPhysics = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
        
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
