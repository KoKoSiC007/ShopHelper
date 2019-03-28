//
//  Person.swift
//  ShopHelper
//
//  Created by Grisha Okin on 27/03/2019.
//  Copyright © 2019 Grisha Okin. All rights reserved.
//

import Foundation

struct Person {
	var Discription : String{
		get {
			return "Name: \(name) aka \(login) "
		}
	}
	
	init(login: String,name: String, surname: String, id: String) {
		self.login = login
		self.name = name
		self.surname = surname
		self.id = id
	}
	var id:String
	var login:String
	var name:String
	var surname:String
	var list:[Any?]?
}
