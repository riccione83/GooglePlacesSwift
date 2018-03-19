//
//  UIImageExtensions.swift
//  Buzzmove
//
//  Created by Riccardo Rizzo on 13/03/18.
//  Copyright © 2018 Riccardo Rizzo. All rights reserved.
//

import UIKit

//
// This extension permit to load an Image via URL
//
extension UIImageView {
    
    public func loadImage(withUrl url:String) {
        if url != "" {
            imageFromServerURL(urlString: url)
        }
    }
    
    internal func imageFromServerURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                let animation = CATransition()
                animation.duration = 0.3
                animation.type = kCATransitionFade
                self.layer.add(animation, forKey: "ImageFade")
                self.image = image
            })
            
        }).resume()
    }
}


