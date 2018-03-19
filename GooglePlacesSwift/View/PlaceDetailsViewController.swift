//
//  PlaceDetailsViewController.swift
//  GooglePlacesSwift
//
//  Created by Riccardo Rizzo on 13/03/18.
//  Copyright © 2018 Riccardo Rizzo. All rights reserved.
//

import UIKit

class PlaceDetailsViewController: UIViewController {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblType: UIPickerView!
    @IBOutlet var imgIcon: UIImageView!
    
    private var types = [String]()
    var currentPlace:Place? = nil
    
    var typesOfCurrentPlace = [String]()
    
    func initUI() {
        navigationController?.isNavigationBarHidden = false
        self.lblType.delegate = self
        self.lblType.dataSource = self

        lblName.text = currentPlace?.Name
        lblAddress.text = currentPlace?.Street
        imgIcon.loadImage(withUrl: (currentPlace?.Icon)!)
        typesOfCurrentPlace = (currentPlace?.Types.components(separatedBy: ","))!
        typesOfCurrentPlace.insert("Types:", at: 0)
        self.lblType.reloadAllComponents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
}
