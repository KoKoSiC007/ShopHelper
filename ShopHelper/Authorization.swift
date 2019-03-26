//
//  ViewController.swift
//  ShopHelper
//
//  Created by Grisha Okin on 27/03/2019.
//  Copyright © 2019 Grisha Okin. All rights reserved.
//

import UIKit
import SwiftyJSON


class Authorization: UIViewController {

	var loginS:String = ""
	var passwordS:String = ""
	var people:Person?

	@IBOutlet weak var login: UILabel!
	@IBOutlet weak var fieldLogin: UITextField!
	@IBOutlet weak var password: UILabel!
	@IBOutlet weak var fieldPassword: UITextField!
	@IBAction func FBI(_ sender: UIButton) {
		
		guard let log = fieldLogin.text else {
			loginS = ""
			return
		}
		loginS = log
		guard let pass = fieldPassword.text else {
			passwordS = ""
			return
		}
		passwordS = pass
		NetConnection.getConnection(param: ["login":loginS, "password":passwordS], callback: updatePeople(_:))
	}
	
	func updatePeople(_ json: Data?) {
		guard let json = json else {
			print("Ошибка при выполнении запроса")
			return
		}
		
//		let people = json.arrayValue
//		print(people[0]["id"])
//		for person in people {
//			let login = person["login"].stringValue
//			let password = person["password"].stringValue
//			let name = person["name"].stringValue
//			print(type(of: person["json"]))
//			let list = person["json"].stringValue
//
//			let person = Person(login: login, password: password, name: name, list:list)
//			self.people = person
//		}
		performSegue(withIdentifier: "toAccaunt", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if case segue.identifier = "toAccaunt" {
			let distVC: ViewController = segue.destination as! ViewController
			distVC.people = people
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}


}

