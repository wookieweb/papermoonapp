//
//  CreditSceneLayer.m
//  PaperMoon
//
//  Created by Andy Woo on 5/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CreditSceneLayer.h"
#import "SceneManager.h"
#import "AppDelegate.h"
// #import "WebViewController.h"
#import "CCNode+SFGestureRecognizers.h"
// #import "SimpleAudioEngine.h"
#import "SettingLayer.h"
#import "CCShake.h"

#define kSpriteSheet 14

@implementation CreditSceneLayer
{
    BOOL didTouch;
}

// @synthesize creditText = _creditText;
// @synthesize cocos2dLogo = _cocos2dLogo;
// @synthesize freesoundLogo = _freesoundLogo;
@synthesize hand = _hand;

-(void) makeTransitionBack
{
    [[SceneManager sharedSceneManager] runSceneWithID:kScene8 withDirection:kRight withSender:[self parent]];
}


-(void) makeTransitionForward
{
    [[SceneManager sharedSceneManager] runSceneWithID:kFlickrScene withDirection:kLeft withSender:[self parent]];
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];

}


-(void) showSwipe
{
    if (didTouch)
        [self unschedule:@selector(showSwipe)];
    
    isShowingSwiping = YES;
    [_hand stopAllActions];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    _hand.anchorPoint = ccp(0.5,0.5);
    _hand.position = ccp(screenSize.width - 50, screenSize.height - 50);
    
    CCFadeIn *fadeInHand = [CCFadeIn actionWithDuration:0.3];
    CCScaleBy *scaleToHand = [CCScaleBy actionWithDuration:0.3 scale:0.8];
    CCSequence *sequenceHand = [CCSequence actions:fadeInHand,
                                scaleToHand,
                                [CCCallBlock actionWithBlock:^{
        [streck setVisible:YES];
        CCMoveBy *moveToHand = [CCMoveBy actionWithDuration:0.5 position:ccp(0.0, -100.0)];
        [_hand runAction:moveToHand];
    }],
                                [CCDelayTime actionWithDuration:0.5],
                                // scaleToHand,
                                [CCCallBlock actionWithBlock:^{
        CCScaleTo *scaleBackHand = [CCScaleTo actionWithDuration:0.3 scale:1];
        [_hand runAction:scaleBackHand];
    }],
                                [CCDelayTime actionWithDuration:0.5],
                                [CCCallBlock actionWithBlock:^{
        CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:0.2];
        [_hand runAction:fadeOut];
    }],
                                [CCCallBlock actionWithBlock:^{
        CCMoveTo *moveToHand = [CCMoveTo actionWithDuration:2.0 position:ccp(screenSize.width - 50, screenSize.height - 50)];
        [streck setVisible:NO];
        [_hand runAction:moveToHand];
    }],
                                nil];
    
    [_hand runAction:sequenceHand];
    
    sequenceHand.tag = 1;
    
    
}

-(void) update:(ccTime)delta
{
    if (!didTouch)
    {
        CGPoint tempPos = _hand.position;
        tempPos.x = tempPos.x - 8;
        tempPos.y = tempPos.y + 18;
        
        streck.position = tempPos;
    }
}

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        

        self.isTouchEnabled = YES;
         isSwipedDown = NO;
        isShowingSwiping = NO;
        didTouch = NO;
        UISwipeGestureRecognizer *swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];

        
        [self addGestureRecognizer:swipeGestureRecognizerRight];
        swipeGestureRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
        swipeGestureRecognizerRight.delegate = self;
        
        [self addGestureRecognizer:swipeGestureRecognizerLeft];
        swipeGestureRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        swipeGestureRecognizerLeft.delegate = self;
        
        [self addGestureRecognizer:swipeGestureRecognizerDown];
        swipeGestureRecognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
        swipeGestureRecognizerDown.delegate = self;
        
        [self addGestureRecognizer:swipeGestureRecognizerUp];
        swipeGestureRecognizerUp.direction = UISwipeGestureRecognizerDirectionUp;
        swipeGestureRecognizerUp.delegate = self;
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
       /*
        [frameCache addSpriteFramesWithFile:@"credit-textandlogo.plist"];
        bnCreditTextAndLogo = [CCSpriteBatchNode batchNodeWithFile:@"credit-textandlogo.pvr.ccz"];
        [self addChild:bnCreditTextAndLogo z:10];
        
        self.creditText = [CCSprite spriteWithSpriteFrameName:@"credit-text-hd.png"];
        _creditText.anchorPoint = ccp(0.5,0.5);
        _creditText.position = ccp(screenSize.width/2,screenSize.height/2 - 50);
        [bnCreditTextAndLogo addChild:_creditText z:1];
        
        self.cocos2dLogo = [CCSprite spriteWithSpriteFrameName:@"credit-cocos2dlogo-hd.png"];
        _cocos2dLogo.anchorPoint = ccp(0.5,0.5);
        _cocos2dLogo.position = ccp(screenSize.width/2,screenSize.height/2 - 360);
        [bnCreditTextAndLogo addChild:_cocos2dLogo z:1];
        
        self.freesoundLogo = [CCSprite spriteWithSpriteFrameName:@"credit-freesound-hd.png"];
        _freesoundLogo.anchorPoint = ccp(0.5,0.5);
        _freesoundLogo.position = ccp(screenSize.width/2,screenSize.height/2 - 420);
        [bnCreditTextAndLogo addChild:_freesoundLogo z:1];
        */
        
        //  Load hand
        [frameCache addSpriteFramesWithFile:@"title.plist"];
        
        spriteSheet = [CCSpriteBatchNode
                       batchNodeWithFile:@"title.pvr.ccz"];
        [self addChild:spriteSheet z:10 tag:kSpriteSheet];
        //  CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.hand = [CCSprite spriteWithSpriteFrameName:@"swipedownfinger-hd.png"];
        //  self.hand = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] textureForKey:@"hand-hd.png"]];
        _hand.anchorPoint = ccp(0.5,0.5);
        //   _hand.position = ccp(screenSize.width - 140,screenSize.height - 200);
        _hand.position = ccp(screenSize.width - 100, screenSize.height - 50);
        _hand.opacity = 0;
        [spriteSheet addChild:_hand z:55];
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        streck = [CCMotionStreak streakWithFade:0.4 minSeg:0.5 width:4 color:ccWHITE textureFilename:@"swipetrail-hd.png"];
        [self addChild:streck z:54];
        [streck setVisible:NO];
        [streck reset];
        
        [self scheduleUpdate];
        
         [self schedule:@selector(showSwipe) interval:5.0 repeat:999 delay:1.0];

        
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            
            if(result.height == 480)
            {
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
                CCSprite * background = [CCSprite spriteWithFile:@"credit-background-small.pvr.ccz"];
                background.anchorPoint = ccp(0.5,0.5);
                background.position = ccp(screenSize.width/2,screenSize.height/2);
                [self addChild:background z:4];
            }
            if(result.height == 568)
            {
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
                CCSprite * background = [CCSprite spriteWithFile:@"credit-background.pvr.ccz"];
                background.anchorPoint = ccp(0.5,0.5);
                background.position = ccp(screenSize.width/2,screenSize.height/2);
                [self addChild:background z:4];
            }
            
        }
        
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
        
  //     [self schedule:@selector(switchCreditText) interval:15.0 repeat:99 delay:20.0];
  //     [self schedule:@selector(switchCreditLogo) interval:15.0 repeat:99 delay:20.0];
        
        
    }
    return self;
}


/*
-(void)switchCreditLogo
{
    [self.cocos2dLogo stopAllActions];
    [self.freesoundLogo stopAllActions];
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCMoveTo *moveUpLogo = [CCMoveTo actionWithDuration:2.0 position:ccp(screenSize.width/2, screenSize.height/2 - 30)];
    CCEaseIn *easeUpLogo = [CCEaseIn actionWithAction:moveUpLogo rate:2];
    
    CCDelayTime *delayLogo = [CCDelayTime actionWithDuration:5.0];
    
    CCMoveTo *moveDownLogo = [CCMoveTo actionWithDuration:2.0 position:ccp(screenSize.width/2, screenSize.height/2 - 360)];
    CCEaseIn *easeDownLogo = [CCEaseIn actionWithAction:moveDownLogo rate:2];
    
    CCSequence *sequenceLogo = [CCSequence actions:
                            easeUpLogo,
                            delayLogo,
                            easeDownLogo,
                            nil];
    
    [self.cocos2dLogo runAction:sequenceLogo];
    
    CCMoveTo *moveUpFreesoundLogo = [CCMoveTo actionWithDuration:2.0 position:ccp(screenSize.width/2, screenSize.height/2 - 90)];
    CCEaseIn *easeUpFreesoundLogo = [CCEaseIn actionWithAction:moveUpFreesoundLogo rate:2];
    
    CCDelayTime *delayFreesoundLogo = [CCDelayTime actionWithDuration:5.0];
    
    CCMoveTo *moveDownFreesoundLogo = [CCMoveTo actionWithDuration:2.0 position:ccp(screenSize.width/2, screenSize.height/2 - 420)];
    CCEaseIn *easeDownFreesoundLogo = [CCEaseIn actionWithAction:moveDownFreesoundLogo rate:2];
    
    CCSequence *sequenceFreesoundLogo = [CCSequence actions:
                                easeUpFreesoundLogo,
                                delayFreesoundLogo,
                                easeDownFreesoundLogo,
                                nil];
    
    [self.freesoundLogo runAction:sequenceFreesoundLogo];
}

-(void)switchCreditText
{
    [self.creditText stopAllActions];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCMoveTo *moveDownText = [CCMoveTo actionWithDuration:2.0 position:ccp(screenSize.width/2, screenSize.height/2 -320)];
    CCEaseIn *easeDownText = [CCEaseIn actionWithAction:moveDownText rate:2];
    
    CCDelayTime *delayText = [CCDelayTime actionWithDuration:5.0];
    
    CCMoveTo *moveUpText = [CCMoveTo actionWithDuration:2.0 position:ccp(screenSize.width/2, screenSize.height/2 - 50)];
    CCEaseIn *easeUpText = [CCEaseIn actionWithAction:moveUpText rate:2];
    
    CCSequence *sequenceText = [CCSequence actions:
                            easeDownText,
                            delayText,
                            easeUpText,
                            nil];
    
    [self.creditText runAction:sequenceText];
}
 */

-(void)onExit
{
    [super onExit];
    
}

-(void)onEnterTransitionDidFinish
{
    SettingLayer *aSettingLayer = (SettingLayer*)[[self parent] getChildByTag:2];
    
    
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
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
 //   [self.tweet release];
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
   
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
                                    [CCCallBlock actionWithBlock:^{
            didTouch = YES;
            [_hand setVisible:NO];
            [streck setVisible:NO];
            [streck reset];
                                    }],
                                    nil];
        [self runAction:sequenceDown];
    }
}

-(void)handleSwipeLeft:(UISwipeGestureRecognizer *)aGestureRecognizer
{

//    [self scheduleOnce:@selector(makeTransitionForward:) delay:0];
    
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
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer *)aGestureRecognizer
{

    [self makeTransitionBack];
}


@end
