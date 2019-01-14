//
//  PhotoTests.swift
//  MediaMetadaSDKTests
//
//  Created by aseo on 2019/01/12.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation
import XCTest
@testable import MediaMetadataSDK

class PhotoTests: XCTestCase {
    var photoUrl: URL {
        get {
            return testBundle.url(forResource: "meshi", withExtension: "jpg")!
        }
    }
    var photoData: Data {
        get {
            return try! Data(contentsOf: photoUrl)
        }
    }
    var photo: Photo {
        get {
            return Photo(data: photoData)
        }
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_正常系_getData_Dataを与えた場合() {
        let expectation = XCTestExpectation(description: "test_正常系_getData")
        photo.getData(completionHandler: { data in
            XCTAssertEqual(data, self.photoData)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_正常系_getMetadata_Dataを与えた場合() {
        let expectation = XCTestExpectation(description: "test_正常系_getMetadata_Dataを与えた場合")
        photo.getMetadata(completionHandler: { metadatas in
            XCTAssertNotNil(metadatas[MetadataKey.exif])
            XCTAssertNotNil(metadatas[MetadataKey.jfif])
            XCTAssertNotNil(metadatas[MetadataKey.tiff])
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_正常系_getMetadata_Dataを与えた場合_GPS付き() {
        let expectation = XCTestExpectation(description: "test_正常系_getMetadata_Dataを与えた場合_GPS付き")
        let pancakePhotoUrl = testBundle.url(forResource: "pancake",
                                       withExtension: "jpg")!
        let pancakePhotoData = try! Data(contentsOf: pancakePhotoUrl)
        let pancakePhoto = Photo(data: pancakePhotoData)
        pancakePhoto.getMetadata(completionHandler: { metadatas in
            XCTAssertNotNil(metadatas[.gps])
            expectation.fulfill()
        })
    }
}
