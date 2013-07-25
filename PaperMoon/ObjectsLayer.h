//
//  ObjectsLayer.h
//  PaperMoon
//
//  Created by Andy Woo on 6/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"


@interface ObjectsLayer : CCLayer {
    
    CCSpriteFrameCache *frameCache;
    CCSpriteBatchNode *bnOthers;
    CCSpriteBatchNode *bnCurtainOpenRepeat;
    CCSpriteBatchNode *bnCurtainClosing;
    CCSpriteBatchNode *bnSky;


    CCSprite *_string;
    CCSprite *_flash;
    BOOL windowState;
    BOOL currentState;
    BOOL didPullString;
    CCAnimation *reverseAnimationAction;
    CCSprite *fox;
    CCSprite *_curtainOpenRepeat;
    CCSprite *_curtainClosing;
    CCSprite *_sky;
    CCSprite *_sun;
    CCSprite *_curtainClosedRepeatLeft;
    CCSprite *_curtainClosedRepeatRight;
    CCSprite *_rod;
    CCSprite *_flower;
    
}


@property (nonatomic, strong) CCSprite *string;
@property (nonatomic, strong) CCSprite *flash;
@property (nonatomic, strong) CCSprite *curtainOpenRepeat;
@property (nonatomic, strong) CCSprite *curtainClosing;
@property (nonatomic, strong) CCSprite *sky;
@property (nonatomic, strong) CCSprite *sun;
@property (nonatomic, strong) CCSprite *curtainClosedRepeatLeft;
@property (nonatomic, strong) CCSprite *curtainClosedRepeatRight;
@property (nonatomic, strong) CCSprite *rod;
@property (nonatomic, strong) CCSprite *flower;

-(BOOL) isTouchForMe:(CGPoint)touchLocation;
-(void)toggleWindow;
-(void)animateString;

-(void)freezeAllObjectsLayer;
-(void)unFreezeAllObjectsLayer;
@end
