//
//  Scene5Layer.h
//  PaperMoon
//
//  Created by Andy Woo on 3/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Scene5Layer : CCLayer <UIGestureRecognizerDelegate> {
    
    CCSpriteFrameCache *frameCache;
    
    CCSprite *_gooma1st;
    CCSprite *_gooma2nd;
    CCSprite *_tree;
    CCSprite *_lightOn;
    CCSprite *_door;
    CCSprite *_topGreen;
    CCSprite *_bird;
    CCSprite *_redMonster;
    CCSprite *_redMonsterRepeat;
    CCSprite *_cloudSmall;
    CCSprite *_cloudBig;
 //   CCSprite *_smallBlue;
    CCSprite *_smallBlueRepeat;
    CCSpriteBatchNode *bnGooma1st;
    CCSpriteBatchNode *bnGooma2nd;
    CCSpriteBatchNode *bnOthers;
    CCSpriteBatchNode *bnTopGreen;
    CCSpriteBatchNode *bnDoor;
    CCSpriteBatchNode *bnRedMonsterRepeat;
    CCSpriteBatchNode *bnCloud;
    CCSpriteBatchNode *bnSmallBlue;
    CGPoint touchLocation;
    BOOL isLightOn;
    BOOL isSwipedDown;

    
}

@property (nonatomic, strong) CCSprite *gooma1st;
@property (nonatomic, strong) CCSprite *gooma2nd;
@property (nonatomic, strong) CCSprite *tree;
@property (nonatomic, strong) CCSprite *lightOn;
@property (nonatomic, strong) CCSprite *door;
@property (nonatomic, strong) CCSprite *topGreen;
@property (nonatomic, strong) CCSprite *bird;
@property (nonatomic, strong) CCSprite *redMonster;
@property (nonatomic, strong) CCSprite *redMonsterRepeat;
@property (nonatomic, strong) CCSprite *cloudSmall;
@property (nonatomic, strong) CCSprite *cloudBig;
// @property (nonatomic, strong) CCSprite *smallBlue;
@property (nonatomic, strong) CCSprite *smallBlueRepeat;


@end
