//
//  Scene3Layer.h
//  PaperMoon
//
//  Created by Andy Woo on 28/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Scene2.h"

@interface Scene3Layer : CCLayer <UIGestureRecognizerDelegate> {
    CCSprite *_bigFox1st;
    CCSprite *_bigFox2nd;
    CCSprite *_gooma1st;
    CCSprite *_gooma2nd;
    CCSprite *_backFox;
    CCSprite *_smallFox;
    CCSprite *_frontFox1st;
    CCSprite *_frontFox2nd;
    CCSpriteFrameCache *frameCache;
    CCSpriteBatchNode *spriteSheet1;
    CCSpriteBatchNode *spriteSheet2;
    CCSpriteBatchNode *spriteSheet3;
    CCSpriteBatchNode *spriteSheet4;
    CCSpriteBatchNode *spriteSheet6;
    CCSpriteBatchNode *spriteSheet7;
    BOOL isSwipedDown;
}

@property (nonatomic, strong) CCSprite *bigFox1st;
@property (nonatomic, strong) CCSprite *bigFox2nd;
@property (nonatomic, strong) CCSprite *frontFox1st;
@property (nonatomic, strong) CCSprite *frontFox2nd;
@property (nonatomic, strong) CCSprite *gooma1st;
@property (nonatomic, strong) CCSprite *gooma2nd;
@property (nonatomic, strong) CCSprite *backFox;
@property (nonatomic, strong) CCSprite *smallFox;

@end
