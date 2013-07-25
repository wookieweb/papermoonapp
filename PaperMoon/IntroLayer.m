//
//  IntroLayer.m
//  PaperMoon
//
//  Created by Andy Woo on 25/12/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
// #import "HelloWorldLayer.h"
#import "Scene1.h"
#import "Scene2.h"
#import "Scene3.h"
#import "Scene5.h"
#import "Scene4.h"
#import "Scene6.h"
#import "Scene7.h"
#import "Scene8.h"
#import "CreditScene.h"
#import "SceneManager.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) loadSpriteFrames:(id)object
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1_gooma_1st.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1_gooma_2nd.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1_goomaRepeat.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"title.plist"];
    CCLOG(@"Loading Sprite Frames");
    assetLoadCount++;
}

-(void) increaseAssetLoadCount
{
    assetLoadCount++;
    loadingAsset = NO;
}

-(void) loadAssetsThenGotoMainMenu:(ccTime)delta
{
    NSLog(@"load assets %i", assetLoadCount);
    switch (assetLoadCount)
    {
        case 0:
            if (loadingAsset == NO)
            {
                loadingAsset = YES;
                NSLog(@"============= scene1_gooma_1st.pvr.ccz ===============");
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
                [[CCTextureCache sharedTextureCache] addImageAsync:@"scene1_gooma_1st.pvr.ccz"
                                                            target:self
                                                          selector:@selector(increaseAssetLoadCount)];
            }
            break;
        case 1:
            if (loadingAsset == NO)
            {
                loadingAsset = YES;
                NSLog(@"============= scene1_gooma_2nd.pvr.ccz ===============");
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
                [[CCTextureCache sharedTextureCache] addImageAsync:@"scene1_gooma_2nd.pvr.ccz"
                                                            target:self
                                                          selector:@selector(increaseAssetLoadCount)];
            }
            break;
        case 2:
            if (loadingAsset == NO)
            {
                loadingAsset = YES;
                NSLog(@"============= scene1_goomaRepeat.pvr.ccz ===============");
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
                [[CCTextureCache sharedTextureCache] addImageAsync:@"scene1_goomaRepeat.pvr.ccz"
                                                            target:self
                                                          selector:@selector(increaseAssetLoadCount)];
            }
            break;
        case 3:
            if (loadingAsset == NO)
            {
                loadingAsset = YES;
                NSLog(@"============= title.pvr.ccz ===============");
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
                [[CCTextureCache sharedTextureCache] addImageAsync:@"title.pvr.ccz"
                                                            target:self
                                                          selector:@selector(increaseAssetLoadCount)];
            }
            break;
        case 4:
            if (loadingAsset == NO)
            {
                loadingAsset = YES;
                NSLog(@"============= top ===============");
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                {
                    CGSize result = [[UIScreen mainScreen] bounds].size;
                    if(result.height == 480)
                    {
                        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
                        [[CCTextureCache sharedTextureCache] addImageAsync:@"top.pvr.ccz"
                                                                    target:self
                                                                  selector:@selector(increaseAssetLoadCount)];
                    }
                    if(result.height == 568)
                    {
                        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
                        [[CCTextureCache sharedTextureCache] addImageAsync:@"top-568h.pvr.ccz"
                                                                    target:self
                                                                  selector:@selector(increaseAssetLoadCount)];
                    }
                }

            }
            break;
            
        case 5:
            if (loadingAsset == NO)
            {
                loadingAsset = YES;
                [self performSelectorInBackground:@selector(loadSpriteFrames:) withObject:nil];
            }
            break;
            
            // extend with more sequentially numbered cases, as needed
            
            // the default case runs last, loads the next scene
        default:
        {
            [self unscheduleAllSelectors];
        //    MainMenuScene* mainMenuScene = [MainMenuScene node];
        //    [[CCDirector sharedDirector] replaceScene:mainMenuScene];
            [self scheduleOnce:@selector(makeTransition:) delay:0];
        }
            break;
    }
}

// 
-(void) onEnter
{
	[super onEnter];

	// ask director for the window size
	CGSize size = [[CCDirector sharedDirector] winSize];

	
	
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            CCSprite *background;
            background = [CCSprite spriteWithFile:@"Default.png"];
            background.position = ccp(size.width/2, size.height/2);
            background.rotation = 90;
            // add the label as a child to this Layer
            [self addChild: background];
            [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Default.png"];
        }
        if(result.height == 568)
        {
            CCSprite *background;
            background = [CCSprite spriteWithFile:@"Default-568h@2x.png"];
            background.position = ccp(size.width/2, size.height/2);
            background.rotation = 90;
            // add the label as a child to this Layer
            [self addChild: background];
            [[CCTextureCache sharedTextureCache] removeTextureForKey:@"Default-568h@2x.png"];
        }

		
	} else {
        CCSprite *background;
		background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
        background.position = ccp(size.width/2, size.height/2);
        // add the label as a child to this Layer
        [self addChild: background];
	}
	
   
    [self scheduleUpdate];
	
	// In one second transition to the new scene
	// [self scheduleOnce:@selector(makeTransition:) delay:1];
}

-(void) update:(ccTime)deltaTime
{
    [self loadAssetsThenGotoMainMenu:deltaTime];
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


-(void) makeTransition:(ccTime)dt
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[Scene1 scene] withColor:ccBLACK]];
//    [[SceneManager sharedSceneManager] runSceneWithID:kScene1];
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


