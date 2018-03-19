//
//  PersistentDataTest.swift
//  BuzzmoveTests
//
//  Created by Riccardo Rizzo on 14/03/18.
//  Copyright © 2018 Riccardo Rizzo. All rights reserved.
//

import XCTest
import Foundation
import UIKit
@testable import GooglePlacesSwift

class PersistentDataTest: XCTestCase {
    var places = [Place]()
    
    override func setUp() {
        super.setUp()
        for i in 0...10 {
            let place = Place()
            place.Name = "\(i)"
            place.Latitude = Double(i)
            place.Longitude = Double(i)
            place.Icon = "https://devimages-cdn.apple.com/assets/elements/icons/swift/swift-64x64_2x.png"
            
            self.places.append(place)
        }
    }

    func testSavedData() {
       
        let count = self.places.count
        PersistentDataManager.sharedInstance.savePlaces(with: self.places)
        
        if let readedData = PersistentDataManager.sharedInstance.loadPlaces() {
            if readedData.count != count {
                XCTFail("Wrong number of saved data")
            }
            if self.places.first?.Name != readedData.first?.Name {
                XCTFail("Data was not loaded successfully")
            }
        }
        
        
    }
    
}
