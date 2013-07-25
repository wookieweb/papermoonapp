//
//  CreditSceneLayer.h
//  PaperMoon
//
//  Created by Andy Woo on 5/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface CreditSceneLayer : CCLayer <UIGestureRecognizerDelegate> {
    BOOL isSwipedDown;
    BOOL isShowingSwiping;
 //   CCSpriteBatchNode *bnCreditTextAndLogo;
 //   CCSprite *_creditText;
 //    CCSprite *_cocos2dLogo;
 //   CCSprite *_freesoundLogo;
    CCSprite *_hand;
    CCSpriteBatchNode *spriteSheet;
    CCMotionStreak *streck;
  //  UIActivityIndicatorView *activityIndicatorView;
}

// @property (nonatomic, strong) CCSprite *creditText;
// @property (nonatomic, strong) CCSprite *cocos2dLogo;
// @property (nonatomic, strong) CCSprite *freesoundLogo;
@property (nonatomic, strong) CCSprite *hand;
@end
