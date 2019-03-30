//
//  Shop.swift
//  ShopHelper
//
//  Created by Grisha Okin on 29/03/2019.
//  Copyright © 2019 Grisha Okin. All rights reserved.
//

import Foundation
//Структура одного магазина
struct Shop {
	var	name:String
	var geoLock: Location
	
	init(name: String, latitude: Double, longitude:Double) {
		self.name = name
		self.geoLock = Location(latitude: latitude, longitude: longitude)
	}
}
