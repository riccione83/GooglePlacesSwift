//
//  Place.swift
//  GooglePlacesSwift
//
//  Created by Riccardo Rizzo on 13/03/18.
//  Copyright © 2018 Riccardo Rizzo. All rights reserved.
//

import Foundation
import UIKit

class Place: NSObject, NSCoding  {
    var Name:String
    var Latitude:Double
    var Longitude:Double
    var Icon:String
    var Types:String
    var Street:String
    
    
    override init() {
        self.Latitude = 0.0
        self.Longitude = 0.0
        self.Name = ""
        self.Icon = ""
        self.Types = ""
        self.Street = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.Latitude = aDecoder.decodeDouble(forKey: "com.place.latitude")
        self.Longitude = aDecoder.decodeDouble(forKey: "com.place.longitude")
        self.Name = aDecoder.decodeObject(forKey: "com.place.name") as? String ?? ""
        self.Icon = aDecoder.decodeObject(forKey: "com.place.icon") as? String ?? ""
        self.Types = aDecoder.decodeObject(forKey: "com.place.types") as? String ?? ""
        self.Street = aDecoder.decodeObject(forKey: "com.place.street") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Latitude, forKey: "com.place.latitude")
        aCoder.encode(Longitude, forKey: "com.place.longitude")
        aCoder.encode(Name, forKey: "com.place.name")
        aCoder.encode(Icon, forKey: "com.place.icon")
        aCoder.encode(Types, forKey: "com.place.types")
        aCoder.encode(Street, forKey: "com.place.street")
    }
}
