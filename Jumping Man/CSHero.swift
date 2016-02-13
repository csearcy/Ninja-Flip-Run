//
//  CSHero.swift
//  Jumping Man
//
//  Created by Chris Searcy on 2/11/16.
//  Copyright © 2016 Chris Searcy. All rights reserved.
//

import Foundation
import SpriteKit

class CSHero: SKSpriteNode {
	
	var body, upperArm, leftFoot, rightFoot: SKSpriteNode!
	var foreArm: SKSpriteNode!
	var isUpsideDown = false
	
	init() {
		
		let skinColor = UIColor(red: 207.0/255.0, green: 193.0/255.0, blue: 168.0/255.0, alpha: 1.0)
		let bodyWidth: CGFloat = 32.0
		let bodyHeight: CGFloat = 44.0
		let footWidth: CGFloat = 0.25*bodyWidth
		let shoeColor: UIColor = UIColor.blackColor()
		let armColor: UIColor = UIColor(red: 46.0/255.0, green: 46.0/255.0, blue: 46.0/255.0, alpha: 1.0)
		
		super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(bodyWidth, bodyHeight))
		
		// Create Ninja Body
		body = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(32, 40))
		body.position =  CGPointMake(0,2)
		addChild(body)
		
		// Base foot height off of how high the hero is startgin off the ground
		let footHeight: CGFloat = 2 + body.position.y
		
		// Add face
		let face = SKSpriteNode(color: skinColor, size: CGSizeMake(body.size.width,10))
		face.position = CGPointMake(0,7)
		body.addChild(face)
		
		// Add eyes
		let leftEye = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(6, 6))
		let rightEye = leftEye.copy() as! SKSpriteNode
		let pupil = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(3, 3))
		let eyeBrow = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(11, 1))
		
		pupil.position = CGPointMake(2, 0)
		eyeBrow.position = CGPointMake(-1, leftEye.size.height/2)
		
		leftEye.addChild(pupil)
		rightEye.addChild(pupil.copy() as! SKSpriteNode)
		leftEye.addChild(eyeBrow)
		rightEye.addChild(eyeBrow.copy() as! SKSpriteNode)
		
		leftEye.position = CGPointMake(-4, 0)
		face.addChild(leftEye)
		
		rightEye.position = CGPointMake(14, 0)
		face.addChild(rightEye)
		
		// Add arm
		upperArm = SKSpriteNode(color: armColor, size: CGSizeMake(7,5))
		upperArm.anchorPoint = CGPointMake(0.5,1.0)
		upperArm.position = CGPointMake(-10,-5)
		//upperArm.position = CGPointMake(-body.size.width/2+upperArm.size.width,-5)
		body.addChild(upperArm)

		foreArm = SKSpriteNode(color: armColor, size: CGSizeMake(7, 5))
		foreArm.position = CGPointMake(0, -upperArm.size.height)
		upperArm.addChild(foreArm)
		
		let hand = SKSpriteNode(color: skinColor, size: CGSizeMake(7, 3))
		hand.position = CGPointMake(0, -foreArm.size.height/2)
		foreArm.addChild(hand)
		
		// Add feet
		leftFoot = SKSpriteNode(color: shoeColor, size: CGSizeMake(footWidth, footHeight))
		leftFoot.position = CGPointMake(-bodyWidth/4, -bodyHeight/2.0 + footHeight/2)
		addChild(leftFoot)
		
		rightFoot = leftFoot.copy() as! SKSpriteNode
		rightFoot.position = CGPointMake(bodyWidth/4, -bodyHeight/2.0 + footHeight/2)
		addChild(rightFoot)
		
		
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	
	func startRunning() {
		let rotateUp = SKAction.rotateByAngle(CGFloat(M_PI/2), duration: 0.1)
		foreArm.runAction(rotateUp)
		upperArm.runAction(rotateUp)
		performOneRunCycle()
		
	}
	
	
	func performOneRunCycle() {
		
		// Rotates 45degress clockwise
		let rotateForward = SKAction.rotateByAngle(CGFloat(M_PI*3/2), duration: 0.05)
		let rotateBack = SKAction.rotateByAngle(-CGFloat(M_PI*3/2), duration: 0.05)
		let up = SKAction.moveByX(0, y: 2, duration: 0.05)
		let down = SKAction.moveByX(0, y: -2, duration: 0.05)
		
		leftFoot.runAction(up, completion: { () -> Void in
			self.upperArm.runAction(rotateBack, completion: { () -> Void in
				
				self.leftFoot.runAction(down)
				
				self.rightFoot.runAction(up, completion: { () -> Void in
					self.rightFoot.runAction(down, completion: { () -> Void in
						self.upperArm.runAction(rotateForward)
						//self.upperArm.runAction(backward)
						self.performOneRunCycle()
					})
				})
			})
		})
	}
	
	func flip() {
		isUpsideDown = !isUpsideDown
		
		var scale: CGFloat!
		
		if isUpsideDown {
			scale = -1.0
		} else {
			scale = 1.0
		}
	
		let translate = SKAction.moveByX(0, y: scale*(size.height + kCSGroundHeight), duration: 0.01)
		let flip = SKAction.scaleYTo(scale, duration: 0.01)
		
		
		runAction(translate)
		runAction(flip)
		
	}
	
	func breath() {
		
		let BreathOut = SKAction.moveByX(0, y: -2, duration: 1)
		let BreathIn = SKAction.moveByX(0, y: 2, duration: 1)
		let breath = SKAction.sequence([BreathOut, BreathIn])
		
		body.runAction(SKAction.repeatActionForever(breath))
		
	}
	
	func stop() {
		body.removeAllActions()
	}
	
}