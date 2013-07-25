//
//  Scene8Layer.m
//  PaperMoon
//
//  Created by Andy Woo on 8/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Scene8Layer.h"
#import "SceneManager.h"
#import "CCNode+SFGestureRecognizers.h"
#import "ClippingNode.h"
#import "AppDelegate.h"
#import "UIDevice+Hardware.h"
#import "SettingLayer.h"

 #define IPHONE4 ([[[UIDevice currentDevice] hardwareDescription] isEqualToString:@"iPhone 4"] || [[[UIDevice currentDevice] hardwareDescription] isEqualToString:@"iPhone 4 (CDMA)"])

#define kFox 1
#define kBoat 2
#define kBnFox 3
#define kBnBoat 4

@implementation Scene8Layer

@synthesize fox = _fox;
@synthesize boat = _boat;
@synthesize curtainLeft = _curtainLeft;
@synthesize curtainRight = _curtainRight;
@synthesize starsLeft = _starsLeft;
@synthesize starsRight = _starsRight;



-(void) makeTransitionBack
{
    
    
    [[SceneManager sharedSceneManager] runSceneWithID:kScene7 withDirection:kRight withSender:[self parent]];
}


-(void) makeTransitionForward
{
  
    
    [[SceneManager sharedSceneManager] runSceneWithID:kCreditsScene withDirection:kLeft withSender:[self parent]];
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /*
    UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
  //  CGSize winSize = [CCDirector sharedDirector].winSize;
*/
    
    
}

-(void)showBoatRepeat
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.boat = [CCSprite spriteWithSpriteFrameName:@"scene8_boat1.png"];
    _boat.anchorPoint = ccp(0.5, 0.5);
    _boat.position = ccp(screenSize.width/2, screenSize.height/2);
    _boat.tag = kBoat;
    [bnBoat addChild:_boat z:5];
    
    if (!IPHONE4)
    {
        // Animation with Fox Repeat
        
        NSMutableArray *animFrames = [NSMutableArray array];
        for(int i = 1; i <= 40; ++i)
        {
            [animFrames addObject:
             [frameCache spriteFrameByName:
              [NSString stringWithFormat:@"scene8_boat%d.png", i]]];
            
        }
        
        
        CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
        [animFrames removeAllObjects];
        CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
        [anim setRestoreOriginalFrame:NO];
        
        CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
        
        [_boat runAction:repeat];  // Pause for screenshot
    }
}

-(void)showFoxRepeat
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.fox = [CCSprite spriteWithSpriteFrameName:@"scene8_fox1.png"];
    _fox.anchorPoint = ccp(0.5, 0.5);
    _fox.position = ccp(screenSize.width/2, screenSize.height/2);
    _fox.tag = kFox;
    [bnFox addChild:_fox];

    if (!IPHONE4)
    {
        // Animation with Fox Repeat
        
        NSMutableArray *animFrames = [NSMutableArray array];
        for(int i = 1; i <= 16; ++i)
        {
            [animFrames addObject:
             [frameCache spriteFrameByName:
              [NSString stringWithFormat:@"scene8_fox%d.png", i]]];
            
        }
        
        
        CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.20f];
        [animFrames removeAllObjects];
        CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
        [anim setRestoreOriginalFrame:NO];

        CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
        
        [_fox runAction:repeat];  // Pause for screenshot
    }
}


-(void)doCurtainLeft
{
 
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    self.curtainLeft = [CCSprite spriteWithFile:@"scene8_curtainLeft.pvr.ccz"];
    _curtainLeft.anchorPoint = ccp(0,1);
    _curtainLeft.position = ccp(0,screenSize.height);
    [self addChild:_curtainLeft z:5];
    
    // Stars Left
    self.starsLeft = [CCSprite spriteWithSpriteFrameName:@"scene8_starsLeft.png"];
    [self addChild:_starsLeft z:6];
    _starsLeft.anchorPoint = ccp(0,0);
    _starsLeft.position = ccp(0,0);
    
}

-(void)doCurtainRight
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    self.curtainRight = [CCSprite spriteWithFile:@"scene8_curtainRight.pvr.ccz"];
    _curtainRight.anchorPoint = ccp(1,1);
    _curtainRight.position = ccp(screenSize.width,screenSize.height);
    [self addChild:_curtainRight z:5];
        
    // Stars Right
    self.starsRight = [CCSprite spriteWithSpriteFrameName:@"scene8_starsRight.png"];
    [self addChild:_starsRight z:6];
    _starsRight.anchorPoint = ccp(1,0);
    _starsRight.position = ccp(screenSize.width, 0);

}

-(void)unFreezeAllObjects
{
    [self resumeSchedulerAndActions];
    
    if ([[self getChildByTag:kBnFox] getChildByTag:kFox] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnFox] getChildByTag:kFox]];
    }
}

-(void)freezeAllObjects
{
    [self pauseSchedulerAndActions];
    
    if ([[self getChildByTag:kBnFox] getChildByTag:kFox] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnFox] getChildByTag:kFox]];
    }
}

-(void)startAnimation
{

        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    // Background
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
            CCSprite * background = [CCSprite spriteWithFile:@"scene8_background-568h.pvr.ccz"];
            background.anchorPoint = ccp(0.5,0.5);
            background.position = ccp(screenSize.width/2,screenSize.height/2);
            [self addChild:background z:4 tag:kLayerTagBackground];
        }
        if(result.height == 568)
        {
            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
            CCSprite * background = [CCSprite spriteWithFile:@"scene8_background-568h.pvr.ccz"];
            background.anchorPoint = ccp(0.5,0.5);
            background.position = ccp(screenSize.width/2,screenSize.height/2);
            [self addChild:background z:4 tag:kLayerTagBackground];
        }
    }
    
    // Fox
    [frameCache addSpriteFramesWithFile:@"scene8_fox.plist"];
    bnFox = [CCSpriteBatchNode batchNodeWithFile:@"scene8_fox.pvr.ccz"];
    [self addChild:bnFox z:8 tag:kBnFox];
    
    // Boat
    [frameCache addSpriteFramesWithFile:@"scene8_boat.plist"];
    bnBoat = [CCSpriteBatchNode batchNodeWithFile:@"scene8_boat.pvr.ccz"];
    [self addChild:bnBoat z:8 tag:kBnBoat];
    
    // Pot
    CCSprite * pot = [CCSprite spriteWithSpriteFrameName:@"scene8_pot.png"];
    pot.anchorPoint = ccp(0.5,0.5);
    pot.position = ccp(screenSize.width/2,screenSize.height/2);
    [bnBoat addChild:pot z:10];
    
    [self showBoatRepeat];
    [self showFoxRepeat];
    
    // Curtains

    [frameCache addSpriteFramesWithFile:@"scene8_stars.plist"];
    [self doCurtainLeft];
    [self doCurtainRight];
    
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
    
  //  [self freezeAllObjects];
    
}

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        self.isTouchEnabled = YES;
        isSwipedDown = NO;;
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
 
    }
    return self;
}

-(void) onEnter
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super onEnter];
    
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            CCSprite *preload;
            preload = [CCSprite spriteWithFile:@"scene8.pvr.ccz"];
            [preload setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
            [self addChild:preload z:99 tag:99];
        }
        if(result.height == 568)
        {
            CCSprite *preload;
            preload = [CCSprite spriteWithFile:@"scene8-568h.pvr.ccz"];
            [preload setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
            [self addChild:preload z:99 tag:99];
        }
    
    }
    

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

    CCFadeTo *fadeTo = [CCFadeTo actionWithDuration:0.5 opacity:0];
    [[self getChildByTag:99] runAction:fadeTo];
    
    SettingLayer *aSettingLayer = (SettingLayer*)[[[self parent] parent] getChildByTag:2];
 
    
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
    
    [self startAnimation];
 
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);

    //   [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    //    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
  
    
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
        [[[[self parent] parent] getChildByTag:2] setVisible:NO];
    }];
  
    ClippingNode *clippingNote = (ClippingNode*)[[[self parent] parent] getChildByTag:1];
    
    CCMoveBy *moveClippingNodeUp = [CCMoveBy actionWithDuration:0.2 position:ccp(0,+55)];
    

    CCSequence *sequenceUp = [CCSequence actions:
                              moveClippingNodeUp,
                              turnIsSwipeDownToYes,
                              makeSettingLayerInVisible,
                              nil];
    [clippingNote runAction:sequenceUp];
}

-(void)handleSwipeUp:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    if (isSwipedDown)
    {
        [self unFreezeAllObjects];
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
    
       
        ClippingNode *clippingNote = (ClippingNode*)[[[self parent] parent] getChildByTag:1];
        
        CCMoveBy *moveClippingNodeDown = [CCMoveBy actionWithDuration:0.2 position:ccp(0,-55)];
        
        CCCallBlock *makeSettingLayerVisible = [CCCallBlock actionWithBlock:^{
            [[[[self parent] parent] getChildByTag:2] setVisible:YES];
        }];

        CCSequence *sequenceDown = [CCSequence actions:
                                    makeSettingLayerVisible,
                                    moveClippingNodeDown,
                                    writeIsSwipeDown,
                                    [CCCallBlock actionWithBlock:^{
            [self freezeAllObjects];
                                    }],
                                    nil];
        [clippingNote runAction:sequenceDown];
    }
}


-(void)handleSwipeLeft:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    [self makeTransitionForward];
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    [self makeTransitionBack];
}


@end
