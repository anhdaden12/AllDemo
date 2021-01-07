//
//  PinlocationMapVC.swift
//  AllDemo
//
//  Created by NgocNB on 1/7/21.
//

import UIKit
import MapKit

class PinlocationMapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .mutedStandard
        mapView.delegate = self
        let center1 = CLLocationCoordinate2D(latitude: 20.9773, longitude: 105.822)
        let center4 = CLLocationCoordinate2D(latitude: 21.007, longitude: 105.83)
        let center2 = CLLocationCoordinate2D(latitude: 21.0152, longitude: 105.893)
        let center3 = CLLocationCoordinate2D(latitude: 21.0114, longitude: 105.844)
        setPinUsingMKAnnotation(locations: [center1,center2,center3,center4])
    }
    
    func setPinUsingMKAnnotation(locations: [CLLocationCoordinate2D]) {
        var listPin: [MapPin] = []
        for location in locations {
            let pin1 = MapPin(title: "Lê Thái Tổ", locationName: "", coordinate: location)
            let coordinateRegion = MKCoordinateRegion(center: pin1.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
            mapView.setRegion(coordinateRegion, animated: true)
            listPin.append(pin1)
        }
       
       mapView.addAnnotations(listPin)
       mapView.fitAllAnnotations()
    }


}

extension PinlocationMapVC: MKMapViewDelegate {
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


class MapPin: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
    }
}

extension MKMapView {
    func fitAllAnnotations() {
        var zoomRect = MKMapRect.null
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.1, height: 0.1)
            zoomRect = zoomRect.union(pointRect)
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
    }
}
