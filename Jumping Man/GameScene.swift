//
//  GameScene.swift
//  Jumping Man
//
//  Created by Chris Searcy on 2/11/16.
//  Copyright © 2016 Chris Searcy. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

	var movingGround: CSMovingGround!
	var hero: CSHero!
	var isStarted = false
	var cloudGenerator: CSCloudGenerator!
	
	override func	didMoveToView(view: SKView) {
		backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
		
		// Create background image
		/*
		let backgroundTexture = SKTexture(imageNamed: "Space.jpeg")
		let backgroundImage = SKSpriteNode(texture: backgroundTexture, size: view.frame.size)
		
		backgroundImage.position = view.center
		addChild(backgroundImage)
		*/

		// Add Ground
		movingGround = CSMovingGround(size: CGSizeMake(view.frame.width, kCSGroundHeight))
		movingGround.position = CGPointMake(0, view.frame.height/2)
		addChild(movingGround)
		
		
		// Add hero
		hero = CSHero()
		hero.position = CGPointMake(70, movingGround.position.y + movingGround.size.height/2+hero.frame.size.height/2)
		addChild(hero)
		
		// Start breathing
		hero.breath()
		
		// Add Cloud generator
		cloudGenerator = CSCloudGenerator(color: UIColor.clearColor(), size: view.frame.size)
		cloudGenerator.position = view.center
		addChild(cloudGenerator)
		cloudGenerator.populate(7)
		cloudGenerator.startGeneratingWithSpawnTime(5)
		
		
	}
	
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		
		if !isStarted {
			start()
		} else {
			hero.flip()
		}
		
	}
	
	func start()	{
		isStarted = true
		hero.stop()
		hero.startRunning()
		movingGround.start()
	}
	
}