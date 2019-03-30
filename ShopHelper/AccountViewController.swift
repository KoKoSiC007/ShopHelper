//
//  AccountViewController.swift
//  ShopHelper
//
//  Created by Grisha Okin on 27/03/2019.
//  Copyright © 2019 Grisha Okin. All rights reserved.
//

import UIKit
import SwiftyJSON

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
	
	var data:[Product]?
	
	//Функция определяющяя количество ячеек в таблице
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let mapItem = data else {
			return 0
		}
		return mapItem.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard var mapItem = data else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "noproducts", for: indexPath)
			cell.textLabel?.text = "Добавте что нибуть!"
			return cell
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath)
		cell.textLabel?.text = mapItem[indexPath.row].name
		return cell
	}
	// Анимация при нажатии на ячейку
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	//подключение удаления ячеек
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let index = indexPath.row
			guard let id = data?[index].id else{
				return
			}
			NetConnection.post(param: ["do":"deleteproduct","id":id])
			data?.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
	
	
	@IBOutlet weak var nav: UINavigationBar!
	@IBAction func back(_ sender: UIBarButtonItem) {
		performSegue(withIdentifier: "fromAccountToView", sender: self)
	}
	@IBAction func update(_ sender: UIBarButtonItem) {
		guard let idP = people?.id else {
			return
		}
		NetConnection.getConnection(param: ["do":"idlist","uid":idP], callback: loadingList(_:))
		tableView.reloadData()
	}
	@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var login: UILabel!
	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var addProduct: UITextField!
	@IBAction func add(_ sender: UIButton) {
		guard let text = addProduct.text else {
			return
		}
		if text == ""{
			return
		}
		print(text)
		data?.append(Product(name: text))
		addProduct.text = nil
		guard let idP = people?.id else {
			return
		}
		NetConnection.post(param: ["do":"addproduct","uid":idP, "name":text])
		NetConnection.getConnection(param: ["do":"idlist","uid":idP], callback: loadingList(_:))
		self.view.endEditing(true)
		tableView.reloadData()
	}
	var people:Person?
	var id:String?
	//Парсер данных которые отправил сервер
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
		data = listOfPurchase
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if case segue.identifier = "fromAccountToView" {
			let distVC: ViewController = segue.destination as! ViewController
			distVC.people = people
			distVC.byeList = data
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AccountViewController")
		tableView.dataSource = self
		tableView.allowsSelection = true
		tableView.delegate = self
		addProduct.delegate = self
		guard let human = people else {
			print("empty people")
			return
		}
		login.text = human.login
		name.text = human.name
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
