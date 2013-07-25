//
//  SettingLayer.h
//  PaperMoon
//
//  Created by Andy Woo on 25/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
// #import <Twitter/Twitter.h>
// #import <FacebookSDK/FacebookSDK.h>

@interface SettingLayer : CCLayer {
    
    CCSprite *_btnShare;
 //   CCSprite *_btnCamera;
    CCSprite *_btnShop;
    CCSprite *_btnFlickr;
    CCSprite *_btnMusic;
    CCSprite *_btnMusicStopped;
    CCSprite *_btnHome;
 //   CCSprite *_btnBack;
 //   CCSprite *_btnStop;
 //   CCSprite *_btnForward;
 //   CCSprite *_btnRefresh;
    CCSprite *_btnCart;
    
    CCMenuItemSprite *_flickrItem;
    CCMenuItemSprite *_homeItem;
    CCMenuItemSprite *_shopItem;
 //   CCMenuItemSprite *_backItem;
 //   CCMenuItemSprite *_forwardItem;
 //   CCMenuItemSprite *_stopItem;
    CCMenuItemSprite *_shareItem;
 //   CCMenuItemSprite *_refreshItem;
    CCMenuItemSprite *_cartItem;
    
    CCSpriteFrameCache *frameCache;
    CCSpriteBatchNode *bnBtns;
    
    
}


@property (nonatomic, strong) CCSprite *btnShare;
@property (nonatomic, strong) CCSprite *btnShop;
@property (nonatomic, strong) CCSprite *btnFlickr;
@property (nonatomic, strong) CCSprite *btnMusic;
@property (nonatomic, strong) CCSprite *btnMusicStopped;
@property (nonatomic, strong) CCSprite *btnHome;
// @property (nonatomic, strong) CCSprite *btnStop;
// @property (nonatomic, strong) CCSprite *btnBack;
// @property (nonatomic, strong) CCSprite *btnForward;
// @property (nonatomic, strong) CCSprite *btnRefresh;
@property (nonatomic, strong) CCSprite *btnCart;
@property (nonatomic, strong) CCMenuItemSprite *flickrItem;
@property (nonatomic, strong) CCMenuItemSprite *homeItem;
@property (nonatomic, strong) CCMenuItemSprite *shopItem;
// @property (nonatomic, strong) CCMenuItemSprite *backItem;
// @property (nonatomic, strong) CCMenuItemSprite *stopItem;
// @property (nonatomic, strong) CCMenuItemSprite *forwardItem;
@property (nonatomic, strong) CCMenuItemSprite *shareItem;
// @property (nonatomic, strong) CCMenuItemSprite *refreshItem;
@property (nonatomic, strong) CCMenuItemSprite *cartItem;

-(void)addCartItem:(NSString*)item;
-(void)removeCartItem;

@end
