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
	
	@IBAction func exit(_ sender: UIButton) {
		performSegue(withIdentifier: "toAothorization", sender: self)
	}
	@IBAction func toMap(_ sender: UIButton) {
	}
	@IBAction func toAccaunt(_ sender: Any) {
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
