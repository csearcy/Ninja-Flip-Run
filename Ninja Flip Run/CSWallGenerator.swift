//
//  CSWallGenerator.swift
//  Ninja Flip Run
//
//  Created by Chris Searcy on 2/13/16.
//  Copyright © 2016 Chris Searcy. All rights reserved.
//

import Foundation
import SpriteKit

class CSWallGenerator: SKSpriteNode {
	
	var WALL_WIDTH: CGFloat = 30.0
	var WALL_HEIGHT: CGFloat = 50.0
	var generationTimer: NSTimer?
	var walls = [CSWall]()	// Empty array of walls
	var wallTrackers = [CSWall]()
	
	func startGeneratingWallsEvery(seconds: NSTimeInterval) {
		
		generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
		
	}
	
	func stopGenerating() {
		generationTimer?.invalidate()
	}
	
	func generateWall() {
		
		let scale: CGFloat!
		let rand =  arc4random_uniform(2)
		
		if rand == 0 {
			scale = 1.0
		} else {
			scale = -1.0
		}
		
		let x = size.width/2 + WALL_WIDTH/2
		//let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
		
		let y = scale * (kCSGroundHeight/2 + WALL_HEIGHT/2)
		
		let wall = CSWall()
		wall.position = CGPointMake(x,y)
		walls.append(wall)
		wallTrackers.append(wall)
		addChild(wall)
		
	}
	
	func stopWalls() {
		
		stopGenerating()
		
		for wall in walls {
			wall.stopMoving()
		}
		
		
	}
	
	func loadPhysicsBodyWithSize(size: CGSize) {
		
		physicsBody = SKPhysicsBody(rectangleOfSize: size)
		physicsBody?.categoryBitMask = heroCategory
		physicsBody?.contactTestBitMask = wallCategory
		physicsBody?.affectedByGravity = false
	}
	
}