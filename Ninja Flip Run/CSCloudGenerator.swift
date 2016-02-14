//
//  CSCloudGenerator.swift
//  Ninja Flip Run
//
//  Created by Chris Searcy on 2/13/16.
//  Copyright © 2016 Chris Searcy. All rights reserved.
//

import Foundation
import SpriteKit

class CSCloudGenerator: SKSpriteNode {
	
	let CLOUD_WIDTH: CGFloat = 125
	let CLOUD_HEIGHT: CGFloat = 55
	var generationTimer: NSTimer!
	
	func populate(num: Int) {
		
		for var i = 0; i<num; i++ {
			
			let cloud = CSCloud(size: CGSizeMake(CLOUD_WIDTH, CLOUD_HEIGHT))
			
			let x = CGFloat(arc4random_uniform(UInt32(size.width)))-size.width/2
			let y = CGFloat(arc4random_uniform(UInt32(size.height)))-size.height/2
			
			cloud.position = CGPointMake(x, y)
			cloud.zPosition = -1
			addChild(cloud)
			
		}
		
	}
	
	func startGeneratingWithSpawnTime(seconds: NSTimeInterval) {
		generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateCloud", userInfo: nil, repeats: true)
	}
	
	func generateCloud() {
		
		let x = size.width/2 + CLOUD_WIDTH/2
		let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
		
		let cloud = CSCloud(size: CGSizeMake(CLOUD_WIDTH, CLOUD_HEIGHT))
		cloud.position = CGPointMake(x,y)
		cloud.zPosition = -1
		addChild(cloud)
		
		
	}
	
	func stopGenerating() {
		generationTimer.invalidate()
	}
	
}