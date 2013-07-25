//
//  Scene8Layer.h
//  PaperMoon
//
//  Created by Andy Woo on 8/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"

@interface Scene8Layer : CCLayer <UIGestureRecognizerDelegate> {
       CCSpriteFrameCache *frameCache;
    
    CCSprite *_fox;
    CCSprite *_boat;
    CCSprite *_curtainLeft;
    CCSprite *_curtainRight;
    CCSprite *_starsLeft;
    CCSprite *_starsRight;
    
    CCSpriteBatchNode *bnFox;
    CCSpriteBatchNode *bnBoat;
    CCSpriteBatchNode *bnStars;
    BOOL isSwipedDown;
   
    
}

@property (nonatomic, strong) CCSprite *fox;
@property (nonatomic, strong) CCSprite *boat;
@property (nonatomic, strong) CCSprite *curtainLeft;
@property (nonatomic, strong) CCSprite *curtainRight;
@property (nonatomic, strong) CCSprite *starsLeft;
@property (nonatomic, strong) CCSprite *starsRight;




@end
