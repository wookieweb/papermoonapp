//
//  Scene4Layer.h
//  PaperMoon
//
//  Created by Andy Woo on 31/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Scene4Layer : CCLayer <UIGestureRecognizerDelegate> {
  
    CCSprite *_boat;
    CCSprite *_wave;
    CCSprite *_frontWave;
    CCSprite *_flippedWave;
    CCSprite *_gooma1st;
    CCSprite *_gooma2nd;
    CCSprite *_fox;
    CCSprite *_fox2nd;
    CCSpriteFrameCache *frameCache;
    CCSpriteBatchNode *bnBoat;
    CCSpriteBatchNode *bnGooma1st;
    CCSpriteBatchNode *bnGooma2nd;
    CCSpriteBatchNode *bnFox;
    CCSpriteBatchNode *bnWave;
    CCSpriteBatchNode *spriteSheet;
    CCSprite *_hand;
    CCSprite *_tap;
    BOOL isSwipedDown;
    BOOL isJumping;
    BOOL didCapture;
    BOOL didTouched;
    BOOL didCatch;
   
    NSSet *pausedActions;
   

    
}

@property (nonatomic, strong) CCSprite *boat;
@property (nonatomic, strong) CCSprite *gooma1st;
@property (nonatomic, strong) CCSprite *gooma2nd;
@property (nonatomic, strong) CCSprite *fox;
@property (nonatomic, strong) CCSprite *fox2nd;
@property (nonatomic, strong) CCSprite *wave;
@property (nonatomic, strong) CCSprite *flippedWave;
@property (nonatomic, strong) CCSprite *frontWave;
@property (nonatomic, strong) CCSprite *hand;
@property (nonatomic, strong) CCSprite *tap;


@end
