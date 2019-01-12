//
//  XCTestcase+Extension.swift
//  MediaMetadaSDKTests
//
//  Created by aseo on 2019/01/12.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    var testBundle: Bundle {
        get {
            return Bundle(for: type(of: self))
        }
    }
}
