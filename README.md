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
1. Photos.frameworkをimportします
``` swift
import Photos
```

2. PHAssetをfetchしておきます
``` swift
let assets = PHAsset.fetchAssets(with: nil)
```

3. Media プロトコル（MediaMetadata-iOSでのカメラロールのメディアを表現するクラス、以下メディアと呼びます）の配列を取得できます。
``` swift
let mediaList = MediaLibrary.load(assets: assets)
```

4. メディアからは以下のような形式でメタデータやData型のデータとして取得できます。ただし、これらのメソッドは非同期です。
``` swift
let media = mediaList.first!
media.getData(completionHandler: @escaping (Data?) -> Void)
media.getMetadata(completionHandler: @escaping ([MetadataKey : Metadata]) -> Void)
```

5. メタデータはMetadataプロトコルで表現され、メタデータの読み込みや編集は read/write メソッドからできます。メタデータは内部的に[String: Any]として管理されています。

（※ 例えば写真のメタデータはExifやTIFFなどがあり、これらもMetadata型のデータとして表現します。）

6. メタデータをメディアに書き込む際には、メディアの`setMetadata(key: MetadataKey, value: Metadata)`を利用します。

7. メタデータをメディアに書き込んだ後はメディアの`save(completionHandler: @escaping (Bool, Error?) -> Void)`メソッドを呼ぶことでカメラロールに新しいデータとして保存されます。

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
