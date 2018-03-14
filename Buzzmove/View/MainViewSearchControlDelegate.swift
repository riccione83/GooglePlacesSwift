//
//  MainViewSearchControlDelegate.swift
//  Buzzmove
//
//  Created by Riccardo Rizzo on 13/03/18.
//  Copyright © 2018 Riccardo Rizzo. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
        
        if searchBar.text!.count > 0 {
            if let textToSearch = searchBar.text?.lowercased() {
                PersistentDataManager.sharedInstance.saveSearchString(theString: textToSearch)
                self.setMessageOnTableView("Wait...", toTableView: self.placeTableView)
                try! placeController.loadData(searchFor: textToSearch)
            }
        }
        else {
            self.places = [Place]()
            PersistentDataManager.sharedInstance.savePlaces(with: self.places)
            self.searchBarEndOfSearch(self.searchComponent)
            self.placeTableView.reloadData()
            self.clearAnnotations()
        }
    }
    
    func searchBarEndOfSearch(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

