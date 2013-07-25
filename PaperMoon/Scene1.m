//
//  Scene1.m
//  PaperMoon
//
//  Created by Andy Woo on 25/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Scene1.h"
#import "AppDelegate.h"
#import "ClippingNode.h"
#import "SettingLayer.h"

@implementation Scene1

+(id) scene
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    CCScene *scene = [CCScene node];
    
    Scene1Layer *scene1Layer = [Scene1Layer node];
    CharacterLayer *characterLayer = [CharacterLayer node];

    
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CGRect rect = CGRectMake(0, -55 , screenSize.width, screenSize.height+55);
    
    ClippingNode *clipNode = [ClippingNode clippingNodeWithRect:rect];
    clipNode.tag = 99;
    
    [clipNode addChild:scene1Layer z:1 tag:0];
    [clipNode addChild:characterLayer z:2 tag:1];
    [scene addChild:clipNode z:1 tag:1];
    
 
    SettingLayer *settingLayer = [SettingLayer node];
    [settingLayer setVisible:NO];
    [scene addChild:settingLayer z:0 tag:2];
    
    return scene;
}

// Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}

-(id) init
{
    self = [super init];
    if (self != nil)
    {

    }
    return self;
}

-(void) onEnter
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super onEnter];
}
-(void) onExit
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super onExit];
  //  [self removeAllChildrenWithCleanup:YES];
}

-(void) onEnterTransitionDidFinish
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super onEnterTransitionDidFinish];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
}

@end
