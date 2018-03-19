//
//  BuzzmoveTests.swift
//  BuzzmoveTests
//
//  Created by Riccardo Rizzo on 13/03/18.
//  Copyright © 2018 Riccardo Rizzo. All rights reserved.
//

import XCTest
import Foundation
import UIKit
@testable import GooglePlacesSwift

class DataTests: XCTestCase {
    var places = [Place]()
    
    override func setUp() {
        super.setUp()
        
        for i in 0..<10 {
            let place = Place()
            place.Name = "\(i)"
            place.Latitude = Double(i)
            place.Longitude = Double(i)
            place.Icon = "https://devimages-cdn.apple.com/assets/elements/icons/swift/swift-64x64_2x.png"
            
            self.places.append(place)
        }
    }
    
    func testData() {
        if places.count != 10 {
            XCTFail("Wrong number of Places")
        }
        if let place = places.first {
            if place.Name != "0" {
                XCTFail("Pleace check the first place name")
            }
        }
    }
}
