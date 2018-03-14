//
//  PlacesController.swift
//  Buzzmove
//
//  Created by Riccardo Rizzo on 13/03/18.
//  Copyright © 2018 Riccardo Rizzo. All rights reserved.
//

import Foundation
import MapKit

// Place Controller
// This Class load the data from the Google API
// and create an array of object
// When the loading is finished it make a call to the delegate

enum PlacesControllerError: Error {
    case noDelegateSet
}

protocol PlaceProtocolDelegate {
    func dataUpdated(withData places:[Place], networkError: NetworkError)
}

class PlacesController {
    
    private let api = GooglePlacesApi()
    var delegate:PlaceProtocolDelegate? = nil
    
    func loadData(searchFor searchTerm:String) throws {
        var places = [Place]()
        
        guard delegate != nil else {
            throw PlacesControllerError.noDelegateSet
        }
        
        if let coord = LocationService.sharedInstance.currentLocation {
            do {
                try api.fetchData(withCoordinate: coord, radius: 1000, searchFor: searchTerm) { (Data, NetworkError) in
                    if let data = Data {
                        for place in data {
                            let _place = (place as? [String: Any])
                            let _currentPlace = Place()
                            
                            if let vicinity = _place!["vicinity"] as? String {
                                _currentPlace.Street = vicinity
                            }
                            if let geometry = _place!["geometry"] as? [String:Any] {
                                if let location = geometry["location"] as? [String:Any] {
                                    if let lat = location["lat"] as? Double {
                                        if let lon = location["lng"] as? Double {
                                            _currentPlace.Latitude = lat
                                            _currentPlace.Longitude = lon
                                        }
                                    }
                                }
                            }
                            
                            if let icon = _place!["icon"] as? String {
                                _currentPlace.Icon = icon
                            }
                            if let name = _place!["name"] as? String {
                                _currentPlace.Name = name
                            }
                            if let types = _place!["types"] as? [String] {
                                _currentPlace.Types = types.joined(separator: ",")
                            }
                            
                            places.append(_currentPlace)
                        }
                    }
                    self.delegate?.dataUpdated(withData: places, networkError: NetworkError)
                }
            }
            catch let error as GooglePlaceApiError {
                print(error)
            }
            catch {
                print("Something went wrong with Place Controller")
            }
        }
    }
}
