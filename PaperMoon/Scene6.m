//
//  Scene6.m
//  PaperMoon
//
//  Created by Andy Woo on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Scene6.h"
#import "Scene6Layer.h"
#import "SettingLayer.h"



@implementation Scene6


+(id) scene
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    CCScene *scene = [CCScene node];
    Scene6Layer *scene6Layer = [Scene6Layer node];
    [scene addChild:scene6Layer z:100 tag:1];
    
    SettingLayer *settingLayer = [SettingLayer node];
    [settingLayer setVisible:NO];
    [scene addChild:settingLayer z:0 tag:2];
    
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
