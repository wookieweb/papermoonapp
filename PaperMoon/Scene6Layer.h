//
//  Scene6Layer.h
//  PaperMoon
//
//  Created by Andy Woo on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"


@class GoomaLayer;
@class Scene6Layer;
@class ObjectsLayer;

@interface Scene6Layer : CCLayer <UIGestureRecognizerDelegate> {
    
    CCSpriteFrameCache *frameCache;
    CGPoint lastTouchLocation;
    bool isTouchForGoomaRepeat;
     BOOL isSwipedDown;
    CGPoint touchLocation;
  //  UIActivityIndicatorView *activityIndicatorView;
}


+(Scene6Layer *) sharedLayer;

@property (weak, readonly) GoomaLayer *goomaLayer;
@property (weak, readonly) Scene6Layer *scene6Layer;
@property (weak, readonly) ObjectsLayer *objectsLayer;

+(CGPoint) locationFromTouch:(UITouch*)touch;

-(void)stopGoomaRepeat;
-(void)startGoomaYelling;
-(void)startGoomaRepeat;

@end
