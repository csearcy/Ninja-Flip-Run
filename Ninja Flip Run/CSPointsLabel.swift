//
//  CSPointsLabel.swift
//  Ninja Flip Run
//
//  Created by Chris Searcy on 2/13/16.
//  Copyright © 2016 Chris Searcy. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class CSPointsLabel: SKLabelNode {
	
	var number = 0
	
	init(num: Int) {
		super.init()
		
		fontColor = UIColor.blackColor()
		fontName = "Helvetica"
		fontSize = 24
		
		number = num
		text = "\(num)"
		
		
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	func increment() {
		number++
		text = "\(number)"
	}
	
	func setTo(num: Int) {
		
		self.number = num
		text = "\(self.number)"
		
	}
	
}