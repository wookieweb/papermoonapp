//
//  LoadingScene.m
//  PaperMoon
//
//  Created by Andy Woo on 2/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LoadingScene.h"
#import "Scene1.h"
#import "Scene2.h"
#import "Scene3.h"
#import "Scene4.h"
#import "Scene5.h"
#import "Scene6.h"
#import "Scene7.h"
#import "Scene8.h"


@interface LoadingScene (PrivateMethods)
-(void) update:(ccTime)delta;
@end

@implementation LoadingScene

+(id) sceneWithTargetScene:(SceneTypes)targetScene;
{
	CCLOG(@"===========================================");
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
	// This creates an autorelease object of self (the current class: LoadingScene)
	return [[self alloc] initWithTargetScene:targetScene];
	
	// Note: this does the exact same, it only replaced self with LoadingScene. The above is much more common.
	//return [[[LoadingScene alloc] initWithTargetScene:targetScene] autorelease];
}

-(id) initWithTargetScene:(SceneTypes)targetScene
{
	if ((self = [super init]))
	{
		targetScene_ = targetScene;
        
		CCLabelTTF* label = [CCLabelTTF labelWithString:@"Loading ..." fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = CGPointMake(size.width / 2, size.height / 2);
		[self addChild:label];
		
		// Must wait one frame before loading the target scene!
		// Two reasons: first, it would crash if not. Second, the Loading label wouldn't be displayed.
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) update:(ccTime)delta
{
	// It's not strictly necessary, as we're changing the scene anyway. But just to be safe.
	[self unscheduleAllSelectors];
	
	// Decide which scene to load based on the TargetScenes enum.
	// You could also use TargetScene to load the same with using a variety of transitions.
	switch (targetScene_)
	{
		case kScene1:
			[[CCDirector sharedDirector] replaceScene:[Scene1 scene]];
			break;
		case kScene2:
			[[CCDirector sharedDirector] replaceScene:[Scene2 scene]];
			break;
        case kScene3:
			[[CCDirector sharedDirector] replaceScene:[Scene3 scene]];
			break;
        case kScene4:
			[[CCDirector sharedDirector] replaceScene:[Scene4 scene]];
			break;
        case kScene5:
			[[CCDirector sharedDirector] replaceScene:[Scene5 scene]];
			break;
        case kScene6:
			[[CCDirector sharedDirector] replaceScene:[Scene6 scene]];
			break;
        case kScene7:
			[[CCDirector sharedDirector] replaceScene:[Scene7 scene]];
			break;
        case kScene8:
			[[CCDirector sharedDirector] replaceScene:[Scene8 scene]];
			break;
		default:
			// Always warn if an unspecified enum value was used. It's a reminder for yourself to update the switch
			// whenever you add more enum values.
			NSAssert2(nil, @"%@: unsupported TargetScene %i", NSStringFromSelector(_cmd), targetScene_);
			break;
	}
	

}

-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// don't forget to call "super dealloc"
}

@end
