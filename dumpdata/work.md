# はじめに

略語をうっかり使ってしまいがちなので説明を先にm
[ビジネス文書にもちょいちょい出現する cf. / e.g. / i.e.の意味・使い方 - 翻訳の代行・見積なら スピード翻訳](https://www.quicktranslate.com/blog/2018/03/%E3%83%93%E3%82%B8%E3%83%8D%E3%82%B9%E6%96%87%E6%9B%B8%E3%81%AB%E3%82%82%E3%81%A1%E3%82%87%E3%81%84%E3%81%A1%E3%82%87%E3%81%84%E5%87%BA%E7%8F%BE%E3%81%99%E3%82%8B-cf-e-g-i-e-%E3%81%AE%E6%84%8F/)

## Lesson 12

docker containerを外部公開してみよう

狙い

- kubernetesを用いた外部公開との比較するため (1containerならともかく100,1000containerでやることを想像したらorz的な)

ref.

- [Dockerコンテナにネットワークアクセスする - Qiita](https://qiita.com/ksato9700/items/0b4c7de5d857dc731443)
- [コンテナ通信の理解 — Docker-docs-ja 1.12.RC2 ドキュメント](http://docs.docker.jp/v1.12/engine/userguide/networking/default_network/container-communication.html)

## Lesson 13

kubernetesってなに？を知ろう

狙い

- 公式にあるチュートリアルをやってもらう前に全体感を知ってもらうと学習効率良さそうなので。

ref.

- [(4) [挫折したエンジニア向け] Kubernetesの仕組みをちゃんと理解する (入門/基本編) - YouTube](https://www.youtube.com/watch?v=r0NpHb-6IvY&t=1139s)
  - 前提知識怪しいな、ってなったらこれみる感じで
    - [(4) 【CCNA合格講座】TCP/IPとは？「仕組み」完全解説！【インフラエンジニア基礎入門 #5】 - YouTube](https://www.youtube.com/watch?v=Pp6-YXxL06Y&t=4s)
    - [(4) 【CCNA講座】「ルーティング」これさえ見れば完全理解！【インフラエンジニア基礎入門 #9】 - YouTube](https://www.youtube.com/watch?v=_sWIKXnWNmU&t=31s)

## Lesson 14

kubernetes公式のチュートリアルをやってみよう

狙い

- チュートリアルで手を動かした方が覚えやすそうなので。(学習スタイル的にまずやってみたい派なら、13と順番入れ替えてもOK)

ref.

- [Kubernetesの基本を学ぶ | Kubernetes](https://kubernetes.io/ja/docs/tutorials/kubernetes-basics/)

## Lesson 15

イベント資料を読み込んで案件に関連する知識をつめこもう！

狙い

- 現場のアーキテクチャや関連知識はイベントで出てたりするもの。
- 知識を得ると同時に、イベントではこんなん知れるんやぁも知ってもらえると儲けもの

ref.
[Z Lab - 技術で新しい世界へシフトする。](https://zlab.co.jp/)より引っ張ってきたものばかりです

- プロダクト全体感の参考
  - [YJTC18 C-5 アプリケーションの高速デプロイを可能にする技術](https://www.slideshare.net/techblogyahoo/yjtc18-c5-yahoo-japan-kubernetes-as-a-service)
  - [めっちゃわかる Kubernetes! / Mix Leap Study #32 - Speaker Deck](https://speakerdeck.com/superbrothers/mix-leap-study-number-32)
  - [Kubernetesの利用・普及、その先は何か? - Speaker Deck](https://speakerdeck.com/takanariko/kubernetesfalseli-yong-pu-ji-sofalsexian-hahe-ka)
- コンポーネントレベルの参考
  - [Kubernetes with Prometheus - Speaker Deck](https://speakerdeck.com/tksm/kubernetes-with-prometheus)
  - [Kubernetes の認証・認可と RBAC - Speaker Deck](https://speakerdeck.com/tksm/kubernetes-falseren-zheng-ren-ke-to-rbac)
  - [Yahoo! JAPANにおけるAthenzを用いたk8sアクセス制御管理 @JapanContainerDays - Speaker Deck](https://speakerdeck.com/kpango/yahoo-japanniokeruathenzwoyong-itak8sakusesuzhi-yu-guan-li-at-japancontainerdays?slide=20)
- 実利用レベルの参考
  - [Kubernetes上でアプリケーションを 運用するまでの道のり/The way to run applications with Kubernetes - Speaker Deck](https://speakerdeck.com/shmurata/the-way-to-run-applications-with-kubernetes)
  - [kubectl のプラグイン機構を活用してオペレーションを効率化しよう / Let's use the kubectl plugin! - Speaker Deck](https://speakerdeck.com/ryysud/lets-use-the-kubectl-plugin)

## Lesson 16

ここまでやったこと・知ったことでわからなかったことをsatagaさんに聞こう

狙い

- 質問するにしても何がわからなかったか、を明確にするのはとても大事。
- わからないながらも何がわからなかったかを頑張って捻り出そう！

<details>
<summary>お蔵入り</summary>

## Lesson 17(時間余ったらで)

構築したNode Exporterサーバにdocker, minikubeをインストールしよう
minikube

狙い

- yumコマンドを使用したサーバセットアップ
- 参考資料だけじゃ詰まりそうな予感があって、なんとかする力の強化につながれば幸い

ref.

- [CentOS 7にDockerとKubernetes（minikube）をインストール - Qiita](https://qiita.com/eiji-noguchi/items/1c42c8410b3fcc57c824)
- [Install Docker on CentOS 7](https://zenn.dev/ymasaoka/articles/install-docker-centos-7)
  - 踏み台サーバをProxyとして見立てればたぶん大丈夫

</details>
