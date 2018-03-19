//
//  MainViewMapDelegate.swift
//  GooglePlacesSwift
//
//  Created by Riccardo Rizzo on 13/03/18.
//  Copyright © 2018 Riccardo Rizzo. All rights reserved.
//

import Foundation
import MapKit

extension MainViewController:MKMapViewDelegate {
    
    func setPlacesOnMap(_ places:[Place]) {
        DispatchQueue.main.async {
            self.clearAnnotations()
            for (index,place) in places.enumerated() {
                self.addAnnotation(place: place, id: index)
            }
            
            if places.count > 0 {
                let place = places.first!
                self.zoomOnCoordinate(withCoordinate: CLLocationCoordinate2D(latitude: place.Latitude,longitude: place.Longitude))
            }
        }
    }
    
    func clearAnnotations() {
        let annotationsToRemove = self.mapView.annotations.filter { $0 !== self.mapView.userLocation }
        self.mapView.removeAnnotations( annotationsToRemove )
    }
    
    func zoomOnCoordinate(withCoordinate coordinate:CLLocationCoordinate2D) {
        
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let coord = CLLocation(latitude: latitude, longitude: longitude)
        let viewRegion = MKCoordinateRegionMakeWithDistance(coord.coordinate, 400, 400)
        self.mapView.setRegion(viewRegion, animated: false)
    }
    
    func addAnnotation(place: Place, id: Int){
        
        let coord = CLLocation(latitude: place.Latitude, longitude: place.Longitude)

        let request = NSMutableURLRequest(url: URL(string: place.Icon)!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error == nil {
                
                let anno = PlaceCustomAnnotation()
                anno.coordinate = coord.coordinate
                anno.imageName = UIImage(data: data!, scale: UIScreen.main.scale / 1.5)
                anno.title = place.Name
                anno.id = id
                let pinAnnotationView = MKPinAnnotationView(annotation: anno, reuseIdentifier: "pin")
                
                DispatchQueue.main.async {
                    self.mapView.addAnnotation(pinAnnotationView.annotation!)
                }
            }
        }
        dataTask.resume()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard !(view.annotation is MKUserLocation) else { return }
        
        if let annotation = view.annotation as? PlaceCustomAnnotation {
           let placeId = annotation.id
           let selectedPlace = self.places[placeId]
            showDetailViewController(forPlace: selectedPlace)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil;
        }
        else {
            let reuseIdentifier = "pin"
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            if let anno:PlaceCustomAnnotation = annotation as? PlaceCustomAnnotation {
                annotationView.canShowCallout = true
                annotationView.annotation = annotation
                annotationView.image = anno.imageName
            }
            return annotationView
        }
    }
}
