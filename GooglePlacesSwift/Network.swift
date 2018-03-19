//
//  Network.swift
//
//  Created by Riccardo Rizzo on 14/03/18.
//  Copyright © 2017 Riccardo Rizzo. All rights reserved.
//

import Foundation

// The network error. We manage the error string
public enum NetworkError {
    case None
    case Error(description:String)
}

// This class is responsable to make a network request at Google Api Platform
// It return the raw data and/or the error message

public class NetworkRequest {
    
    private var networkError:NetworkError = .None
    
    public func makeNetworkRequest(_ url:String, completition: @escaping ([String:Any]?, NetworkError) -> ()) {
        if let usableUrl = URL(string: url) {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                if error != nil {
                    self.networkError = .Error(description: error!.localizedDescription)
                    completition(nil,self.networkError)
                }
                else if let data = data {
                    do {
                        if let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                            self.networkError = .None
                            completition(parsedData, self.networkError)
                        }
                    }
                    catch let error as NSError {
                        self.networkError = .Error(description: error.localizedDescription)
                        print(error)
                        completition(nil,self.networkError)
                    }
                }
            })
            task.resume()
        }
    }
}
