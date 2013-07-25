//
//  GoomaLayer.h
//  PaperMoon
//
//  Created by Andy Woo on 5/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"


@interface GoomaLayer : CCLayer {
    CCSpriteFrameCache *frameCache;
    CCSpriteBatchNode *bnGooma1st;
    CCSpriteBatchNode *bnGoomaRepeat;
    CCSpriteBatchNode *bnGoomaYelling;
    CCSprite *_gooma1st;
    CCSprite *_goomaRepeat;
    CCSprite *_goomaYelling;
    BOOL isGoomaYelling;
    BOOL isGooma1st;
    BOOL isGoomaRepeat;
    
}

@property (nonatomic, strong) CCSprite *goomaRepeat;
@property (nonatomic, strong) CCSprite *gooma1st;
@property (nonatomic, strong) CCSprite *goomaYelling;
@property (nonatomic) BOOL isGoomaYelling;
@property (nonatomic) BOOL isGoomaRepeat;

// -(BOOL) isTouchForMe:(CGPoint)touchLocation;
-(void)showGoomaYelling;
-(void)showGoomaRepeat;
-(void)showGoomaYellingOnce;
-(void)showGoomaOnce;
-(void)freezeAllGoomaLayer;
-(void)unFreezeAllGoomaLayer;
@end
