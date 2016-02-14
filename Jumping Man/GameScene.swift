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
	var isGameOver = false
	var cloudGenerator: CSCloudGenerator!
	var wallGenerator: CSWallGenerator!
	var currentLevel = 0
	
	override func	didMoveToView(view: SKView) {
		backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
		
		//addBackground()
		
		addMovingGround()
		
		addHero()
		
		hero.breath()
		
		addCloudGenerator()
		
		addWallGenerator()
		
		addStartLabel()
		
		addPointsLabels()
		
		loadHighScore()
		
		addPhysicsWorld()
		
	}
	
	func addMovingGround() {
		// Add Ground
		movingGround = CSMovingGround(size: CGSizeMake(view!.frame.width, kCSGroundHeight))
		movingGround.position = CGPointMake(0, view!.frame.height/2)
		addChild(movingGround)
	}
	
	
	func addHero() {
		// Add hero
		hero = CSHero()
		hero.position = CGPointMake(70, movingGround.position.y + movingGround.size.height/2+hero.frame.size.height/2)
		addChild(hero)
	}
	
	func addCloudGenerator() {
		// Add Cloud generator
		cloudGenerator = CSCloudGenerator(color: UIColor.clearColor(), size: view!.frame.size)
		cloudGenerator.position = view!.center
		addChild(cloudGenerator)
		cloudGenerator.populate(7)
		cloudGenerator.startGeneratingWithSpawnTime(5)
	}
	
	func addWallGenerator() {
		// Add wall Generator
		wallGenerator = CSWallGenerator(color: UIColor.clearColor(), size: view!.frame.size)
		wallGenerator.position = view!.center
		addChild(wallGenerator)
	}
	
	func addStartLabel() {
		// Add Start Label
		let tapToStartLabel = SKLabelNode(text: "Tap To Start!")
		tapToStartLabel.name = "tapToStartLabel"
		tapToStartLabel.position.x  = view!.center.x
		tapToStartLabel.position.y  = view!.center.y + 40
		tapToStartLabel.fontName = "Helvetica"
		tapToStartLabel.fontColor = UIColor.blackColor()
		addChild(tapToStartLabel)
		tapToStartLabel.runAction(blinkAnimantion())
	}
	
	func addPointsLabels() {
		
		let pointsLabel = CSPointsLabel(num: 0)
		let highScoreLabel = CSPointsLabel(num: 0)
		
		pointsLabel.name = "pointsLabel"
		pointsLabel.position = CGPointMake(50, frame.size.height-40)
		addChild(pointsLabel)
		
		highScoreLabel.name = "highScoreLabel"
		highScoreLabel.position	= CGPointMake(frame.size.width-50, frame.size.height-40)
		addChild(highScoreLabel)
		
		let highScoreTextLabel = SKLabelNode(text: "High Score")
		highScoreTextLabel.fontName = "Helvetica"
		highScoreTextLabel.fontSize = 14
		highScoreTextLabel.fontColor = UIColor.blackColor()
		highScoreTextLabel.position = CGPointMake(0, -20)
		highScoreLabel.addChild(highScoreTextLabel)
		
	}
	
	func addPhysicsWorld() {
		// Add Physics world
		physicsWorld.contactDelegate = self
	}
	
	func addBackground() {
	// Create background image

		let backgroundTexture = SKTexture(imageNamed: "Space.jpeg")
		let backgroundImage = SKSpriteNode(texture: backgroundTexture, size: view!.frame.size)
		
		backgroundImage.position = view!.center
		addChild(backgroundImage)
	}

	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		if isGameOver {
			restartGame()
			
		} else if !isStarted {
			start()
		} else {
			hero.flip()
		}
		
	}
	
	func loadHighScore() {
		let defualts = NSUserDefaults.standardUserDefaults()
		
		let highScoreLabel = childNodeWithName("highScoreLabel") as! CSPointsLabel
		
		highScoreLabel.setTo(defualts.integerForKey("highscore"))
		
	}
	
	// MARK: - Game Lifecycle
		func start()	{
		isStarted = true
		let tapToStartLabel = childNodeWithName("tapToStartLabel")
		tapToStartLabel?.removeFromParent()
		hero.stop()
		hero.startRunning()
		movingGround.start()
		wallGenerator.startGeneratingWallsEvery(1)
	}
	
	func gameOver() {
		isGameOver = true
		
		// stop everything
		hero.fall()
		wallGenerator.stopWalls()
		movingGround.stop()
		hero.stop()
		
		// crete game over label
		let GameOverLabel = SKLabelNode(text: "Game Over!")
		GameOverLabel.name = "GameoverLabel"
		GameOverLabel.position.x  = view!.center.x
		GameOverLabel.position.y  = view!.center.y + 40
		GameOverLabel.fontName = "Helvetica"
		GameOverLabel.fontColor = UIColor.blackColor()
		addChild(GameOverLabel)
		GameOverLabel.runAction(blinkAnimantion())
		
		// Save current points label value
		let pointsLabel = childNodeWithName("pointsLabel") as! CSPointsLabel
		let highScoreLabel = childNodeWithName("highScoreLabel") as! CSPointsLabel
	
		if highScoreLabel.number < pointsLabel.number {
			highScoreLabel.setTo(pointsLabel.number)
			
			let defaults = NSUserDefaults.standardUserDefaults()
			
			defaults.setInteger(highScoreLabel.number, forKey: "highscore")
			
		}
		
	}
	
	func restartGame() {
		
		cloudGenerator.stopGenerating()
		let newGameScene = GameScene(size: view!.bounds.size)
		
		view!.presentScene(newGameScene)
	}
	
	// MARK: - SKPhysicsContactDelegate
	func didBeginContact(contact: SKPhysicsContact) {
		if !isGameOver {
			gameOver()
		}
	}
	
	override func update(currentTime: NSTimeInterval) {
		
		if wallGenerator.wallTrackers.count > 0 {
			let wall = wallGenerator.wallTrackers[0] as	CSWall
		
			let wallLocation = wallGenerator.convertPoint(wall.position, toNode: self)
		
			if wallLocation.x < hero.position.x {
			
				wallGenerator.wallTrackers.removeAtIndex(0)
			
				let pointsLabel = childNodeWithName("pointsLabel") as! CSPointsLabel
			
				pointsLabel.increment()
			
				
				if pointsLabel.number % kNUMBER_OF_POINTS_PER_LEVEL == 0 {
					currentLevel++
					wallGenerator.stopGenerating()
					wallGenerator.startGeneratingWallsEvery(kLEVEL_GENERATION_TIMES[currentLevel])
					
				}
				
			}
		}
		
	}
	
	// MARK: - Animations
	func blinkAnimantion() -> SKAction {
		let duration = 0.4
		let fadeOut = SKAction.fadeAlphaTo(0, duration: duration)
		let fadeIn = SKAction.fadeAlphaTo(1.0, duration: duration)
		
		let blink = SKAction.sequence([fadeIn, fadeOut])
		return SKAction.repeatActionForever(blink)
		
	}
	
}