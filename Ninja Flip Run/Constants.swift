//
//  Constants.swift
//  Ninja Flip Run
//
//  Created by Chris Searcy on 2/13/16.
//  Copyright © 2016 Chris Searcy. All rights reserved.
//

import Foundation
import UIKit

// Configuration
var kCSGroundHeight: CGFloat = 20

// Initial
let kDefaultXToMovePerSecond: CGFloat = 320.0

// Collsion Detection
let heroCategory: UInt32 = 0x1 << 0
let wallCategory: UInt32 = 0x1 << 1

// Game variables
let kNUMBER_OF_POINTS_PER_LEVEL = 5
let kLEVEL_GENERATION_TIMES: [NSTimeInterval] = [1.0, 0.8, 0.6, 0.4, 0.3]
