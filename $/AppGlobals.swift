//
//  Globals.swift
//  $
//
//  Created by Andrew on 6/14/16.
//
//

import Foundation
import CoreData

let defaults = NSUserDefaults.standardUserDefaults()
/*var earned = defaults.floatForKey("Earned")
var spent = defaults.floatForKey("Spent")
var total = defaults.floatForKey("Earned") - defaults.floatForKey("Spent")

var earnLabel = defaults.stringForKey("eLabel")
var spendLabel = defaults.stringForKey("sLabel")
var totalsLabel = defaults.stringForKey("tLabel")*/

var sum = 0 as Float
var green = 0 as Float
var red = 0 as Float

var currDate = NSDate()
var seedDate = "" as String

var addOrSubtractOption = ["Add", "Subtract"]
var subtractTypeOptions = defaults.arrayForKey("SpendType")