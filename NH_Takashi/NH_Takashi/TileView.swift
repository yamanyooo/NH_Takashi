//
//  TileView.swift
//  NH_Takashi
//
//  Created by yohei on 2016/10/28.
//  Copyright © 2016年 yohei. All rights reserved.
//

import Foundation
import UIKit


protocol TouchActionDelegate{
    func touchTileEvent(tile: TileView)
}

enum TileActiveState{
    case ACTIVE
    case INACTIVE
}


class TileView: UIView {
    
    var tilePosX = 0
    var tilePosY = 0
    var tileActiveState = TileActiveState.INACTIVE
    var delegate :TouchActionDelegate?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init error")
    }
    
    //    override func drawRect(rect: CGRect) {
    
    //    }
    
    func setColler(x: Int, y: Int){
        self.backgroundColor = (x + y) % 2 == 0 ? UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1) : UIColor.whiteColor()
    }
    func setColler(){
        self.backgroundColor = (tilePosX + tilePosY) % 2 == 0 ? UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1) : UIColor.whiteColor()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        tileActiveState = TileActiveState.ACTIVE
        self.tileProcessing(tileActiveState)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var tapLocation: CGPoint
        let touch = touches.first
        
        tapLocation = touch!.locationInView(self)
        
        if( (TileActiveState.ACTIVE == tileActiveState)
         && (false == self.bounds.contains(tapLocation)) ){
            
            tileActiveState = TileActiveState.INACTIVE
            self.tileProcessing(tileActiveState)
        
        }else{

            // NONE
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var tapLocation: CGPoint
        let touch = touches.first
        
        tapLocation = touch!.locationInView(self)

        if( (TileActiveState.ACTIVE == tileActiveState)
         && (true == self.bounds.contains(tapLocation)) ){
            
            // Tap成立　デリゲート
            self.delegate?.touchTileEvent(self)

        }else{
            // NONE
        }
        
        tileActiveState = TileActiveState.INACTIVE
        self.tileProcessing(tileActiveState)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
        tileActiveState = TileActiveState.INACTIVE
        self.tileProcessing(tileActiveState)
    }
    
    private func tileProcessing(state: TileActiveState){
        
        if(TileActiveState.ACTIVE == state){

            self.backgroundColor = UIColor(red: 0.7, green: 0.4, blue: 0.4, alpha: 1)

        }else{
            
            self.setColler()
            
        }
    }
}