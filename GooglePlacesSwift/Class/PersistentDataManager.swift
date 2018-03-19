//
//  PersistentDataManager.swift
//  GooglePlacesSwift
//
//  Created by Riccardo Rizzo on 13/03/18.
//  Copyright © 2018 Riccardo Rizzo. All rights reserved.
//

import Foundation

// Persistent Data Class
// Used to store and load data from persistent file
// At this moment I use only NSDefault storage because low amount of data
//

class PersistentDataManager: NSObject {
    
    let defaults = UserDefaults.standard
    
    static let sharedInstance: PersistentDataManager = {
        let instance = PersistentDataManager()
        return instance
    }()
    
    func saveSearchString(theString str:String) {
        defaults.set(str, forKey: BaseApiConstant.kLastWordSearched)
    }
    
    func loadSearchString() -> String? {
        if let searchTerm = defaults.object(forKey: BaseApiConstant.kLastWordSearched) as? String {
            return searchTerm
        }
        return nil
    }
    
    func savePlaces(with places:[Place]){
        let _places = places
        let placesData = NSKeyedArchiver.archivedData(withRootObject: _places)
        UserDefaults.standard.set(placesData, forKey: "places")
    }
    
    func loadPlaces() -> [Place]?{
        let placesData = UserDefaults.standard.object(forKey: "places") as? NSData
        
        if let placesData = placesData {
            let placesArray = NSKeyedUnarchiver.unarchiveObject(with: placesData as Data) as? [Place]
            
            if let placesArray = placesArray {
                return placesArray
            }
        }
        return nil
    }
}
