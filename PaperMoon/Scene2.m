//
//  Scene2.m
//  PaperMoon
//
//  Created by Andy Woo on 25/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Scene2.h"
#import "SettingLayer.h"


@implementation Scene2

+(id) scene
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    CCScene *scene = [CCScene node];
    
    
    Scene2Layer *scene2Layer = [Scene2Layer node];
    [scene addChild:scene2Layer z:1 tag:1];
    
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

-(void) update:(ccTime)delta
{
 
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
 //    [self.gooma release];
 //   [self.fox release];
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
  
}
@end
