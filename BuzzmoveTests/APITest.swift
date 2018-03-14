//
//  APITest.swift
//  BuzzmoveTests
//
//  Created by Riccardo Rizzo on 14/03/18.
//  Copyright © 2018 Riccardo Rizzo. All rights reserved.
//

import XCTest
import MapKit
@testable import Buzzmove

class APITest: XCTestCase {
    
    func testForValidGoogleKey() {
        if BaseApiConstant.kGoogleKey == "" {
            XCTFail("Plase insert a valid Google Key")
        }
    }
    
    func testGoogleAPI() {
        let _expectation = expectation(description: "GoogleAPITest")
        let gAPI = GooglePlacesApi()
        let location = CLLocation(latitude: 37.3202289, longitude: -122.0124255)
        
        gAPI.fetchData(withCoordinate: location, radius: 1000, searchFor: "restaurants") { (results, networkError) in
          switch networkError {
            case .None:
                if results!.count > 0 {
                    _expectation.fulfill()
                }
                else {
                    XCTFail("No data received")
                }
            default:
                XCTFail("API Request Error")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
