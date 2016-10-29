//
//  StageView.swift
//  NH_Takashi
//
//  Created by yohei on 2016/08/16.
//  Copyright © 2016年 yohei. All rights reserved.
//

import Foundation
import UIKit


class StageView: UIView {

    let h_tile = 6
    let v_tile = 7

    struct TilePosition{
        let iniValue_activeTile = -1
        var x: Int
        var y: Int
        
        init(){
            x = iniValue_activeTile
            y = iniValue_activeTile
        }
    }
    
    struct TileInfo{
        let iniValue_tileInfo = -1
        var point1_x :Int
        var point1_y :Int
        var point2_x :Int
        var point2_y :Int

        
/*        init(){
            point_x = iniValue_tileInfo
            point_y = iniValue_tileInfo
        }
*/
    }

    var delegate :TouchActionDelegate?
    var activeTilePos = TilePosition()
    var tileInfo = [[TileInfo]]()
    var activeTileView = UIBezierPath()
    
    override func drawRect(rect: CGRect) {
        
        var px,py: Int
        var tile_size_temp: Int
        var tile_size: Int
        var tile_adjustment: Int
        
        tile_size_temp = (Int)(self.frame.size.width) / h_tile
        tile_adjustment = (Int)(self.frame.size.width) % h_tile
        
        // 矩形でタイルを描画 -------------------------------------
        for y in 0..<v_tile {
            
            px = 0
            py = ( y + 1 ) * tile_size_temp
            tileInfo.append([TileInfo]())
            
            for x in 0..<h_tile {
                if( x < tile_adjustment ){
                    tile_size = tile_size_temp + 1
                }
                else{
                    tile_size = tile_size_temp
                }
            
                let rectangle = UIBezierPath(rect: CGRectMake(CGFloat(px),CGFloat(py),CGFloat(tile_size),CGFloat(tile_size_temp)))

                tileInfo[y].append(TileInfo(point1_x: px, point1_y: py, point2_x: ( px + tile_size - 1 ), point2_y: (py + tile_size_temp - 1 )))
                
                NSLog("\nTile\nx = %d   y = %d", tileInfo[y][x].point1_x, tileInfo[y][x].point1_y)
                
                // stroke 色の設定
                if( ( activeTilePos.x == x )
                    && ( activeTilePos.y == y) ){
                    UIColor(red: 0.7, green: 0.4, blue: 0.4, alpha: 1).setStroke()
                    UIColor(red: 0.7, green: 0.4, blue: 0.4, alpha: 1).setFill()
                }
                else if( ( x + y ) % 2 == 0 ){
                    UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1).setStroke()
                    UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1).setFill()
                }
                else{
                    UIColor.whiteColor().setStroke()
                    UIColor.whiteColor().setFill()
                }
                // ライン幅
                rectangle.lineWidth = 0
                
                // 描画
                rectangle.fill()
                rectangle.stroke()
                // 次のタイルへ移動
                px += tile_size
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        var tapLocation: CGPoint
        let touch = touches.first
        
        tapLocation = touch!.locationInView(self)
        NSLog( "\nBegan\nx = %f   y = %f", tapLocation.x, tapLocation.y)
        activeTilePos = getTilePosition( tapLocation )
        
        if( ( activeTilePos.iniValue_activeTile != activeTilePos.x )
         && ( activeTilePos.iniValue_activeTile != activeTilePos.y ) ){
            activeTileProcessing()
        }
        else{}
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        var tapLocation: CGPoint
        var touchTile = TilePosition()
        let touch = touches.first
        
        tapLocation = touch!.locationInView(self)
        touchTile = getTilePosition( tapLocation )
        
        if( ( activeTilePos.x != touchTile.x )
         || ( activeTilePos.y != touchTile.y ) ){
            inactiveTileProcessing()
        }
        else{}
        
        NSLog( "\nMoved\nx = %f   y = %f", tapLocation.x, tapLocation.y)
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var tapLocation: CGPoint
        let touch = touches.first
        
        tapLocation = touch!.locationInView(self)
        if( ( activeTilePos.iniValue_activeTile != activeTilePos.x )
         || ( activeTilePos.iniValue_activeTile != activeTilePos.y ) ){
            inactiveTileProcessing()
        }
        else{}
        
        NSLog( "\nEnded\nx = %f   y = %f", tapLocation.x, tapLocation.y)
        
    }
    
    // タイル位置情報取得処理
    func getTilePosition( point :CGPoint ) -> TilePosition{
        var resultPos = TilePosition()
        
        NSLog("result = %d, %d", tileInfo[0][0].point1_x, tileInfo[0][0].point2_x)

        for x in 0..<h_tile {
            if( ( Int(point.x) >= tileInfo[0][x].point1_x )
                && ( Int(point.x) <= tileInfo[0][x].point2_x ) )
            {
                resultPos.x = x
            }
            
        }
        
        for y in 0..<v_tile {
            if( ( Int(point.y) >= tileInfo[y][0].point1_y )
             && ( Int(point.y) <= tileInfo[y][0].point2_y ) )
            {
                resultPos.y = y
            }

        }
    
        return (resultPos)
    }
    
    // アクティブタイル処理
    func activeTileProcessing(){
        setNeedsDisplay()
    }
    
    // 非アクティブタイル処理
    func inactiveTileProcessing(){
        activeTilePos.x = activeTilePos.iniValue_activeTile
        activeTilePos.y = activeTilePos.iniValue_activeTile
        setNeedsDisplay()
    }
    
}