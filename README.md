# MediaMetadata-iOS
iOS端末上の写真や動画に対して、簡単にメタデータを付与するためのSDKです。

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/hsylife/SwiftyPickerPopover)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
![iOS](https://img.shields.io/badge/iOS-12.1+-green.svg)
![Xcode](https://img.shields.io/badge/Xcode-10.1+-green.svg)
![language](https://img.shields.io/badge/language-Swift4.2+-green.svg)

## インストール条件
`MediaMetada-iOS`は以下の環境での動作を保証しています。
- iOS 12.1+
- Xcode 10.1+
- Swift 4.2+

## 導入方法
`MediaMetada-iOS`はCarthageでの導入にのみ対応しています。
### Carthage
Carthageを使って`MediaMetada-iOS`をXcodeプロジェクトに導入するには、`Cartfile`で以下の文言を指定してください。
```
github "falcon0328/MediaMetadata-iOS"
```

## 利用方法
`MediaLibrary`クラスの`load`メソッドに`PHFetchResult<PHAsset>`を与えることでカメラロールの写真や動画や音声を独自の`Media`型にマッピングして提供します。 

（※ `MediaLibrary`はシングルトン専用なので`shared`プロパティから各種操作を行ってください。）
``` swift
// 1. Photos.frameworkをimportします
import Photos
// 2. PHAssetをfetchしておきます
let assets = PHAsset.fetchAssets(with: nil)
// 3. Media型（MediaMetadata-iOSでのカメラロールのメディアを表現するクラス）の配列を取得できます。
let mediaList = MediaLibrary.load(assets: assets)
// 4. 以下のような形式でメタデータやData型のデータとして取得できます。ただし、これらのメソッドは非同期です。
mediaList.first!.getData(completionHandler: @escaping (Data?) -> Void)
mediaList.first!.getMetadata(completionHandler: @escaping ([MetadataKey : Metadata]) -> Void)
```

## クラス図
`MediaMetada-iOS`は以下のクラス図をもとに実装されています。

![クラス図](https://github.com/falcon0328/MediaMetadata-iOS/blob/develop/MediaMetadata-class.png)

## ライセンス
`MediaMetada-iOS`は MIT LICENSE です。詳細は[MIT License](LICENSE)を参照ください。

## クレジット
`MediaMetadata-iOS` は　[Falcon Tech](https://falcon-tech.connpass.com)の活動で作成されています。PRやご要望（Issue）もお待ちしております。

## FAQ
### Q＆Aの仕方
Issueを新規作成して、メンションをつけていただければ回答させていただきます。
