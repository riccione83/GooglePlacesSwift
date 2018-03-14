//
//  ViewController.swift
//  Buzzmove
//
//  Created by Riccardo Rizzo on 13/03/18.
//  Copyright © 2018 Riccardo Rizzo. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, PlaceProtocolDelegate, LocationManagerDelegate {
    
    @IBOutlet var searchComponent: UISearchBar!
    @IBOutlet var placeTableView: UITableView!
    @IBOutlet var mapView: MKMapView!
    
    var places = [Place]()
    let placeController = PlacesController()
    let locationServices = LocationService()
    
    func dataUpdated(withData places: [Place], networkError: NetworkError) {
        DispatchQueue.main.async {
            switch networkError {
            case .None:
                self.places = places
                PersistentDataManager.sharedInstance.savePlaces(with: self.places)
                self.searchBarEndOfSearch(self.searchComponent)
                self.placeTableView.reloadData()
                self.setPlacesOnMap(places)
            case .Error(let errorString):
                self.loadSavedPlaces(orPrintError: errorString)
            }
        }
    }
    
    func loadSavedPlaces(orPrintError errorString:String) {
        if let _places = PersistentDataManager.sharedInstance.loadPlaces(), self.places.count == 0{
            self.places = _places
            self.searchBarEndOfSearch(self.searchComponent)
            self.placeTableView.reloadData()
            self.setPlacesOnMap(places)
        }
        else {
            self.clearAnnotations()
            self.places.removeAll()
            self.placeTableView.reloadData()
            self.setMessageOnTableView(errorString, toTableView: self.placeTableView)
        }
    }
    
    
    func searchData(withTerm searchTerm:String) {
        try! placeController.loadData(searchFor: searchTerm)
    }
    
    internal func initUI() {
        
        searchComponent.placeholder = "Type a place to search"
        searchComponent.searchBarStyle = UISearchBarStyle.minimal
        searchComponent.tintColor            = UIColor.lightGray
        searchComponent.barTintColor         = UIColor.white
        searchComponent.delegate = self
        
        self.placeTableView.delegate = self
        self.placeTableView.dataSource = self
        self.placeTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
    
        setMessageOnTableView("Plase wait...", toTableView: self.placeTableView)
    }

    func tracingLocation(_ currentLocation: CLLocation) {
        LocationService.sharedInstance.delegate = nil
        if let searchTerm = PersistentDataManager.sharedInstance.loadSearchString() {
            self.searchComponent.text = searchTerm
            try! placeController.loadData(searchFor: searchTerm)
        }
    }
    
    func tracingLocationDidFailWithError(_ error: NSError) {
        if !LocationService.sharedInstance.isValid {
            setMessageOnTableView("Please enable Location Service on your Device.", toTableView: self.placeTableView)
        }
    }
    
    func showDetailViewController(forPlace place:Place) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "PlaceDetailsView") as! PlaceDetailsViewController
        detailViewController.currentPlace = place
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUI()
        placeController.delegate = self
        LocationService.sharedInstance.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
