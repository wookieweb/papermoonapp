//
//  SettingLayer.m
//  PaperMoon
//
//  Created by Andy Woo on 25/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SettingLayer.h"
#import "SceneManager.h"
// #import "SimpleAudioEngine.h"
#import "AppDelegate.h"
// #import "WebViewController.h"
#import "FlickrScene.h"
#import "Scene1.h"
#import "ShopScene.h"
// #import "PayPalViewController.h"
#import "ShopSceneLayer.h"

#define kWrapper 969

@implementation SettingLayer


@synthesize btnShare = _btnShare;
@synthesize btnShop = _btnShop;
@synthesize btnFlickr = _btnFlickr;
@synthesize btnMusic = _btnMusic;
@synthesize btnMusicStopped = _btnMusicStopped;
@synthesize flickrItem = _flickrItem;
@synthesize homeItem = _homeItem;
@synthesize btnHome = _btnHome;
@synthesize shopItem = _shopItem;
// @synthesize btnBack = _btnBack;
// @synthesize btnStop = _btnStop;
// @synthesize btnForward = _btnForward;
// @synthesize backItem = _backItem;
// @synthesize stopItem = _stopItem;
// @synthesize forwardItem = _forwardItem;
@synthesize shareItem = _shareItem;
// @synthesize refreshItem = _refreshItem;
// @synthesize btnRefresh = _btnRefresh;
@synthesize cartItem = _cartItem;
@synthesize btnCart = _btnCart;


-(void)addCartItem:(NSString*)item
{
    [self.btnCart removeChildByTag:999 cleanup:YES];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:item fontName:@"Helvetica" fontSize:14];
    label.anchorPoint = ccp(0.5, 0.5);
    label.position = ccp(15.5, 16.0);
    label.color = ccRED;
    label.tag = 999;
    
    [self.btnCart addChild:label];
}

-(void)removeCartItem
{
    [self.btnCart removeChildByTag:999 cleanup:YES];
    [self.cartItem setOpacity:0];
    self.cartItem.isEnabled = NO;
}

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGSize screenSize = [[CCDirector sharedDirector] winSize];
            if(result.height == 480)
            {
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
                CCSprite * background = [CCSprite spriteWithFile:@"setting-background.pvr.ccz"];
                background.anchorPoint = ccp(0.5,0.5);
                background.position = ccp(screenSize.width/2,screenSize.height/2);
                [self addChild:background z:0];
            }
            if(result.height == 568)
            {
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
                CCSprite * background = [CCSprite spriteWithFile:@"setting-background-568h.pvr.ccz"];
                background.anchorPoint = ccp(0.5,0.5);
                background.position = ccp(screenSize.width/2,screenSize.height/2);
                [self addChild:background z:0];
            }
            
        }
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        [frameCache addSpriteFramesWithFile:@"setting-btn.plist"];
        
        self.btnMusic = [CCSprite spriteWithSpriteFrameName:@"btn-music-hd.png"];
    
        self.btnMusicStopped = [CCSprite spriteWithSpriteFrameName:@"btn-music-stopped-hd.png"];
        
        self.btnHome = [CCSprite spriteWithSpriteFrameName:@"btn-home-hd.png"];
        
        self.btnShare = [CCSprite spriteWithSpriteFrameName:@"btn-share-hd.png"];
     //   self.btnFacebook = [CCSprite spriteWithSpriteFrameName:@"btn-facebook-hd.png"];
    //    CCSprite *btnFacebookSelected = [CCSprite spriteWithSpriteFrameName:@"btn-facebook-hd.png"];
    //    btnFacebookSelected.scale = 1.1;
    //    btnFacebookSelected.position = ccp(btnFacebookSelected.position.x, btnFacebookSelected.position.y+5);
        
        self.btnShop = [CCSprite spriteWithSpriteFrameName:@"btn-shop-hd.png"];
    //    CCSprite *btnShopSelected = [CCSprite spriteWithSpriteFrameName:@"btn-shop-hd.png"];
    //    btnShopSelected.scale = 1.1;
    //    btnShopSelected.position = ccp(btnShopSelected.position.x, btnShopSelected.position.y+5);
        
        self.btnFlickr = [CCSprite spriteWithSpriteFrameName:@"btn-flickr-hd.png"];
     
     //   CCSprite *btnFlickrSelected = [CCSprite spriteWithSpriteFrameName:@"btn-flickr-hd.png"];
     //   btnFlickrSelected.scale = 1.1;
     //   btnFlickrSelected.position = ccp(btnFlickrSelected.position.x, btnFlickrSelected.position.y+2);
        
    //    self.btnStop = [CCSprite spriteWithSpriteFrameName:@"btn-stop-hd.png"];
    //    self.btnBack = [CCSprite spriteWithSpriteFrameName:@"btn-back-hd.png"];
    //    self.btnForward = [CCSprite spriteWithSpriteFrameName:@"btn-forward-hd.png"];
    //    self.btnRefresh = [CCSprite spriteWithSpriteFrameName:@"btn-refresh-hd.png"];
        self.btnCart = [CCSprite spriteWithSpriteFrameName:@"btn-cart-hd.png"];
        
        self.homeItem = [CCMenuItemSprite itemWithNormalSprite:self.btnHome selectedSprite:nil target:self selector:@selector(homeButtonTapped:)];
        
        CCMenuItemSprite *musicItem = [CCMenuItemSprite itemWithNormalSprite:self.btnMusic selectedSprite:nil];
        
        CCMenuItemSprite *musicStoppedItem = [CCMenuItemSprite itemWithNormalSprite:self.btnMusicStopped selectedSprite:nil];
        
        self.shopItem = [CCMenuItemSprite itemWithNormalSprite:self.btnShop selectedSprite:nil target:self selector:@selector(shopButtonTapped:)];
        
        self.shareItem = [CCMenuItemSprite itemWithNormalSprite:self.btnShare selectedSprite:nil target:self selector:@selector(shareButtonTapped:)];
        
        self.flickrItem = [CCMenuItemSprite itemWithNormalSprite:self.btnFlickr selectedSprite:nil target:self selector:@selector(flickrButtonTapped:)];
        
     //   self.backItem = [CCMenuItemSprite itemWithNormalSprite:self.btnBack selectedSprite:nil target:self selector:@selector(backButtonTapped:)];
     //   self.stopItem = [CCMenuItemSprite itemWithNormalSprite:self.btnStop selectedSprite:nil target:self selector:@selector(stopButtonTapped:)];
     //   self.forwardItem = [CCMenuItemSprite itemWithNormalSprite:self.btnForward selectedSprite:nil target:self selector:@selector(forwardButtonTapped:)];

     //   self.refreshItem = [CCMenuItemSprite itemWithNormalSprite:self.btnRefresh selectedSprite:nil target:self selector:@selector(refreshButtonTapped:)];
        self.cartItem = [CCMenuItemSprite itemWithNormalSprite:self.btnCart selectedSprite:nil target:self selector:@selector(cartButtonTapped:)];

        CCMenuItemToggle *musicToggle = [CCMenuItemToggle itemWithTarget:self
                                                                selector:@selector(musicButtonTapped:)
                                                                   items:musicItem, musicStoppedItem, nil];
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
            if (![[SceneManager sharedSceneManager] isPlayingMusic])
                 [[SceneManager sharedSceneManager] playMusic];
        }
        
        CCMenu *menu = [CCMenu menuWithItems:self.homeItem, musicToggle, self.shareItem, self.flickrItem,self.cartItem, self.shopItem, nil];
        menu.position = CGPointZero;
        [menu alignItemsHorizontallyWithPadding:20.0];
  

        
     //   musicToggle.anchorPoint = ccp(0,0.5);
     //   [[[musicToggle subItems] objectAtIndex:0] setContentSize:CGSizeMake(50.0, 50.0)];
     //   [[[musicToggle subItems] objectAtIndex:1] setContentSize:CGSizeMake(50.0, 50.0)];
        
        self.homeItem.anchorPoint = ccp(0.5,0.5);
        [self.homeItem setContentSize:CGSizeMake(50.0, 50.0)];
        
        musicItem.anchorPoint = ccp(0.5,0.5);
        musicStoppedItem.anchorPoint = ccp(0.5, 0.5);
        [musicItem setContentSize:CGSizeMake(50.0, 50.0)];
        [musicStoppedItem setContentSize:CGSizeMake(50.0, 50.0)];
        
        self.shareItem.anchorPoint = ccp(0.5, 0.5);
        [self.shareItem setContentSize:CGSizeMake(50.0, 50.0)];
        
        self.flickrItem.anchorPoint= ccp(0.5,0.5);
        [self.flickrItem setContentSize:CGSizeMake(50.0, 50.0)];
        
        /*
        self.stopItem.anchorPoint = ccp(1, 0.5);
        [self.stopItem setContentSize:CGSizeMake(60.0, 60.0)];
        [self.stopItem setOpacity:0];
        self.stopItem.isEnabled = NO;
        */
        
        self.cartItem.anchorPoint = ccp(1, 0.5);
        [self.cartItem setContentSize:CGSizeMake(50.0, 50.0)];
        [self.cartItem setOpacity:0];
        self.cartItem.isEnabled = NO;
        
        /*
        self.backItem.anchorPoint = ccp(1, 0.5);
        [self.backItem setContentSize:CGSizeMake(50.0, 50.0)];
        [self.backItem setOpacity:0];
        self.backItem.isEnabled = NO;
        
        
        self.forwardItem.anchorPoint = ccp(1, 0.5);
        [self.forwardItem setContentSize:CGSizeMake(50.0, 50.0)];
        [self.forwardItem setOpacity:0];
        self.forwardItem.isEnabled = NO;
        
        self.refreshItem.anchorPoint = ccp(1, 0.5);
        [self.refreshItem setContentSize:CGSizeMake(50.0, 50.0)];
        [self.refreshItem setOpacity:0];
        self.refreshItem.isEnabled = NO;
         */
        
        self.shopItem.anchorPoint = ccp(1, 0.5);
        

        
     //   int startPos = 20;
        float startPos = 43.5;
        
        self.homeItem.position = ccp(startPos, screenSize.height - 15);
        
        self.shareItem.position = ccp(startPos + 50, screenSize.height - 15);
        
        self.flickrItem.position = ccp(startPos + 100, screenSize.height - 15);
        
        musicToggle.position = ccp(startPos + 150, screenSize.height - 15);
        
        self.cartItem.position = ccp(screenSize.width - 90, screenSize.height - 15);
        self.shopItem.position = ccp(screenSize.width - 20, screenSize.height - 25);
       
        [self addChild:menu];
        
        
    }
    return self;
}

-(void) musicButtonTapped:(id)sender
{
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
}

- (void)refreshButtonTapped:(id)sender
{
    CCLOG(@"Refresh button tapped");
    ShopSceneLayer *aShopSceneLayer = (ShopSceneLayer*)[[self parent] getChildByTag:1];
    [aShopSceneLayer refreshPage];
    aShopSceneLayer = nil;
    
}

- (void)cartButtonTapped:(id)sender
{
    CCLOG(@"Cart button tapped");
    /*
    ShopSceneLayer *aShopSceneLayer = (ShopSceneLayer*)[[ShopScene scene] getChildByTag:1];
    [aShopSceneLayer goToCart];
    aShopSceneLayer = nil;
    */
    if ([[[self parent] getChildByTag:1] isKindOfClass:[ShopSceneLayer class]])
        
    {
        ShopSceneLayer *aShopSceneLayer = (ShopSceneLayer*)[[self parent] getChildByTag:1];
        [aShopSceneLayer.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://shop.crazylabel.com/cart"]]];
        aShopSceneLayer = nil;
    }
    else
    {
        // Cocos2d
        AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        app.isSwipeDown = NO;
        app.isLoadCart = YES;
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[ShopScene scene] withColor:ccBLACK]];
        
    }
    
    
}

-(void)stopButtonTapped:(id)sender
{
    /*
    CCLOG(@"Stop button tapped");
    ShopSceneLayer *aShopSceneLayer = (ShopSceneLayer*)[[self parent] getChildByTag:1];
    [aShopSceneLayer stopLoadingShop];
    [aShopSceneLayer stopActivitySpinner];
    aShopSceneLayer = nil;
    
    [self.stopItem setOpacity:0];
    self.stopItem.isEnabled=NO;
    
    [self.refreshItem setOpacity:255];
    self.refreshItem.isEnabled=YES;
    */
}

-(void)forwardButtonTapped:(id)sender
{
    CCLOG(@"Back button tapped");
    ShopSceneLayer *aShopSceneLayer = (ShopSceneLayer*)[[self parent] getChildByTag:1];
    [aShopSceneLayer goForwardShop];
    aShopSceneLayer = nil;
}
-(void)backButtonTapped:(id)sender
{
    CCLOG(@"Back button tapped");
    ShopSceneLayer *aShopSceneLayer = (ShopSceneLayer*)[[self parent] getChildByTag:1];
    [aShopSceneLayer goBackShop];
    aShopSceneLayer = nil;
}

-(void)homeButtonTapped:(id)sender
{
    if ([[[self parent] getChildByTag:1] isKindOfClass:[ShopSceneLayer class]])
    {
        [[[[self parent] getChildByTag:1] getChildByTag:kWrapper] setVisible:NO];
    }
  //  [[CCDirector sharedDirector] resume];
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    app.isSwipeDown = NO;
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[Scene1 scene] withColor:ccBLACK]];

    // [[SceneManager sharedSceneManager] runSceneWithID:kScene1 withDirection:kLeft withSender:[self parent]];
}

-(void)flickrButtonTapped:(id)sender
{
 //   [[CCDirector sharedDirector] resume];
    if ([[[self parent] getChildByTag:1] isKindOfClass:[ShopSceneLayer class]])
    {
        [[[[self parent] getChildByTag:1] getChildByTag:kWrapper] setVisible:NO];
    }
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    app.isSwipeDown = NO;
  //  [[SceneManager sharedSceneManager] runSceneWithID:kFlickrScene withDirection:kLeft withSender:[self parent]];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[FlickrScene scene] withColor:ccBLACK]];

}

-(void)shopButtonTapped:(id)sender
{
    if ([[[self parent] getChildByTag:1] isKindOfClass:[ShopSceneLayer class]])
        
    {
        ShopSceneLayer *aShopSceneLayer = (ShopSceneLayer*)[[self parent] getChildByTag:1];
    //    [aShopSceneLayer.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://shop.crazylabel.com/moon-fox-by-sergey-safonov"]]];
        [aShopSceneLayer goStoreFront];
        aShopSceneLayer = nil;
    }
    else
    {
        // Cocos2d
        AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        app.isSwipeDown = NO;
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[ShopScene scene] withColor:ccBLACK]];
        
    }
    
    // UIKit
    /*
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    WebViewController *webViewController = [[WebViewController alloc] init];
    [[app navController]  presentViewController:webViewController animated:YES completion:nil];
    */
}

-(UIImage*) makeaShot
{
    [CCDirector sharedDirector].nextDeltaTimeZero = YES;
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    CCLayerColor* whitePage = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 0) width:winSize.width height:winSize.height];
    whitePage.position = ccp(winSize.width/2, winSize.height/2);

    CCRenderTexture* rtx = [CCRenderTexture renderTextureWithWidth:winSize.width height:winSize.height];
    [rtx begin];
    [whitePage visit];
    [[[CCDirector sharedDirector] runningScene] visit];

    [rtx end];
    
    return [rtx getUIImage];
}

- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo {
    if (error) {
        // Do anything needed to handle the error or display it to the user
        [self displayAlert:@"There was a problem saving the Image."];
    } else {
        // .... do anything you want here to handle
        // .... when the image has been saved in the photo album
        [self displayAlert:@"Image was saved to Camera Roll."];
    }
}

-(void)captureButtonTapped:(id)sender
{
  //  [[CCDirector sharedDirector] resume];
     if ([SceneManager sharedSceneManager].isMusicOn == YES)
         [[SimpleAudioEngine sharedEngine] playEffect:@"camera.caf" pitch:1.0f pan:1.0f gain:0.5f];

    
    CCMoveBy *moveUp = [CCMoveBy actionWithDuration:0.0 position:ccp(0,+55)];
    CCMoveBy *moveDown = [CCMoveBy actionWithDuration:0.0 position:ccp(0,-55)];
    [[[self parent] getChildByTag:1] runAction:[CCSequence actions:
                                                moveUp,
                                                [CCCallBlock actionWithBlock:^{
        UIImage *image = [self makeaShot];
        UIImageWriteToSavedPhotosAlbum(image,
                                       self, // send the message to 'self' when calling the callback
                                       @selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:), // the selector to tell the method to call on completion
                                       NULL); // you generally won't need a contextInfo here
        
    }],
                                                moveDown,
                                                [CCCallBlock actionWithBlock:^{
        
     //   [[CCDirector sharedDirector] pause];
    }],

                                                nil]];
    

    
}

- (void)shareButtonTapped:(id)sender {
    
    CCMoveBy *moveUp = [CCMoveBy actionWithDuration:0.0 position:ccp(0,+55)];
    CCMoveBy *moveDown = [CCMoveBy actionWithDuration:0.0 position:ccp(0,-55)];
    [[[self parent] getChildByTag:1] runAction:[CCSequence actions:
                                                moveUp,
                                                [CCCallBlock actionWithBlock:^{
    NSArray *activityItems;
    
    
    activityItems = @[@"Meet Moon Fox, a gentle seafarer who floats with the moonlight. #papermoonapp", [self makeaShot]];
  
    
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems
     applicationActivities:nil];
    
        AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        
    [[app navController] presentViewController:activityController
                       animated:YES completion:nil];
    }],
                                                moveDown,
                                                [CCCallBlock actionWithBlock:^{
        
        //   [[CCDirector sharedDirector] pause];
    }],
                                                
                                                nil]];
                                                
}

-(void) displayAlert:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PaperMoon" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark -
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
