//
//  GameViewController.swift
//  Ninja Flip Run
//
//  Created by Chris Searcy on 2/11/16.
//  Copyright (c) 2016 Chris Searcy. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class GameViewController: UIViewController {

	var scene: GameScene!
	
    override func viewDidLoad() {
		super.viewDidLoad()
		
		//Configure the view
		let skView = view as! SKView
		skView.multipleTouchEnabled = false
		
		// Create and configure scene
		scene = GameScene(size: skView.bounds.size)
		scene.scaleMode = .AspectFill
		
		// Present the scene
		skView.presentScene(scene)
		
    }
    
    func handleTap(gestureRecognize: UIGestureRecognizer) {
		
		
		
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
