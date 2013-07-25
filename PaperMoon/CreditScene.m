//
//  CreditScene.m
//  PaperMoon
//
//  Created by Andy Woo on 5/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CreditScene.h"
#import "SettingLayer.h"

@implementation CreditScene


+(id) scene
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    CCScene *scene = [CCScene node];
    CreditSceneLayer *creditSceneLayer = [CreditSceneLayer node];
    [scene addChild:creditSceneLayer z:1 tag:1];
    
    SettingLayer *settingLayer = [SettingLayer node];
    
    [scene addChild:settingLayer z:0 tag:2];
    [settingLayer setVisible:NO];
    return scene;
}

-(id) init
{
    
    if ((self = [super init]))
    {
        
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
