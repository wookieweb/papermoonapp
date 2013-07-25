//
//  ShopScene.m
//  PaperMoon
//
//  Created by Andy Woo on 24/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ShopScene.h"

#import "ShopSceneLayer.h"
#import "SettingLayer.h"

@implementation ShopScene

+(id) scene
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    CCScene *scene = [CCScene node];
    ShopSceneLayer *shopSceneLayer = [ShopSceneLayer node];
    [scene addChild:shopSceneLayer z:1 tag:1];
    
    SettingLayer *settingLayer = [SettingLayer node];
    [scene addChild:settingLayer z:0 tag:2];
    [settingLayer setVisible:YES];
    
    return scene;
}

-(id) init
{
    
    if ((self = [super init]))
    {
      //  [self addChild:[CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)] z:0];
    }
    
    return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    //    [self.gooma release];
    //   [self.fox release];
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
}


@end
