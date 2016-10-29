//
//  GameMode.swift
//  NH_Takashi
//
//  Created by yohei on 2016/08/16.
//  Copyright © 2016年 yohei. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameMode: UIViewController, GADBannerViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 各描画パーツの縦幅比率の設定
        let ratioHeader = 2
        let ratioMain = 14
        let ratioItem = 3
        let ratioSum = ratioHeader + ratioMain + ratioItem
        
        // Screen Size の取得
        let statusbarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height - statusbarHeight
        
        
        
        var mainHeight: Int
        var itemHeight: Int
        var headerHeight: Int
        var heightTemp = Int(statusbarHeight)
        heightTemp = 0
        

        // AdMob広告設定
        var bannerView: GADBannerView = GADBannerView()
        bannerView = GADBannerView(adSize:kGADAdSizeSmartBannerPortrait)
        bannerView.frame.origin = CGPointMake(0, self.view.frame.size.height - bannerView.frame.height)
        bannerView.frame.size = CGSizeMake(self.view.frame.width, bannerView.frame.height)
        // AdMobで発行された広告ユニットIDを設定
        bannerView.adUnitID = "ca-app-pub-1066065675178783/1714655558"
        bannerView.delegate = self
        bannerView.rootViewController = self
        let gadRequest:GADRequest = GADRequest()
        // テスト用の広告を表示する時のみ使用（申請時に削除）
        gadRequest.testDevices = [kGADSimulatorID]
        bannerView.loadRequest(gadRequest)
        self.view.addSubview(bannerView)

        // 各描画パーツの縦幅の設定
        mainHeight = Int(screenHeight - bannerView.frame.height) * ratioMain / ratioSum
        itemHeight = Int(screenHeight - bannerView.frame.height) * ratioItem / ratioSum
        headerHeight = Int(screenHeight - bannerView.frame.height) - mainHeight - itemHeight

        // 各描画パーツのViewを作成
        let statusView = UIView(frame: CGRectMake(0, CGFloat(heightTemp), screenWidth, CGFloat(statusbarHeight)))
        heightTemp += Int(statusbarHeight)
        statusView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(statusView)
        
        let headerView = UIView(frame: CGRectMake(0, CGFloat(heightTemp), screenWidth, CGFloat(headerHeight)))
        heightTemp += headerHeight
        headerView.backgroundColor = UIColor.blueColor()
        self.view.addSubview(headerView)
        
        let mainView = GameModeMain(frame: CGRectMake(0, CGFloat(heightTemp), screenWidth, CGFloat(mainHeight)))
        heightTemp += mainHeight
        mainView.backgroundColor = UIColor.redColor()
        self.view.addSubview(mainView)
        
        let itemView = UIView(frame: CGRectMake(0, CGFloat(heightTemp), screenWidth, CGFloat(itemHeight)))
        heightTemp += itemHeight
        itemView.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(itemView)


        
        // ゲームヘッダ情報
        
        // ゲームメイン部
        // 使用可能アイテム
    
        // イメージの描画
//        let stageView = StageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
//        stageView.backgroundColor = UIColor.clearColor()
//        self.view.addSubview(stageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}