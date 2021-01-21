//
//  SearchLocationVC.swift
//  AllDemo
//
//  Created by NgocNB on 1/9/21.
//

import UIKit
import MapKit
import CoreLocation

class SearchLocationVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var resultSearchController: UISearchController? = nil
    var selectedPin: MKPlacemark? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        setupSearch()
    }
    
    func setupSearch() {
        if #available(iOS 13.0, *) {
            let locationSearchTable = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LocationSearchTable") as! LocationSearchTable
            resultSearchController = UISearchController(searchResultsController: locationSearchTable)
            resultSearchController?.searchResultsUpdater = locationSearchTable
            
            let searchBar = resultSearchController!.searchBar
            searchBar.sizeToFit()
            searchBar.placeholder = "Search for places"
            navigationItem.searchController = resultSearchController
            resultSearchController?.hidesNavigationBarDuringPresentation = false
            resultSearchController?.dimsBackgroundDuringPresentation = true
            definesPresentationContext = true
            locationSearchTable.mapView = mapView
            locationSearchTable.handleMapSearchDelegate = self
        } else {
            // Fallback on earlier versions
        }
    }

}

extension SearchLocationVC: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "(city) (state)"
        }
        mapView.addAnnotation(annotation)
        let span = MapKit.MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

extension SearchLocationVC: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.first {
            print("location:: \(location)")
            let span = MapKit.MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }

    }

}

// ========== ========== ========== ========== ========== ==========

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}


class LocationSearchTable : UITableViewController {
    var handleMapSearchDelegate:HandleMapSearch? = nil
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    
}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}


extension LocationSearchTable {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        let address = "\(selectedItem.thoroughfare ?? ""), \(selectedItem.locality ?? ""), \(selectedItem.subLocality ?? ""), \(selectedItem.administrativeArea ?? ""), \(selectedItem.postalCode ?? ""), \(selectedItem.country ?? "")"
        cell.detailTextLabel?.text = address
        return cell
    }
}

extension LocationSearchTable {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
}
