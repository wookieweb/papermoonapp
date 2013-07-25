//
//  Scene4.m
//  PaperMoon
//
//  Created by Andy Woo on 31/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Scene4.h"
#import "ClippingNode.h"
#import "SettingLayer.h"

@implementation Scene4

+(id) scene
{

    
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    CCScene *scene = [CCScene node];
    
    Scene4Layer *scene4Layer = [Scene4Layer node];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CGRect rect = CGRectMake(0, -55, screenSize.width, screenSize.height+55);
    ClippingNode *clipNode = [ClippingNode clippingNodeWithRect:rect];
    [clipNode addChild:scene4Layer];
    clipNode.tag = 99;
    [scene addChild:clipNode z:1 tag:1];
    
    SettingLayer *settingLayer = [SettingLayer node];
     [settingLayer setVisible:NO];
    [scene addChild:settingLayer z:0 tag:2];
    
    
    return scene;
}

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        
    }
    return self;
}

-(void) onExit
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    CCLOG(@"on Exiting Scene4");
    [super onExit];
    [self removeAllChildrenWithCleanup:YES];
    
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
