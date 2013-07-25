//
//  CharacterLayer.h
//  PaperMoon
//
//  Created by Andy Woo on 25/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Scene2.h"

@interface CharacterLayer : CCLayer <UIGestureRecognizerDelegate> {
    CCSprite *_goomaSprite;
    CCSprite *_goomaSprite1;
    CCSprite *_goomaSprite2;
    CCSprite *_goomaRepeat;
    CCSprite *_title;
    CCSprite *_hand;
    CCSprite *_swipeFinger;
    CCSprite *_tap;
    CCSprite *_backwave;
    CCSprite *_backwaveRepeat;
    CCSprite *_frontwave;
    CCSprite *_frontwave2nd;
    CCSprite *_frontwaveRepeat;
    CCMotionStreak *streck;
    
    CCSpriteBatchNode *bnBackWave;
    CCSpriteBatchNode *bnBackWaveRepeat;
    CCSpriteBatchNode *bnFrontWave;
    CCSpriteBatchNode *bnFrontWaveRepeat;
    CCSpriteBatchNode *bnFrontWave2nd;
    CCSpriteBatchNode *spriteSheet;
    CCSpriteBatchNode *spriteSheet1;
    CCSpriteBatchNode *spriteSheet2;
    CCSpriteBatchNode *spriteSheet3;
    CCSpriteBatchNode *bnGoomaRepeat;
    CCSpriteFrameCache *frameCache;
    BOOL didGoomaAnimationFinish;
    BOOL didTouched;
    BOOL isSwipedDown;
    BOOL isShowingSwiping;
//    UIActivityIndicatorView *activityIndicatorView;

    
}

@property (nonatomic, strong) CCSprite *title;
@property (nonatomic, strong) CCSprite *hand;
@property (nonatomic, strong) CCSprite *swipeFinger;
@property (nonatomic, strong) CCSprite *tap;
@property  (nonatomic, strong) CCSprite *goomaSprite;
@property  (nonatomic, strong) CCSprite *goomaSprite1;
@property (nonatomic, strong) CCSprite *goomaSprite2;
// @property (nonatomic, retain) CCSprite *repeatGoomaSprite;
@property (nonatomic, strong) CCSprite *backwave;
@property (nonatomic, strong) CCSprite *backwaveRepeat;
@property (nonatomic, strong) CCSprite *frontwave;
@property (nonatomic, strong) CCSprite *frontwaveRepeat;
@property (nonatomic, strong) CCSprite *frontwave2nd;
@property (nonatomic, strong) CCSprite *goomaRepeat;

@end
