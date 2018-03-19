//
//  GooglePlacesApi.swift
//
//  Created by Riccardo Rizzo on 14/03/18.
//  Copyright © 2017 Riccardo Rizzo. All rights reserved.
//

import Foundation
import MapKit

// GooglePlacesAPI Error case.
// At this moment we control only the Google Developer Key to use the Places API
public enum GooglePlaceApiError: Error {
    case NoGooglePlacesKey
}

// This class make a request to the Google Services API
// It check if the Data is good for the parsing or return an error if any
public class GooglePlacesApi {
    
    let network = NetworkRequest()
    
    public func fetchData(withCoordinate position:CLLocation, radius: Int, searchFor: String,  completition: @escaping ([Any]?, NetworkError) -> ()) throws {
        
        guard BaseApiConstant.kGoogleKey != "" else {
            throw GooglePlaceApiError.NoGooglePlacesKey
        }
        
        let location = "location=\(position.coordinate.latitude),\(position.coordinate.longitude)"
        let radius = "&radius=\(radius)"
        let type = "&keyword=" + searchFor
        let googleKey = "&key=" + BaseApiConstant.kGoogleKey
        let apiUrl = BaseApiConstant.kBaseUrlApi + location + radius + type + googleKey
        
        network.makeNetworkRequest(apiUrl) { (resultData, error) in
            switch(error) {
                case .None:
                    if let objects = resultData!["results"] as? [Any] {
                        completition(objects,error)
                    }
                default:
                    completition(nil,error)
            }
        }
    }
}
