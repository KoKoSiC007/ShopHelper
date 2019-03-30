//
//  ViewController.swift
//  ShopHelper
//
//  Created by Grisha Okin on 27/03/2019.
//  Copyright © 2019 Grisha Okin. All rights reserved.
//

import UIKit
import SwiftyJSON

class FBI: UIButton {
	
}

class Authorization: UIViewController {
	
	var loginS:String = ""
	var passwordS:String = ""
	var people:Person?
	var byeList:[Product]?
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
		NetConnection.getConnection(param: ["do":"login","login":loginS, "password":passwordS], callback: updatePeople(_:))
		
	}
	
	func loadingList(_ distJson: JSON?){
		guard let json = distJson else {
			print("пустой Json")
			return
		}
		var listOfPurchase = [Product]()
		let products = json.arrayValue
		for item in products{
			let id = item["id"].stringValue
			let name = item["name"].stringValue
			let purchase = Product(id: id, name: name)
			listOfPurchase.append(purchase)
		}
		byeList = listOfPurchase
		performSegue(withIdentifier: "toView", sender: self)
	}
	
	
	func updatePeople(_ distJson: JSON?) {
		guard let json = distJson else {
			let alertController = UIAlertController(title: "Alert", message: "Такой пользователь не найден попробуйте еще раз.", preferredStyle: .alert)
			let action1 = UIAlertAction(title: "okey", style: .default)
			alertController.addAction(action1)
			self.present(alertController, animated: true, completion: nil)
			return
		}
		
		let people = json.arrayValue
		for person in people {
			let login = person["login"].stringValue
			let name = person["name"].stringValue
			let surname = person["surname"].stringValue
			let id = person["id"].stringValue
			let person = Person(login: login, name: name, surname: surname, id: id)
			self.people = person
		}
		guard let id = self.people?.id else{
			print("error with id ")
			return
		}
		NetConnection.getConnection(param: ["do":"idlist","uid":id], callback: loadingList(_:))
		}
		
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if case segue.identifier = "toView" {
			let distVC: ViewController = segue.destination as! ViewController
			distVC.people = people
			distVC.byeList = byeList
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	
}

