//
//  SelectlocationVC.swift
//  AllDemo
//
//  Created by NgocNB on 1/21/21.
//

import UIKit
import MapKit


class SelectlocationVC: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(revealReagonDetailWithLonggeestureOnmap(sender:)))
        mapView.addGestureRecognizer(gesture)
    }

    @objc func revealReagonDetailWithLonggeestureOnmap(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began {return}
        let location = sender.location(in: mapView)
        let logCordinate = mapView.convert(location, toCoordinateFrom: mapView)
        convertLatLongToAddress(location: logCordinate)
        setPinUsingMKAnnotation(locations: [logCordinate])
    }
    
    func setPinUsingMKAnnotation(locations: [CLLocationCoordinate2D]) {
        var listPin: [MapPin] = []
        for location in locations {
            let pin1 = MapPin(title: "Lê Thái Tổ", locationName: "", coordinate: location)
            let coordinateRegion = MKCoordinateRegion(center: pin1.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(coordinateRegion, animated: true)
            listPin.append(pin1)
        }
       
       mapView.addAnnotations(listPin)
       mapView.fitAllAnnotations()
    }
    
    func convertLatLongToAddress(location: CLLocationCoordinate2D){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Location name
            if let locationName = placeMark.location {
                print(locationName)
            }
            // Street address
            if let street = placeMark.thoroughfare {
                print(street)
            }
            // City
            if let city = placeMark.locality {
                print(city)
            }
            // State
//            if let state = placemark.administrativeArea {
//                print(state)
//            }
            // Zip code
            if let zipCode = placeMark.postalCode {
                print(zipCode)
            }
            // Country
            if let country = placeMark.country {
                print(country)
            }
        })
        
    }
    
}

extension SelectlocationVC {
   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
   
      let Identifier = "Pin"
    let annotationView: MKAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: Identifier)

      annotationView.canShowCallout = true
      if annotation is MKUserLocation {
         return nil
      } else if annotation is MapPin {
         annotationView.image =  UIImage(named: "Pin")
         return annotationView
      } else {
         return nil
      }
   }

}
