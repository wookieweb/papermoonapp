//
//  Scene1Layer.m
//  PaperMoon
//
//  Created by Andy Woo on 28/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Scene1Layer.h"
// #import "SceneManager.h"
// #import "CreditViewController.h"
// #import "AppDelegate.h"
// #import "WebViewController.h"

#define kBackground 1


@implementation Scene1Layer





-(id) init
{
    self = [super init];
    if (self != nil)
    {
        
       
        
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
        CCLOG(@"Scene1: Adding background image...");
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        // Background
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
               [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
                CCSprite * background = [CCSprite spriteWithFile:@"scene1_background.pvr.ccz"];
                background.anchorPoint = ccp(0.5,0.5);
                background.position = ccp(screenSize.width/2 ,screenSize.height/2);
                [self addChild:background z:0 tag:kBackground];
                
                /*
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
                CCSprite * settingBar = [CCSprite spriteWithFile:@"scene1_settingBar-568h.pvr.ccz"];
                settingBar.anchorPoint = ccp(0.5,1.0);
                settingBar.position = ccp(screenSize.width/2 ,screenSize.height);
                [self addChild:settingBar z:100 tag:kSettingBar];
                [settingBar setOpacity:0];
                 */
            }
            if(result.height == 568)
            {
               [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
                CCSprite * background = [CCSprite spriteWithFile:@"scene1_background-568h.pvr.ccz"];
                background.anchorPoint = ccp(0.5,0.5);
                background.position = ccp(screenSize.width/2,screenSize.height/2);
                [self addChild:background z:0 tag:kBackground];
                
                /*
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
                CCSprite * settingBar = [CCSprite spriteWithFile:@"scene1_settingBar-568h.pvr.ccz"];
                settingBar.anchorPoint = ccp(0.5,1.0);
                settingBar.position = ccp(screenSize.width/2 ,screenSize.height);
                [self addChild:settingBar z:100 tag:kSettingBar];
                [settingBar setOpacity:0];
                 */
            }
        }
        

      
        /*
        // Top
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
                CCSprite * top = [CCSprite spriteWithFile:@"top.pvr.ccz"];
                top.anchorPoint = ccp(0.5,0.5);
                top.position = ccp(screenSize.width/2,screenSize.height/2);
                [self addChild:top z:50];
            }
            if(result.height == 568)
            {
                CCSprite * top = [CCSprite spriteWithFile:@"top-568h.pvr.ccz"];
                top.anchorPoint = ccp(0.5,0.5);
                top.position = ccp(screenSize.width/2,screenSize.height/2);
                [self addChild:top z:50];
            }
        }
        */
 
        
        /*
        CCLabelTTF *credit = [CCLabelTTF labelWithString:@"Credit"
                                             dimensions:CGSizeMake(100, 25)
                                              hAlignment:UITextAlignmentLeft
                                               fontName:@"Helvetica"
                                               fontSize:16];
        
        CCLabelTTF *flickr = [CCLabelTTF labelWithString:@"Gallery"
                                              dimensions:CGSizeMake(100, 25)
                                              hAlignment:UITextAlignmentLeft
                                                fontName:@"Helvetica"
                                                fontSize:16];
        
        CCLabelTTF *musicToggleOn = [CCLabelTTF labelWithString:@"Music ON"
                                              dimensions:CGSizeMake(100, 25)
                                               hAlignment:UITextAlignmentLeft
                                                fontName:@"Helvetica"
                                                fontSize:16];
        CCLabelTTF *musicToggleOff = [CCLabelTTF labelWithString:@"Music OFF"
                                              dimensions:CGSizeMake(100, 25)
                                               hAlignment:UITextAlignmentLeft
                                                fontName:@"Helvetica"
                                                fontSize:16];
        
        CCMenuItemLabel *creditItem = [CCMenuItemLabel itemWithLabel:credit
                                                             target:self
                                                            selector:@selector(creditButtonTapped:)];
        CCMenuItemLabel *flickrItem = [CCMenuItemLabel itemWithLabel:flickr
                                                              target:self
                                                            selector:@selector(flickrButtonTapped:)];
        CCMenuItemLabel *musicToggleOnLabel = [CCMenuItemLabel itemWithLabel:musicToggleOn];
        CCMenuItemLabel *musicToggleOffLabel = [CCMenuItemLabel itemWithLabel:musicToggleOff];
        
        CCMenuItemToggle *musicToggle = [CCMenuItemToggle itemWithTarget:self
                                                                selector:@selector(musicButtonTapped:)
                                                                   items:musicToggleOnLabel, musicToggleOffLabel, nil];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if([defaults objectForKey:@"music"] == nil)
        {
            [SceneManager sharedSceneManager].isMusicOn = NO;
            CCLOG(@"Don't have default setting yet!");
            //      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:[NSString stringWithFormat:@"%i", [SceneManager sharedSceneManager].isMusicOn] forKey:@"music"];
            [defaults synchronize];
        }
        else
        {
            [SceneManager sharedSceneManager].isMusicOn = (BOOL)[defaults boolForKey:@"music"];
            
        }
        
        if (![SceneManager sharedSceneManager].isMusicOn) {
            [musicToggle setSelectedIndex:1];
            
        }
        else {
            [musicToggle setSelectedIndex:0];
             [[SceneManager sharedSceneManager] playMusic];
        }
        
        CCLabelTTF *shop = [CCLabelTTF labelWithString:@"Shop"
                                            dimensions:CGSizeMake(100, 25)
                                            hAlignment:UITextAlignmentLeft
                                              fontName:@"Helvetica"
                                              fontSize:16];
        CCMenuItemLabel *shopItem = [CCMenuItemLabel itemWithLabel:shop
                                                            target:self
                                                          selector:@selector(shopButtonTapped:)];
    
        CCMenu *menu = [CCMenu menuWithItems:musicToggle, creditItem, flickrItem, shopItem, nil];
        menu.position = ccp(screenSize.width - 60, screenSize.height- 80);
        [menu alignItemsVertically];
        [self addChild:menu];
*/
    }
    return self;
}

-(void)flickrButtonTapped:(id)sender
{
    /*
    [[SceneManager sharedSceneManager] runSceneWithID:kFlickrScene withDirection:kLeft withSender:[self parent]];
*/
     }

-(void)shopButtonTapped:(id)sender
{
    /*
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    WebViewController *webViewController = [[WebViewController alloc] init];
    [[app navController]  presentViewController:webViewController animated:YES completion:nil];
    */
}
/*
-(void) creditButtonTapped:(id)sender
{
  
    CreditViewController* creditViewController = [[CreditViewController alloc] initWithNibName:@"CreditViewController" bundle:nil];
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [[app navController] presentModalViewController:creditViewController animated:YES];
    
}
*/

-(void) musicButtonTapped:(id)sender
{
    /*
    if ([SceneManager sharedSceneManager].isMusicOn == YES)
    {
         [SceneManager sharedSceneManager].isMusicOn = NO;
        [[SceneManager sharedSceneManager] stopMusic];
        CCLOG(@"iSMusicOn = %i", [SceneManager sharedSceneManager].isMusicOn);
        
        // Save music state
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:[NSString stringWithFormat:@"%i", [SceneManager sharedSceneManager].isMusicOn] forKey:@"music"];
		[defaults synchronize];
    }
    else
    {
        [SceneManager sharedSceneManager].isMusicOn = YES;
        [[SceneManager sharedSceneManager] playMusic];
        CCLOG(@"iSMusicOn = %i", [SceneManager sharedSceneManager].isMusicOn);
        
        // Save music state
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:[NSString stringWithFormat:@"%i", [SceneManager sharedSceneManager].isMusicOn] forKey:@"music"];
		[defaults synchronize];
    }
     */
}
/*
- (void)checkMusicSetting {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"music"] == nil)
    {
        [SceneManager sharedSceneManager].isMusicOn = YES;
        CCLOG(@"Don't have default setting yet!");
        //      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:[NSString stringWithFormat:@"%i", [SceneManager sharedSceneManager].isMusicOn] forKey:@"music"];
		[defaults synchronize];
    }
    else
    {
        [SceneManager sharedSceneManager].isMusicOn = (BOOL)[defaults boolForKey:@"music"];

    }
    
    if (![SceneManager sharedSceneManager].isMusicOn) {
        [musicToggle setSelectedIndex:1];

    }
    else {
      [musicToggle setSelectedIndex:0];
    }
}
*/
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
//    [self.music release];
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);

}



@end

