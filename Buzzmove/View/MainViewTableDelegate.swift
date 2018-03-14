//
//  MainViewTableDelegate.swift
//  Buzzmove
//
//  Created by Riccardo Rizzo on 13/03/18.
//  Copyright © 2018 Riccardo Rizzo. All rights reserved.
//

import UIKit
import MapKit

extension MainViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard self.places.count > 0 else { return UITableViewCell() }
        
        let cell = placeTableView.dequeueReusableCell(withIdentifier: "PlaceItemCell") as! PlaceViewCell
        
        let item = self.places[indexPath.row]

        cell.lblName.text = item.Name
        cell.lblAddress.text = item.Street
        cell.lblType.text = item.Types
        cell.imgIcon.loadImage(withUrl: item.Icon)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRow = self.places.count
        
        if numberOfRow > 0 {
            self.placeTableView.backgroundView = nil
            self.placeTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            return numberOfRow
        }
        else {
            setMessageOnTableView("No data is currently available. Please enter a text in the Search field.", toTableView: placeTableView)
            return 0
        }
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let item = self.places[indexPath.row]
        //addAnnotation(place: item, id: indexPath.row)
        zoomOnCoordinate(withCoordinate: CLLocationCoordinate2D(latitude: item.Latitude,longitude: item.Longitude))
    }
    
    func setMessageOnTableView(_ message: String, toTableView tableview: UITableView) {
        
        DispatchQueue.main.async() {
            
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height:  self.view.bounds.size.height))
            messageLabel.text = message
            messageLabel.textColor = UIColor.black
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = NSTextAlignment.center;
            messageLabel.font = UIFont(name: "Palatino-Italic", size: 20)
            messageLabel.sizeToFit()
            
            tableview.backgroundView = messageLabel
            tableview.separatorStyle = UITableViewCellSeparatorStyle.none
        }
    }
}

