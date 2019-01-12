//
//  PhotoTests.swift
//  MediaMetadaSDKTests
//
//  Created by aseo on 2019/01/12.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation
import XCTest
@testable import MediaMetadaSDK

class PhotoTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_正常系_getData_Dataを与えた場合() {
        let expectation = XCTestExpectation(description: "test_正常系_getData")
        let photoUrl = testBundle.url(forResource: "meshi", withExtension: "jpg")!
        let photoData = try! Data(contentsOf: photoUrl)
        let photo = Photo(data: photoData)
        photo.getData(completionHandler: { data in
            XCTAssertEqual(data, photoData)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
}
