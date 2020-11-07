# Keep Away from Futon

<img src="https://user-images.githubusercontent.com/30472855/98431697-1e2bd000-20fb-11eb-88be-73c68340157a.png" width="300">

## YouTube

[![](https://img.youtube.com/vi/imMLxJCqtd8/0.jpg)](https://www.youtube.com/watch?v=Uqg-81OjKJs)

## 製品概要

### 背景(製品開発のきっかけ、課題等）

目覚ましで起きることはできたのに、なかなか布団から出られず時間が過ぎていくという課題を解決するために開発しました。
既存の二度寝防止アプリでは二度寝は防げても、その後布団の中でスマホをいじって時間を浪費してしまうことは防げません。
このアプリではアラーム音を止めるために布団を畳む必要があるので、布団に戻るハードルを上げてくれます。

### 製品説明（具体的な製品の説明）

iPhone/Android用の目覚ましアプリです。
指定した時間になるとアラーム音が鳴ります。ボタンを押すと写真を撮ることができ、画像認識により布団が畳まれているか確認します。畳まれた布団が認識されない限り音が鳴り続けるので、嫌でも布団から出ないといけません。

### 特長

#### 1. 布団を畳むまでアラーム音が止まらない

#### 2. ミライ小町ちゃんが『おはよう』と言って起こしてくれる

#### 3. 布団の画像を送ると畳んでいるかの判定をしてくれる

### 使い方

1. 就寝前にアプリで起床時刻を設定
1. 快眠する
1. 設定時刻になるとアラームが鳴る
1. アプリを起動しても音が鳴り止まない。止めたければ畳んだ布団の画像を撮影
1. 畳んだことが認められると音が止まる
1. ミライ小町が可愛く挨拶してくれる

### 解決出来ること

* 布団から出られずに起きれないという問題がなくなる
* 目覚めが悪い人でも、未来こまちちゃんで爽やかに起きれる
* 絶起(**絶望の起床**)を防ぐことが出来る

### 今後の展望

* ミライ小町ちゃんの動作を増やし、アプリのエンタメを拡張する
* 起きた時間をツイートする
* 布団を畳む時間を友達同士でSNSを使って競い合う

### 注力したこと（こだわり等）

* 布団から出たことを判定するため、400枚以上の画像をネット上から集め、そのうち約40枚の画像データを学習させた。
* ミライ小町ちゃんを使って快眠効果を考えた。
* メンバー全員がFlutterを書いたことないが、Flutterを採択しiPhone/Android両方で使えるようにした。

## 開発技術

### 活用した技術

#### API・データ
* Azure Custom Vision

#### フレームワーク・ライブラリ・モジュール
* Flutter
* Unity

#### デバイス
* Android
* iPhone

### 独自技術
#### ハッカソンで開発した独自機能・技術
* [カメラの映像をazureで判定](https://github.com/jphacks/F_2005/pull/11)
