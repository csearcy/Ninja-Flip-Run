//
//  CSWall.swift
//  Jumping Man
//
//  Created by Chris Searcy on 2/13/16.
//  Copyright © 2016 Chris Searcy. All rights reserved.
//

import Foundation
import SpriteKit


class CSWall: SKSpriteNode {
	
	var WALL_WIDTH: CGFloat = 30.0
	var WALL_HEIGHT: CGFloat = 50.0
	var WALL_COLOR: UIColor = UIColor.brownColor()
	
	init() {
		let wallSize = CGSizeMake(WALL_WIDTH, WALL_HEIGHT)
		super.init(texture: nil, color: WALL_COLOR, size: wallSize)
		loadPhysicsBodyWithSize(wallSize)
		startMoving()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func startMoving() {
		
		let moveLeft = SKAction.moveByX(-kDefaultXToMovePerSecond, y: 0, duration: 1.0)
		
		runAction(SKAction.repeatActionForever(moveLeft))
	}
	
	func stopMoving() {
		removeAllActions()
	}
	
	func loadPhysicsBodyWithSize(size: CGSize) {
		
		physicsBody = SKPhysicsBody(rectangleOfSize: size)
		physicsBody?.contactTestBitMask = wallCategory
		physicsBody?.affectedByGravity = false
	}
	
}