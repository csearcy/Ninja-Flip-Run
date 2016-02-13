//
//  CSWallGenerator.swift
//  Jumping Man
//
//  Created by Chris Searcy on 2/13/16.
//  Copyright © 2016 Chris Searcy. All rights reserved.
//

import Foundation
import SpriteKit

class CSWallGenerator: SKSpriteNode {
	
	
	var generationTimer: NSTimer?
	
	func startGeneratingWallsEvery(seconds: NSTimeInterval) {
		
		generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
		
	}
	
	func generateWall() {
		
		
		
	}
}