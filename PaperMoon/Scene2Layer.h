//
//  Scene2Layer.h
//  PaperMoon
//
//  Created by Andy Woo on 28/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
// #import "Scene1.h"
// #import "Scene3.h"
#import "Constants.h"
#import "CCParticleSystemQuad.h"


@interface Scene2Layer : CCLayer <UIGestureRecognizerDelegate> {
    CCSprite *_gooma1st;
    CCSprite *_gooma2nd;
    CCSprite *_frontFox1st;
    CCSprite *_frontFox2nd;
    CCSprite *_waves1st;
    CCSprite *_waves2nd;
    
    CCSprite *_hand;
    CCSprite *_tap;
    
    CCSpriteFrameCache *frameCache;
    CCSpriteBatchNode *spriteSheet;
    CCSpriteBatchNode *spriteSheet1;
    CCSpriteBatchNode *spriteSheet2;
    CCSpriteBatchNode *spriteSheet3;
    CCSpriteBatchNode *spriteSheet4;
    CCSpriteBatchNode *spriteSheet5;
    CCSprite *_backFox;
    CCParticleSystemQuad *stars;
    CGPoint touchLocation;
    CCArray *_starArray;
    BOOL isSwipedDown;
    BOOL didTap;
    
    
    
}

@property (nonatomic, strong) CCSprite *gooma1st;
@property (nonatomic, strong) CCSprite *gooma2nd;
@property (nonatomic, strong) CCSprite *frontFox1st;
@property (nonatomic, strong) CCSprite *frontFox2nd;
@property (nonatomic, strong) CCSprite *backFox;
@property (nonatomic, strong) CCSprite *waves1st;
@property (nonatomic, strong) CCSprite *waves2nd;
@property (nonatomic, strong) CCArray *starArray;
@property (nonatomic, strong) CCSprite *hand;
@property (nonatomic, strong) CCSprite *tap;

@end
