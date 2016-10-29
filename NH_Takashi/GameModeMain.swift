//
//  GameModeMain.swift
//  NH_Takashi
//
//  Created by yohei on 2016/10/12.
//  Copyright © 2016年 yohei. All rights reserved.
//

import Foundation
import UIKit


class GameModeMain: UIControl, TouchActionDelegate {
    
    let h_tile = 7
    let v_tile = 8
    
    var tileView = [[TileView]]()
    
    override init(frame: CGRect) {

        super.init(frame: frame)
        
        let h_tileSize = Int(self.frame.size.width) / h_tile
        let v_tileSize = Int(self.frame.size.height) / v_tile
        let h_tileAdjNum = Int(self.frame.size.width) % h_tile
        let v_tileAdjNum = Int(self.frame.size.height) % v_tile
        var h_tileAdjSize, v_tileAdjSize: Int
        var xPoint: CGFloat = 0
        var yPoint: CGFloat = 0
        
        for y in 0..<v_tile{
            
            tileView.append([TileView]())
            v_tileAdjSize = v_tileAdjNum > y ? 1 : 0
            xPoint = 0
            
            for x in 0..<h_tile{
                
                h_tileAdjSize = h_tileAdjNum > x ? 1 : 0
                
                tileView[y].append(TileView(frame: CGRectMake(xPoint, yPoint , CGFloat(h_tileSize + h_tileAdjSize), CGFloat(v_tileSize + v_tileAdjSize))))
                tileView[y][x].setColler(x, y: y)
                tileView[y][x].tilePosX = x
                tileView[y][x].tilePosY = y
                
                self.addSubview(tileView[y][x])
                tileView[y][x].delegate = self

                xPoint += CGFloat(h_tileSize + h_tileAdjSize)
            }
            xPoint = 0
            yPoint += CGFloat(v_tileSize + v_tileAdjSize)
        }
        
        
//        NSLog("%f", self.frame.size.height)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init error")
    }
    
    // デリゲート関数
    func touchTileEvent(tile: TileView) {
        
        let cheese: UIImage = UIImage(named: "cheese.png")!
        let cheeseView = UIImageView(image: cheese)
        cheeseView.frame = tile.frame
        self.addSubview(cheeseView)
        NSLog("\nTap成立 x=%d y=%d", tile.tilePosX, tile.tilePosY)
    }
    
    
}