//
//  NetWorkConnection.swift
//  ShopHelper
//
//  Created by Grisha Okin on 27/03/2019.
//  Copyright © 2019 Grisha Okin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct NetConnection {
	
	static func getConnection(param: Parameters, callback: @escaping (Data?)->Void){
		let globalURL = "http://37.21.54.126/json"
		let localURL = "http://192.168.0.107/json"
		guard let url = URL(string: localURL) else {
			print("Url error")
			return
		}
		
		AF.request(url, method: .post, parameters: param).response(completionHandler: {(response) in
			guard let data = response.value else {
				print("Error downloading data")
				return
			}
			print(data)
			callback(data)
		})
		
	}
	
}
