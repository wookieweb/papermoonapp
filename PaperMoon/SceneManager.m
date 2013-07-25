//
//  SceneManager.m
//  PaperMoon
//
//  Created by Andy Woo on 27/12/12.
//
//

#import "SceneManager.h"
#import "Scene1.h"
#import "Scene2.h"
#import "Scene3.h"
#import "Scene4.h"
#import "Scene5.h"
#import "Scene6.h"
#import "Scene7.h"
#import "Scene8.h"
#import "StoryScene.h"
#import "CreditScene.h"
#import "ShopScene.h"   
#import "FlickrScene.h"
#import "SimpleAudioEngine.h"
#import "CDAudioManager.h"


@implementation SceneManager

static SceneManager* _sharedSceneManager = nil;
@synthesize isMusicOn;

+(SceneManager *)sharedSceneManager
{
    @synchronized([SceneManager class])
    {
        if (!_sharedSceneManager)
            _sharedSceneManager = [[self alloc] init];
        return _sharedSceneManager;
    }
    
    return nil;
}

+(id)alloc
{
        @synchronized([SceneManager class])
    {
        NSAssert(_sharedSceneManager == nil, @"Attempted to allocate a second instance of the SceneManager singleton");
        _sharedSceneManager = [super alloc];
        return _sharedSceneManager;
    }
    return nil;
}

-(id)init
{
    self = [super init];
    if (self !=nil)
    {
        CCLOG(@"SceneManager singleton, init");
        isMusicOn = YES;
        currentScene = kScene1;

       

 
    }
    return self;
}

-(void)runSceneWithID:(SceneTypes)sceneID withDirection:(Direction)aDirection withSender:(id)sender
{
    CCLOG(@"runSceneWithID");
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    id sceneToRun = nil;
    switch (sceneID) {
        case kScene1:
            sceneToRun = [Scene1 scene];
            CCLOG(@"sceneToRun 1:, %@", sceneToRun);
            break;
        case kScene2:
            sceneToRun = [Scene2 scene];
            CCLOG(@"sceneToRun 2:, %@", sceneToRun);
            break;
        case kScene3:
            sceneToRun = [Scene3 scene];
            CCLOG(@"sceneToRun 3:, %@", sceneToRun);
            break;
        case kScene4:
            sceneToRun = [Scene4 scene];
            CCLOG(@"sceneToRun 4:, %@", sceneToRun);
            break;
        case kScene5:
            sceneToRun = [Scene5 scene];
            CCLOG(@"sceneToRun 5:, %@", sceneToRun);
            break;
        case kScene6:
            sceneToRun = [Scene6 scene];
            CCLOG(@"sceneToRun 6:, %@", sceneToRun);
            break;
        case kScene7:
            sceneToRun = [Scene7 scene];
            CCLOG(@"sceneToRun 7:, %@", sceneToRun);
            break;
        case kScene8:
            sceneToRun = [Scene8 scene];
            CCLOG(@"sceneToRun 8:, %@", sceneToRun);
            break;
        case kStoryScene:
            sceneToRun = [StoryScene scene];
            CCLOG(@"sceneToRun StoryScene:, %@", sceneToRun);
            break;
        case kCreditsScene:
            sceneToRun = [CreditScene scene];
            CCLOG(@"sceneToRun CreditScene:, %@", sceneToRun);
            break;
        case kShopScene:
            sceneToRun = [ShopScene scene];
            CCLOG(@"sceneToRun ShopScene:, %@", sceneToRun);
            break;
        case kFlickrScene:
            sceneToRun = [FlickrScene scene];
            CCLOG(@"sceneToRun FlickrScene:, %@", sceneToRun);
            break;
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    if (sceneToRun == nil)
    {
        currentScene = oldScene;
        return;
    }
    
    if ([[CCDirector sharedDirector] runningScene] == nil)
    {
        CCLOG(@" runningScene, %@", [[CCDirector sharedDirector] runningScene]);
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
    }
    else
    {
      //  
    //    
        if (aDirection == kLeft)
        {
            /*
            CCMoveBy *move = [CCMoveBy actionWithDuration:0.5 position:ccp(0,0)];
        CCScaleBy *scale = [CCScaleBy actionWithDuration:0.1 scale:1.1];
        CCSpawn *spawn = [CCSpawn actions:move,
                          scale,
                          nil];
            [(id)sender runAction:spawn];
             */
    
       //     [[CCDirector sharedDirector] replaceScene:sceneToRun];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.3 scene:sceneToRun]];
    //        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.5 scene:sceneToRun]];
     //       [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:sceneToRun withColor:ccBLACK]];
        }
        else
        {
            /*
            CCMoveBy *move = [CCMoveBy actionWithDuration:0.5 position:ccp(0,0)];
            CCScaleBy *scale = [CCScaleBy actionWithDuration:0.1 scale:1.1];
            CCSpawn *spawn = [CCSpawn actions:move,
                              scale,
                              nil];
            [(id)sender runAction:spawn];
             */
         //   [[CCDirector sharedDirector] replaceScene:sceneToRun];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.3 scene:sceneToRun]];
      //   [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.5 scene:sceneToRun backwards:YES]];
     //   [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:sceneToRun withColor:ccBLACK]];
        }
    }
}

-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen
{
    NSURL *urlToOpen = nil;
    if (linkTypeToOpen == kLinkTypeArtistSite)
    {
        CCLOG(@"Opening Artist Site");
        urlToOpen = [NSURL URLWithString:@"http://www.sergeysafonov.com"];
    }
    else if (linkTypeToOpen == kLinkTypeProducerSite)
    {
        CCLOG(@"Opening Producer Site");
        urlToOpen = [NSURL URLWithString:@"http://www.crazylabel.com"];
    }
    else
    {
        CCLOG(@"Opening Animation Site");
        urlToOpen = [NSURL URLWithString:@"http://www.sergeysafonov.com/moonfox"];
    }
    
    if (![[UIApplication sharedApplication] openURL:urlToOpen])
    {
        CCLOG(@"%@%@", @"Failed to open url:", [urlToOpen description]);
        [self runSceneWithID:kScene1 withDirection:kLeft withSender:[Scene1 scene]];
    }
}

-(void)stopMusic
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [SimpleAudioEngine end];

}

-(void)playMusic
{
    CCLOG(@"Do you hear me? %i", self.isMusicOn);
 
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"backgroundMusic.caf" loop:YES];
    [[SimpleAudioEngine sharedEngine]setBackgroundMusicVolume:0.5f];
            [[CDAudioManager sharedManager]  setResignBehavior:kAMRBStopPlay autoHandle:YES];
    
        

}

-(BOOL)isPlayingMusic
{
    return([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying]);
}


@end
