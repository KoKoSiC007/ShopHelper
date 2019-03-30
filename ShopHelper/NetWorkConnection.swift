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
	
	
	
	static func getConnection(param: Parameters, callback: @escaping (JSON?)->Void){
		let globalURL = "http://37.21.54.126/iosjson"
		let localURL = "http://192.168.0.106/json"
		guard let url = URL(string: globalURL) else {
			print("Url error")
			return
		}
		
		AF.request(url, method: .post, parameters: param).validate().responseJSON(completionHandler: {response in
			switch response.result {
			case .success( let data):
				let json = JSON(data)
//				print(json)
				callback(json)
			case .failure(let error):
				print("Downlouding error")
				callback(nil)
			}
		})
		
	}
	
	static func post(param: Parameters){
		let globalURL = "http://37.21.54.126/iosjson"
		let localURL = "http://192.168.0.106/json"
		guard let url = URL(string: globalURL) else {
			print("Url error")
			return
		}
		AF.request(url, method: .post, parameters: param)
	}
	
	static func rest(url:String, callback: @escaping (JSON?) -> Void){
		AF.request(url).validate().responseJSON(completionHandler: {response in
			switch response.result{
			case .success(let data):
				let json = JSON(data)
//				print(json)
				callback(json)
			case .failure(_):
				print("Downlouding Error")
			}
		})
	}
	
}
