//
//  MapViewController.swift
//  ShopHelper
//
//  Created by Grisha Okin on 27/03/2019.
//  Copyright © 2019 Grisha Okin. All rights reserved.
//

import UIKit
import NMAKit

class MapViewController: UIViewController {
	
	@IBOutlet weak var nav: UINavigationBar!
	@IBAction func back(_ sender: UIButton) {
		performSegue(withIdentifier: "fromMapToView", sender: self)
	}
	
	 @IBOutlet weak var map:NMAMapView!
	
	
	var currentZoom = 13.2
	
	func mapSetup(){
		
		map.gestureDelegate = self
		map.useHighResolutionMap = true
		map.zoomLevel = Float(currentZoom)
		map.set(geoCenter: NMAGeoCoordinates(latitude: 55.740869, longitude: 37.545358),
				animation: .linear)
		map.copyrightLogoPosition = .center
		// Set zoom level
		map.zoomLevel = NMAMapViewMaximumZoomLevel - 1
		// Subscribe to position updates
		NotificationCenter.default.addObserver(self,
											   selector: #selector(MapViewController.didUpdatePosition),
											   name: NSNotification.Name.NMAPositioningManagerDidUpdatePosition,
											   object: NMAPositioningManager.shared())
		
		self.map.positionIndicator.isVisible = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		mapSetup()
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
