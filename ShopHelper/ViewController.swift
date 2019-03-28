//
//  ViewController.swift
//  ShopHelper
//
//  Created by Grisha Okin on 27/03/2019.
//  Copyright © 2019 Grisha Okin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var people:Person?
	var byeList:[Product]?
	
	@IBAction func exit(_ sender: Any) {
		performSegue(withIdentifier: "toAuthorization", sender: self)
	}
	@IBAction func toMap(_ sender: Any) {
		performSegue(withIdentifier: "toMap", sender: self)
	}
	@IBAction func toAccaunt(_ sender: Any) {
		performSegue(withIdentifier: "toAccount", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if case segue.identifier = "toAccount" {
			let distVC: AccountViewController = segue.destination as! AccountViewController
			distVC.people = people
			distVC.data = byeList
		}
		if case segue.identifier = "toMap" {
			let distVC: MapViewController = segue.destination as! MapViewController
			distVC.people = people
			distVC.byeList = byeList
		}
	}
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
