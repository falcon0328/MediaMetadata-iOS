//
//  MediaLibrary.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/07.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// メディアを管理するためのクラス
class MediaLibrary: MediaLibraryManager {
    
    func load(localIdentifier: String) -> Media? {
        return nil
    }
    
    func delete(localIdentifier: String) -> Bool {
        return false
    }
}
