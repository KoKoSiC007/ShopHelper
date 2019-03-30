//
//  MapViewController.swift
//  ShopHelper
//
//  Created by Grisha Okin on 27/03/2019.
//  Copyright © 2019 Grisha Okin. All rights reserved.
//

import UIKit
import NMAKit
import Darwin
import SwiftyJSON
var shops:[Shop] = [Shop(name: "NZ", latitude: 55.738529, longitude: 37.545843),Shop(name: "Вкус Вилл", latitude: 55.738860, longitude: 37.547116), Shop(name: "Магнолия", latitude: 55.739177, longitude: 37.548345),Shop(name: "Пятерочка", latitude: 55.740937, longitude: 37.552659),
					Shop(name: "Пятерочка", latitude: 55.789948, longitude: 37.599965), Shop(name: "Перекресток", latitude: 55.789160, longitude: 37.599907)]



class MapViewController: UIViewController {
	var flag = true
	var date = Date()
	var coreRoute: NMARouteManager?
	var mapRouts = [NMAMapRoute]()
	var location:Location = Location(latitude: 0.0, longitude: 0.0)
	var people:Person?
	var byeList:[Product]?
	var currentZoom = 13.2
	@IBOutlet weak var nav: UINavigationBar!
	@IBAction func back(_ sender: UIButton) {
		performSegue(withIdentifier: "fromMapToView", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if case segue.identifier = "fromMapToView" {
			let distVC: ViewController = segue.destination as! ViewController
			distVC.people = people
			distVC.byeList = byeList
		}
	}
	@IBOutlet weak var map:NMAMapView!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		map.gestureDelegate = self
		map.useHighResolutionMap = true
		map.mapScheme = NMAMapSchemeNormalNight
		map.zoomLevel = 15
		map.positionIndicator.isVisible = true
		NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.positionDidUpdate), name: NSNotification.Name.NMAPositioningManagerDidUpdatePosition, object: NMAPositioningManager.shared())
		map.set(geoCenter: NMAGeoCoordinates(latitude: 55.78816073221901, longitude: 37.595285246085005), animation: .linear)
		
		NetConnection.rest(url: "https://places.demo.api.here.com/places/v1/discover/explore?in=55.7501%2C37.6252%3Br%3D16000&cat=food-drink%2Cshops&tf=html&X-Mobility-Mode=none&Accept-Language=ru&app_id=0tcDInPDhVWb6ROpa5ry&app_code=hdiWUWqXQa9RmLMf670r_Q", callback: parse(_:))
	}
	
	func parse(_ distJson: JSON?){

		guard let json = distJson else {
			print("Пустой Json")
			return
		}
//		print(json)
		var data = json.arrayValue
		print(data)
		
		for i in 0...20{
			shops.append(Shop(name: json["results"]["items"][i]["title"].stringValue, latitude: json["results"]["items"][i]["position"][0].doubleValue, longitude: json["results"]["items"][i]["position"][1].doubleValue))
		}
		
	}
	
	func addMarker(shop: Shop){
		let image = UIImage(named: "marker.png")
		let marker = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: shop.geoLock.latitude, longitude: shop.geoLock.longitude), image: image)
		marker.textDescription = shop.name
		map.add(marker)
	}
	
	
	@objc func positionDidUpdate(){
		if let p = NMAPositioningManager.shared().currentPosition {
//			map.set(geoCenter: p.coordinates, animation: .linear)
			location.longitude = p.coordinates.longitude
			location.latitude = p.coordinates.latitude
			print("\(p.coordinates.latitude) \(p.coordinates.longitude)")
			var minLength: Double = measure(lat1: location.latitude, lon1: location.longitude, lat2: shops[0].geoLock.latitude, lon2: shops[0].geoLock.longitude)
			var minName: String = shops[0].name
			var minLat: Double
			var minLong: Double
			for path in shops{
				if minLength >= measure(lat1: location.latitude, lon1: location.longitude, lat2: path.geoLock.latitude, lon2: path.geoLock.longitude){
					minLength = measure(lat1: location.latitude, lon1: location.longitude, lat2: path.geoLock.latitude, lon2: path.geoLock.longitude)
					minName = path.name
					minLat = path.geoLock.latitude
					minLong = path.geoLock.longitude
				}
			}
			
//			print("Ближайший магазин(\(minName)) находится в \(minLength) метрах")
			var finish = Date()
			var executionTime = finish.timeIntervalSince(date)
			print("time execute: \(executionTime)")
			guard let data = byeList else{
				if flag {
					flag = !flag
					let alertController = UIAlertController(title: "Упс", message: "Похоже у вас нет запланированых покупок.", preferredStyle: .alert)
					let action1 = UIAlertAction(title: "okey", style: .default)
					alertController.addAction(action1)
					self.present(alertController, animated: true, completion: nil)
					for shop in shops {
						addMarker(shop: shop)
					}
				}
				return
			}
			
			if flag {
				flag = !flag
				let alertController = UIAlertController(title: "Упс", message: "Ближайший магазин \(minName) находится в \(Int(minLength)) метрах от вас.", preferredStyle: .alert)
				let action1 = UIAlertAction(title: "okey", style: .default)
				alertController.addAction(action1)
				self.present(alertController, animated: true, completion: nil)
			}
			
		}
	}
	
	@objc func didLosePosition(){
		print("Position lost")
	}
	//Проревод расстояния двух меток в метры
	func measure(lat1:Double, lon1:Double, lat2:Double, lon2:Double)-> Double{  // generally used geo measurement function
		let R = 6378.137; // Radius of earth in KM
		let dLat = lat2 * Double.pi / 180 - lat1 * Double.pi / 180;
		let dLon = lon2 * Double.pi / 180 - lon1 * Double.pi / 180;
		let a = sin(dLat/2) * sin(dLat/2) +
			cos(lat1 * Double.pi / 180) * cos(lat2 * Double.pi / 180) *
			sin(dLon/2) * sin(dLon/2);
		let c = 2 * atan2(sqrt(a), sqrt(1-a));
		let d = R * c;
		return d * 1000; // meters
	}
	
	
}
extension MapViewController: NMAMapGestureDelegate{
}
