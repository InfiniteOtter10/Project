extends Node

var Slot1 = { preis = 0,
				Art = "",
				Teil1 = "",
				Teil2 = "",
				Teil3 = "" }

var Slot2 = { preis = 0,
				Art = "",
				Teil1 = "",
				Teil2 = "",
				Teil3 = "" }

var Slot3 = { preis = 0,
				Art = "",
				Teil1 = "",
				Teil2 = "",
				Teil3 = "" }

var matrix
var Teile = [[[0,0,0,0,0],
			  [0,0,0,0,0],
			  [0,0,0,0,0],
			  [0,0,0,0,0],
			  [0,0,0,0,0]],[[0,0,0,0,0],
							[0,0,0,0,0],
							[0,0,0,0,0],
							[0,0,0,0,0],
							[0,0,0,0,0]]]

var Money = 3000

var state = "shop"
var StatsHidden = 1
var shopSequence = 0
