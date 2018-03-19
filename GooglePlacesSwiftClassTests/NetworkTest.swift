//
//  NetworkTest.swift
//  BuzzmoveTests
//
//  Created by Riccardo Rizzo on 14/03/18.
//  Copyright © 2018 Riccardo Rizzo. All rights reserved.
//

import XCTest
@testable import GooglePlacesSwift

class NetworkTest: XCTestCase {
    
    func testNetworkConnection() {
        let _expectation = expectation(description: "NetworkTest")
        let network = NetworkRequest()
        
        network.makeNetworkRequest(BaseApiConstant.kBaseUrlApi) { (result, networkError) in
            switch networkError {
            case .None:
                _expectation.fulfill()
            default:
                XCTFail("Network Error")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}



