//
//  MapViewController.swift
//  ShopHelper
//
//  Created by Grisha Okin on 27/03/2019.
//  Copyright © 2019 Grisha Okin. All rights reserved.
//

import UIKit
import NMAKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
	
	
	var people:Person?
	var byeList:[Product]?
	
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
	
	
	var currentZoom = 13.2
	let locationManager = CLLocationManager()
	var latitude:Double = 0.0
	var longitude:Double = 0.0
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
		print("locations = \(type(of:locValue.latitude)) \(locValue.longitude)")
		latitude = locValue.latitude
		longitude = locValue.longitude
	}

	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.locationManager.requestAlwaysAuthorization()
		
		// For use in foreground
		self.locationManager.requestWhenInUseAuthorization()
		
		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
			locationManager.startUpdatingLocation()
		}
		
		map.gestureDelegate = self
		map.useHighResolutionMap = true
		map.zoomLevel = Float(currentZoom)
		print(locationManager.location?.coordinate.latitude)
		map.set(geoCenter: NMAGeoCoordinates(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!),animation: .linear)
		map.copyrightLogoPosition = .center
		// Set zoom level
		map.zoomLevel = NMAMapViewMaximumZoomLevel - 1
		// Subscribe to position updates
		//		NotificationCenter.default.addObserver(self,
		//											   selector: #selector(MapViewController.didUpdatePosition),
		//											   name: NSNotification.Name.NMAPositioningManagerDidUpdatePosition,
		//											   object: NMAPositioningManager.shared())
		
		self.map.positionIndicator.isVisible = true
		let position = NMAPositioningManager.shared()
 		print(position.currentPosition)
		
	}
	func mapViewDidReceiveTap(_ map: NMAMapView, at location: CGPoint){
		currentZoom -= 1
		map.set(zoomLevel: Float(currentZoom), animation: .linear)
		print("tap")
	}
	
	@objc func didUpdatePosition() {
		guard let position = NMAPositioningManager.shared().currentPosition else {
			print("Не удалось получить позицию")
			return
		}
		let coordinates = position.coordinates
		// Update label text based on received position.
		var text = "Coordinate: \(coordinates.latitude), \(coordinates.longitude)\n"
		print(text)
		// Update position indicator position.
//		map.set(geoCenter: coordinates, animation: .linear)
	}
	
}
extension MapViewController: NMAMapGestureDelegate{
}
