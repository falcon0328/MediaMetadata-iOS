//
//  MetadataKey.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/07.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// メタデータを指定する際に利用する列挙型
public enum MetadataKey: String {
    /// EXIF
    case exif = "{Exif}"
    /// GPS
    case gps = "{GPS}"
    /// IPTC
    case iptc = "{IPTC}"
    /// JFIF
    case jfif = "{JFIF}"
    /// TIFF
    case tiff = "{TIFF}"
    /// カラーモデル
    case colorModel = "ColorModel"
    /// 向き
    case orientation = "Orientation"
    /// 画像の幅
    case pixelWidth = "PixelWidth"
    /// 画像の高さ
    case pixelHeight = "PixelHeight"
    /// 画像の深度
    case depth = "Depth"
    /// プロファイル名
    case profileName = "ProfileName"
    /// 解像度の幅
    case dpiWidth = "DPIWidth"
    /// プライマリーイメージ
    case primaryImage = "PrimaryImage"
}
