//
//  MediaType.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/07.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// メディアの種類を表す列挙型
public enum MediaType: Int {
    /// 写真
    case photo = 0
    /// 動画
    case video = 1
    /// 音声
    case audio = 2
}
