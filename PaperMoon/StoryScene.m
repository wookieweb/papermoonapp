//
//  StoryScene.m
//  PaperMoon
//
//  Created by Andy Woo on 20/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "StoryScene.h"
#import "StorySceneLayer.h"


@implementation StoryScene




+(id) scene
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    CCScene *scene = [CCScene node];
    StorySceneLayer *storySceneLayer = [StorySceneLayer node];
    [scene addChild:storySceneLayer z:1 tag:0];
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


@end
