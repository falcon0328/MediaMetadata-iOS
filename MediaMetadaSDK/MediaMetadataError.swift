//
//  MediaMetadataError.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/14.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// MediaMetadaSDKのエラードメイン
private let MediaMetadataErrorDomain = "jp.co.falcon-tech.MediaMetadata"

/// 画像データが存在しない場合のエラーコード
public let MediaMetadataErrorBadPhotoData = 11101
/// 画像データの生成に失敗した場合のエラーコード
public let MediaMetadataErrorCannotCreateImageData = 11102
/// 画像ファイルの生成に失敗した場合のエラーコード
public let MediaMetadataErrorCannotCreatePhotoFile = 11103
/// 画像アセットの生成に失敗した場合のエラーコード
public let MediaMetadataErrorCannotCreatePhotoAsset = 11104
/// 画像アセットの更新に失敗した場合のエラーコード
public let MediaMetadataErrorCannotUpdatePhotoAsset = 11105

/// MediaMetadataSDKのエラーを表現するための構造体
public struct MediaMetadataError: Error {
    /// エラードメイン
    public let domain: String
    /// エラーコード
    public let code: Int
}

/// MediaMetadaSDKのエラーを生成する
///
/// - Parameters:
///   - domain: エラーのドメイン
///   - code: エラーコード
/// - Returns: MediaMetadataSDKのエラーコード
func createMediaMetadaSDKError(code: Int) -> Error {
    return MediaMetadataError(domain: MediaMetadataErrorDomain, code: code)
}
