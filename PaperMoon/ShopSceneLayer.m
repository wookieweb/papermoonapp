//
//  ShopSceneLayer.m
//  PaperMoon
//
//  Created by Andy Woo on 24/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ShopSceneLayer.h"
#import "CCNode+SFGestureRecognizers.h"
#import "SceneManager.h"
#import "AppDelegate.h"
// #import "WebViewController.h"
#import "SettingLayer.h"
#import "CCShake.h"
#import "TestFlight.h"


#define kWrapper 969


@implementation ShopSceneLayer

@synthesize webView = _webView;


-(void) makeTransitionBack:(ccTime)dt
{
    [[SceneManager sharedSceneManager] runSceneWithID:kFlickrScene withDirection:kRight withSender:[self parent]];
}


-(void) makeTransitionForward:(ccTime)dt
{
    [[SceneManager sharedSceneManager] runSceneWithID:kScene1 withDirection:kLeft withSender:[self parent]];
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];    
}



-(id) init
{
    self = [super init];
    if (self != nil)
    {
        CCLayerColor* colorLayer = [CCLayerColor layerWithColor:ccc4(45, 55, 85, 255) width:568 height:265];
        [self addChild:colorLayer z:1];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
      //  CGRect webFrame = CGRectMake(0, 55, screenSize.width, screenSize.height-55);
        self.webView = [[UIWebView alloc] init];
        self.webView.scalesPageToFit = YES;
        AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        

        
        
        if (!app.isLoadCart)
        {
            // get my bundle local URL
            NSURL *bundleUrl = [[NSBundle mainBundle] bundleURL];
            NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"moon-fox-by-sergey-safonov" ofType:@"html" inDirectory:nil];
            NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
            
            [self.webView loadHTMLString:htmlString baseURL:bundleUrl];
        }
        else
        {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://shop.crazylabel.com/cart"] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30]];
        }
        
        app.isLoadCart = NO;
        wrapper = [CCUIViewWrapper wrapperForUIView:self.webView];
        wrapper.contentSize = CGSizeMake(screenSize.width, screenSize.height-54);
       wrapper.position = ccp(screenSize.width/2 , screenSize.height/2-27);
        wrapper.anchorPoint = ccp(0.5, 0.5);
        [self addChild:wrapper];
        [wrapper setOpacity:0];

        wrapper.tag = kWrapper;



        self.webView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:55.0/255.0 blue:85.0/255.0 alpha:1.0];
        [self.webView setOpaque:YES];
        
     //   AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        
        self.webView.delegate = self;
        
        activityIndicatorView = [[UIActivityIndicatorView alloc]
                                 initWithActivityIndicatorStyle:
                                 UIActivityIndicatorViewStyleGray];
        
        activityIndicatorView.center = ccp(screenSize.width/2, screenSize.height/2);
        [[[CCDirector sharedDirector] view] addSubview: activityIndicatorView];
        [activityIndicatorView startAnimating];

        self.isTouchEnabled = YES;
        
        UISwipeGestureRecognizer *swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
        /*
        UISwipeGestureRecognizer *swipeGestureRecognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
        */
        
        
        [self addGestureRecognizer:swipeGestureRecognizerRight];
        swipeGestureRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
        swipeGestureRecognizerRight.delegate = self;
        
        [self addGestureRecognizer:swipeGestureRecognizerLeft];
        swipeGestureRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        swipeGestureRecognizerLeft.delegate = self;
        /*
        [self addGestureRecognizer:swipeGestureRecognizerDown];
        swipeGestureRecognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
        swipeGestureRecognizerDown.delegate = self;
        
        [self addGestureRecognizer:swipeGestureRecognizerUp];
        swipeGestureRecognizerUp.direction = UISwipeGestureRecognizerDirectionUp;
        swipeGestureRecognizerUp.delegate = self;
*/
        CCSprite *logoShop = [CCSprite spriteWithSpriteFrameName:@"logo-shop-hd.png"];
        logoShop.anchorPoint = ccp(1, 1);
        logoShop.position = ccp(screenSize.width - 50, screenSize.height - 20);
    //    [self addChild:logoShop z:10];
        
        CCSprite *itemMoonFox = [CCSprite spriteWithSpriteFrameName:@"item-moonfox-hd.png"];
        itemMoonFox.anchorPoint = ccp(0.5, 0.5);
        itemMoonFox.position = ccp(screenSize.width/2, screenSize.height/2);
     //   [self addChild:itemMoonFox z:11];
       /*
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGSize screenSize = [[CCDirector sharedDirector] winSize];
            if(result.height == 480)
            {
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
                CCSprite * background = [CCSprite spriteWithFile:@"product.pvr.ccz"];
                background.anchorPoint = ccp(0.5,0.5);
                background.position = ccp(screenSize.width/2,screenSize.height/2);
                [self addChild:background z:4];
            }
            if(result.height == 568)
            {
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
                CCSprite * background = [CCSprite spriteWithFile:@"product.pvr.ccz"];
                background.anchorPoint = ccp(0.5,0.5);
                background.position = ccp(screenSize.width/2,screenSize.height/2);
                [self addChild:background z:4];
            }
            
        }
        */
        /*
        CCLabelTTF *shop = [CCLabelTTF labelWithString:@"Visit Crazylabel Shop"
                                            dimensions:CGSizeMake(200, 25)
                                            hAlignment:CCTextAlignmentLeft
                                              fontName:@"Helvetica"
                                              fontSize:18];
        

        
        shop.color = ccc3(0,0,0);
        CCMenuItemLabel *shopItem = [CCMenuItemLabel itemWithLabel:shop
                                                            target:self
                                                          selector:@selector(shopButtonTapped:)];
        CCMenu *menu = [CCMenu menuWithItems: shopItem, nil];
        menu.anchorPoint = ccp(0.5, 0);
        menu.position = ccp(screenSize.width - 130, 30);
        [menu alignItemsVertically];
        [self addChild:menu z:10];
         */
        
        [activityIndicatorView stopAnimating];
      //   [self loadPayPalButton];
        
        [TestFlight passCheckpoint:@"Shopping Scene"];
    }
    return self;
}



-(void)onExit
{
    [super onExit];
    // cleanup
    
    [self removeChild:wrapper cleanup:true];
    wrapper = nil;

}

-(void) onEnterTransitionDidFinish
{

    
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super onEnterTransitionDidFinish];
    
    SettingLayer *aSettingLayer = (SettingLayer*)[[self parent] getChildByTag:2];
    // disable Share Button
    [aSettingLayer.btnShare setOpacity:100];
    [aSettingLayer.shareItem setIsEnabled:NO];

    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    if (app.cartItem > 0)
    {
        CCLOG(@"cart item = %d", app.cartItem);
        [aSettingLayer.btnCart setOpacity:255];
        [aSettingLayer addCartItem:[NSString stringWithFormat:@"%d", app.cartItem]];
        [aSettingLayer.cartItem setIsEnabled:YES];
    }
    else
    {
        [aSettingLayer.btnCart setOpacity:0];
        [aSettingLayer.cartItem setIsEnabled:NO];
        
    }
    
    aSettingLayer = nil;

    CCFadeIn *fadeInWrapper = [CCFadeIn actionWithDuration:0.5];
    [wrapper runAction:fadeInWrapper];
  
    
     //  [[[CCDirector sharedDirector] view] addSubview:webView];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{

}

#pragma mark - UIWebView delegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    NSURL *Url;
    CCLOG(@"%@",request);
      
    Url = [request URL];
    CCLOG(@"url %@", [Url absoluteString]);
    
    if ([[Url absoluteString] isEqualToString:@"http://shop.crazylabel.com/cart"])
    {
        AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        
        if (app.internetActive)
        {
            CCLOG(@"Notification Says Reachable");
            CCLOG(@"internet active %d", app.internetActive);
        }
        else
        {
            CCLOG(@"Notification Says Unreachable");
            CCLOG(@"reachable %d", app.internetActive);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"You are not connected to the Internet!", @"AlertView")
                                            message:NSLocalizedString(@"Please check your connection and try again...", @"AlertView")
                                            delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"Cancel", @"AlertView")
                                            otherButtonTitles:nil];
            [alertView show];

            return NO;
        }
    }
        
    
    if ([Url.scheme isEqual:@"callback"])
    {
        NSString *urlResources = [Url resourceSpecifier];
      
        
        urlResources = [urlResources stringByReplacingOccurrencesOfString:@"?" withString:@"/"];
        // SEPORATE OUT THE URL ON THE /
        NSArray *urlResourcesArray = [urlResources componentsSeparatedByString:@"/"];
        // THE LAST OBJECT IN THE ARRAY
        NSString *urlParamaters = [urlResourcesArray objectAtIndex:([urlResourcesArray count]-1)];
        // SEPORATE OUT THE URL ON THE &
        NSArray *urlParamatersArray = [urlParamaters componentsSeparatedByString:@"&"];
        if([urlParamatersArray count] == 1) {
            NSString *keyValue = [urlParamatersArray objectAtIndex:(0)];
            NSArray *keyValueArray = [keyValue componentsSeparatedByString:@"="];
            
            if([[keyValueArray objectAtIndex:(0)] isEqualToString:@"cart"]) {
              //  NSLog(@"%@",[keyValueArray objectAtIndex:1]);
                CCLOG(@"cart has %@ item(s)", [keyValueArray objectAtIndex:1]);
                int item = [[keyValueArray objectAtIndex:1] intValue];
                if (item>0)
                    [self cartHaveItem:[keyValueArray objectAtIndex:1]];
                else
                    [self cartHaveNoItem];
            }
        }
        
        return NO;
    }
    else
        return YES;
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CCLOG(@"webView did finished loading");
    
    
  //    CCLOG(@"Shop: %@", [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('prod').innerHTML"]);
    [activityIndicatorView stopAnimating];
    
    /*
    [self disableStopButton];
    
    if (!self.webView.canGoBack)
        [self disableBackButton];
    else
        [self enableBackButton];
    
    if (!self.webView.canGoForward)
        [self disableForwardButton];
    else
        [self enableForwardButton];
    
  */
    
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
 //   CCLOG(@"webView did start loading");
 //   [self enableStopButton];
    [activityIndicatorView startAnimating];
}

-(void)cartHaveNoItem
{
    SettingLayer *aSettingLayer = (SettingLayer*)[[self parent] getChildByTag:2];
    [aSettingLayer removeCartItem];
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    app.cartItem = 0;
    aSettingLayer = nil;
}

-(void)cartHaveItem:(NSString*)item
{
    SettingLayer *aSettingLayer = (SettingLayer*)[[self parent] getChildByTag:2];
  //  [aSettingLayer.btnShop setColor:ccRED];
    aSettingLayer.cartItem.isEnabled = YES;
    [aSettingLayer.btnCart setOpacity:255];
    [aSettingLayer addCartItem:item];
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    app.cartItem = [item intValue];
    aSettingLayer = nil;
}

-(void)goToCart
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://shop.crazylabel.com/cart"]]];
}

-(void)refreshPage
{
    [self.webView reload];
}

-(void)stopLoadingShop
{
    if (self.webView.loading)
        [self.webView stopLoading];
    else
        [self disableStopButton];
}

-(void)stopActivitySpinner
{
    [activityIndicatorView stopAnimating];
}

-(void)goStoreFront
{
    NSURL *bundleUrl = [[NSBundle mainBundle] bundleURL];
    
    // download the html from the server
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"moon-fox-by-sergey-safonov" ofType:@"html" inDirectory:nil];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    // load that html into my web view using a the bundle as the base URL
    
    [self.webView loadHTMLString:htmlString baseURL:bundleUrl];
    
}

-(void)goBackShop
{
    [self.webView goBack];
}

-(void)goForwardShop
{
    [self.webView goForward];
}


-(void)disableForwardButton
{
    /*
    SettingLayer *aSettingLayer = (SettingLayer*)[[self parent] getChildByTag:2];
    [aSettingLayer.btnForward setOpacity:100];
    [aSettingLayer.forwardItem setIsEnabled:NO];
    aSettingLayer = nil;
     */
}

-(void)enableForwardButton
{
    /*
    SettingLayer *aSettingLayer = (SettingLayer*)[[self parent] getChildByTag:2];
    [aSettingLayer.btnForward setOpacity:255];
    [aSettingLayer.forwardItem setIsEnabled:YES];
    aSettingLayer = nil;
     */
}

-(void)disableBackButton
{
    /*
    SettingLayer *aSettingLayer = (SettingLayer*)[[self parent] getChildByTag:2];
    [aSettingLayer.btnBack setOpacity:100];
    [aSettingLayer.backItem setIsEnabled:NO];
    aSettingLayer = nil;
     */
}

-(void)enableBackButton
{
    /*
    SettingLayer *aSettingLayer = (SettingLayer*)[[self parent] getChildByTag:2];
    [aSettingLayer.btnBack setOpacity:255];
    [aSettingLayer.backItem setIsEnabled:YES];
    aSettingLayer = nil;
     */
}

-(void)disableStopButton
{
    /*
    SettingLayer *aSettingLayer = (SettingLayer*)[[self parent] getChildByTag:2];
    [aSettingLayer.btnStop setOpacity:0];
    [aSettingLayer.stopItem setIsEnabled:NO];
    [aSettingLayer.btnRefresh setOpacity:255];
    [aSettingLayer.refreshItem setIsEnabled:YES];
    aSettingLayer = nil;
     */
}

-(void)enableStopButton
{
    /*
    SettingLayer *aSettingLayer = (SettingLayer*)[[self parent] getChildByTag:2];
    [aSettingLayer.btnStop setOpacity:255];
    [aSettingLayer.stopItem setIsEnabled:YES];
    [aSettingLayer.btnRefresh setOpacity:0];
    [aSettingLayer.refreshItem setIsEnabled:NO];

    aSettingLayer = nil;
     */
}

#pragma mark - GestureRecognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //! For swipe gesture recognizer we want it to be executed only if it occurs on the main layer, not any of the subnodes ( main layer is higher in hierarchy than children so it will be receiving touch by default )
    if ([gestureRecognizer class] == [UISwipeGestureRecognizer class]) {
        CGPoint pt = [touch locationInView:touch.view];
        pt = [[CCDirector sharedDirector] convertToGL:pt];
        
        for (CCNode *child in self.children) {
            if ([child isNodeInTreeTouched:pt]) {
                return NO;
            }
        }
    }
    
    return YES;
}

-(void)moveSceneUp
{
    CCCallBlock *turnIsSwipeDownToYes = [CCCallBlock actionWithBlock:^{
        isSwipedDown = NO;
        AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        app.isSwipeDown = NO;
        
    }];
    
    
    CCCallBlock *makeSettingLayerInVisible = [CCCallBlock actionWithBlock:^{
        [[[self parent] getChildByTag:2] setVisible:NO];
    }];

    
    CCMoveBy *moveUp = [CCMoveBy actionWithDuration:0.2 position:ccp(0,+55)];
    
    CCSequence *sequenceUp = [CCSequence actions:
                              moveUp,
                              turnIsSwipeDownToYes,
                              makeSettingLayerInVisible,
                              nil];
    [self runAction:sequenceUp];
}

-(void)handleSwipeUp:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    if (isSwipedDown)
    {
        [self moveSceneUp];
    }
}

-(void)handleSwipeDown:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    if (!isSwipedDown)
    {
        CCCallBlock *writeIsSwipeDown = [CCCallBlock actionWithBlock:^{
            isSwipedDown = YES;
            AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
            app.isSwipeDown = YES;
            
        }];

        CCMoveBy *moveDown = [CCMoveBy actionWithDuration:0.2 position:ccp(0,-55)];
        
        CCCallBlock *makeSettingLayerVisible = [CCCallBlock actionWithBlock:^{
            [[[self parent] getChildByTag:2] setVisible:YES];
        }];
        
        CCSequence *sequenceDown = [CCSequence actions:
                                    makeSettingLayerVisible,
                                    moveDown,
                                    writeIsSwipeDown,
           //                         [CCCallBlock actionWithBlock:^{
                              //          [[CCDirector sharedDirector] pause];
             //                       }],
                                    nil];
        [self runAction:sequenceDown];
    }
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    /*
    [wrapper runAction:[CCFadeOut actionWithDuration:0.1]];
    
    [self scheduleOnce:@selector(makeTransitionBack:) delay:0];
     */
}


-(void)handleSwipeLeft:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    
    if (!isSwipedDown)
    {
   /*
        // CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CCMoveBy *moveSceneRight = [CCMoveBy actionWithDuration:0.2 position:ccp(50, 0)];
        CCEaseIn *easeSceneRight = [CCEaseIn actionWithAction:moveSceneRight rate:2];
        
        CCDelayTime *delayMoveSceneLeft = [CCDelayTime actionWithDuration:0.1];
        
        CCMoveBy *moveSceneLeft = [CCMoveBy actionWithDuration:0.1 position:ccp(-50, 0)];
        CCEaseIn *easeSceneLeft = [CCEaseIn actionWithAction:moveSceneLeft rate:2];
        
        CCShake *shake = [CCShake actionWithDuration:.1f amplitude:ccp(16,0) dampening:true shakes:0];
        
        
        CCSequence *sequenceGiggleScene = [CCSequence actions:
                                           easeSceneLeft,
                                           delayMoveSceneLeft,
                                           easeSceneRight,
                                           shake,
                                           nil];
        
        [[self parent] runAction:sequenceGiggleScene];
    */
    }
    
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
    [activityIndicatorView removeFromSuperview];
    //  [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
}






@end
