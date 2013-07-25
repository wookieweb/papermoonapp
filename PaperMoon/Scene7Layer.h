//
//  Scene7Layer.h
//  PaperMoon
//
//  Created by Andy Woo on 8/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"

@interface Scene7Layer : CCLayer <UIGestureRecognizerDelegate>{
    
    CCSpriteFrameCache *frameCache;
    
    CCSprite *_gooma1st;
    CCSprite *_gooma2nd;
    CCSprite *_gooma3rd;
    CCSprite *_goomaRepeat1st;
    CCSprite *_goomaRepeat2nd;
    CCSprite *_goomaRepeat3rd;
    CCSprite *_ghost;
    CCSprite *_flower;
    CCSprite *_door;
    CCSprite *_curtain;
    CCSprite *_fox;
    BOOL doorClosed;
    BOOL isDoorClosing;
    BOOL isGhostVisible;
    BOOL isSwipedDown;
    

    CCSpriteBatchNode *bnGooma1st;
    CCSpriteBatchNode *bnGooma2nd;
    CCSpriteBatchNode *bnGooma3rd;
    CCSpriteBatchNode *bnGoomaRepeat1st;
    CCSpriteBatchNode *bnGoomaRepeat2nd;
    CCSpriteBatchNode *bnGoomaRepeat3rd;
    CCSpriteBatchNode *bnGhost;
    CCSpriteBatchNode *bnFlower;
    CCSpriteBatchNode *bnDoor;
  
    
}

@property (nonatomic, strong) CCSprite *gooma1st;
@property (nonatomic, strong) CCSprite *gooma2nd;
@property (nonatomic, strong) CCSprite *gooma3rd;
@property (nonatomic, strong) CCSprite *goomaRepeat1st;
@property (nonatomic, strong) CCSprite *goomaRepeat2nd;
@property (nonatomic, strong) CCSprite *goomaRepeat3rd;
@property (nonatomic, strong) CCSprite *ghost;
@property (nonatomic, strong) CCSprite *flower;
@property (nonatomic, strong) CCSprite *door;
@property (nonatomic, strong) CCSprite *curtain;
@property (nonatomic, strong) CCSprite *fox;



@end
