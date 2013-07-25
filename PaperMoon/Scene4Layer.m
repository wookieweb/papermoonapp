//
//  Scene4Layer.m
//  PaperMoon
//
//  Created by Andy Woo on 31/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Scene4Layer.h"
#import "SceneManager.h"
#import "CCNode+SFGestureRecognizers.h"
#import "ClippingNode.h"
#import "AppDelegate.h"
#import "SettingLayer.h"


#define kTagWave 0
#define kTagFlippedWave 111

#define kBoat 1
#define kGooma1st 2
#define kGooma2nd 3
#define kFox 5
#define kFox2nd 6
// #define kWave 7
// #define kFlippedWave 8
#define kFrontWave 9

#define kBnBoat 10
#define kBnGooma1st 11
#define kBnGooma2nd 12
#define kBnGooma3rd 13
#define kBnFox 14
#define kBnWave 15
#define kSpriteSheet 16

@implementation Scene4Layer

@synthesize boat = _boat;
@synthesize gooma1st = _gooma1st;
@synthesize gooma2nd = _gooma2nd;
@synthesize fox = _fox;
@synthesize fox2nd = _fox2nd;
@synthesize wave = _wave;
@synthesize flippedWave = _flippedWave;
@synthesize frontWave = _frontWave;
@synthesize tap = _tap;
@synthesize hand = _hand;


-(void) makeTransitionBack
{
    [[SceneManager sharedSceneManager] runSceneWithID:kScene3 withDirection:kRight withSender:[self parent]];
}


-(void) makeTransitionForward
{
    [[SceneManager sharedSceneManager] runSceneWithID:kScene5 withDirection:kLeft withSender:[self parent]];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
}

-(void) cleanUpGooma1st
{
    [_gooma1st removeFromParentAndCleanup:YES];
}

-(void)showFox2nd
{
    [_fox removeFromParentAndCleanup:YES];
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 24; i <= 41; ++i)  // was 63
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene4_fox%d.png", i]]];
    }
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.045f];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
     [animFrames removeAllObjects];
      [anim setRestoreOriginalFrame:NO];
    
    self.fox2nd = [CCSprite spriteWithSpriteFrameName:@"scene4_fox24.png"];
    
    _fox2nd.position = ccp(screenSize.width/2+11, screenSize.height/2+25);
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];

    [_fox2nd runAction:animate];
    
    [bnFox addChild:_fox2nd];
    _fox2nd.tag = kFox2nd;
}


-(void)showFox1st
{
    // Animation with Fox 1st
    if ([[CCAnimationCache sharedAnimationCache] animationByName:@"fox1st"] == nil)
    {
        NSMutableArray *animFrames = [NSMutableArray array];
        for(int i = 1; i <= 23; ++i)  // was 1 to 23
        {
            [animFrames addObject:
             [frameCache spriteFrameByName:
              [NSString stringWithFormat:@"scene4_fox%d.png", i]]];
            
        }
        
        
        CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.05f];
        [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"fox1st"];
         [anim setRestoreOriginalFrame:NO];
        [animFrames removeAllObjects];
    }

    
    CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"fox1st"]];
    
    id reverse = [animate reverse];
   
    [_fox runAction:reverse];
    
}




-(void)showGooma2nd
{
    [_gooma1st removeFromParentAndCleanup:YES];
    [_gooma2nd setVisible:YES];
    
 //   CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
        NSMutableArray *animFrames = [NSMutableArray array];
        for(int i = 12; i <= 24; ++i) // was 27
        {
            [animFrames addObject:
             [frameCache spriteFrameByName:
              [NSString stringWithFormat:@"scene4_gooma%d.png", i]]];
        }
        CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.07f];
        [anim setRestoreOriginalFrame:NO];
        [animFrames removeAllObjects];

    CCAnimate *animate = [CCAnimate actionWithAnimation: anim];
    
    
    CCSequence *sequence = [CCSequence actions:
                        //    [CCDelayTime actionWithDuration:0.8],
                            animate,
                            nil];
    
     [_gooma2nd runAction:sequence];
}


-(void)showGooma1st
{
    [_gooma1st stopAllActions];
    // Animation with Gooma 1st
    if ([[CCAnimationCache sharedAnimationCache] animationByName:@"gooma1st"] == nil)
    {
        NSMutableArray *animFrames = [NSMutableArray array];
        for(int i = 1; i <= 11; ++i)
        {
            [animFrames addObject:
             [frameCache spriteFrameByName:
              [NSString stringWithFormat:@"scene4_gooma%d.png", i]]];
            
        }
        CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.05f];
         [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"gooma1st"];
        [anim setRestoreOriginalFrame:NO];
        [animFrames removeAllObjects];
    }
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"gooma1st"]];
    [_gooma1st runAction:animate]; // Pause for screenshot
}

-(void)reverseGooma1st
{
    CCAnimate *reverse = (CCAnimate*)[[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"gooma1st"]] reverse];
    CCSpeed *speed = [CCSpeed actionWithAction:reverse speed:3.0f];
    [_gooma1st runAction:speed];
}


-(void)upBoatMovement
{
    int angleLeft;
    int angleRight;
    [_boat stopAllActions];
    angleLeft = arc4random() % 5;
    angleRight = arc4random() % 6;
    while (angleLeft == 0)
    {
        angleLeft = arc4random() % 5;
    }
    while (angleRight == 0)
    {
        angleRight = arc4random() % 6;
    }

    CCRotateTo *rockLeft = [CCRotateTo actionWithDuration:3 angle:angleLeft];
    CCRotateTo *rockRight = [CCRotateTo actionWithDuration:3 angle:-angleRight];
    CCSequence *sequence = [CCSequence actions:rockLeft, rockRight, nil];
    CCAction *repeat = [CCRepeatForever actionWithAction:sequence];
    [_boat runAction:repeat];
}

-(void)showFrontWave
{
    // Animation for Front Wave
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 40; ++i)
    {
        [animFrames addObject:
        [frameCache spriteFrameByName:
        [NSString stringWithFormat:@"scene4_frontwave%d.png", i]]];
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.10f];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.frontWave = [CCSprite spriteWithSpriteFrameName:@"scene4_frontwave1.png"];
    [animFrames removeAllObjects];
    
    _frontWave.anchorPoint = ccp(0.5,0.5);
    _frontWave.position = ccp(screenSize.width/2, screenSize.height/2);
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    [bnWave addChild:_frontWave z:10];
    _frontWave.tag = kFrontWave;
    
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
    [_frontWave runAction:repeat]; // Pause for screenshot
    [animFrames removeAllObjects];
}

-(void) showHand
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    _hand.anchorPoint = ccp(0.5,0.5);
    _hand.position = ccp(screenSize.width/2 + 140,screenSize.height/2 + 80);
    _tap.position = ccp(_hand.position.x - 17.0 - 5 - 35, _hand.position.y + 17.0 + 40);
    CCScaleBy *scaleUpTap = [CCScaleBy actionWithDuration:0.1 scale:1.2];
    CCScaleTo *scaleToTap = [CCScaleTo actionWithDuration:0.1 scale:1.0];
    CCSequence *sequenceTap = [CCSequence actions:scaleUpTap, scaleToTap, nil];
    CCFadeIn *fadeInHand = [CCFadeIn actionWithDuration:0.3];
    CCScaleBy *scaleToHand = [CCScaleBy actionWithDuration:0.5 scale:0.8];
    CCSequence *sequenceHand = [CCSequence actions:fadeInHand,
                                [CCCallBlock actionWithBlock:^{
        CCMoveBy *moveToHand = [CCMoveBy actionWithDuration:0.3 position:ccp(-40.0, 40.0)];
        
        [_hand runAction:moveToHand];
    }],
                                [CCDelayTime actionWithDuration:0.5],
                                scaleToHand,
                                [CCCallBlock actionWithBlock:^{
        
        CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:0.1];
        CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:0.5];
        CCSequence *sequence = [CCSequence actions:
                                fadeIn,
                                sequenceTap,
                                [CCCallBlock actionWithBlock:^{
           [self showGooma1st];
        }],
                                fadeOut,
                                nil];
        [_tap runAction:sequence];
        
    }],
                                [CCCallBlock actionWithBlock:^{
        CCScaleTo *scaleBackHand = [CCScaleTo actionWithDuration:0.5 scale:1];
        [_hand runAction:scaleBackHand];
    }],
                                [CCDelayTime actionWithDuration:0.5],
                                [CCCallBlock actionWithBlock:^{
        CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:0.5];
        [_hand runAction:fadeOut];
    }],
                                [CCCallBlock actionWithBlock:^{
        CCMoveTo *moveToHand = [CCMoveTo actionWithDuration:2.0 position:ccp(screenSize.width/2 + 140,screenSize.height/2 + 80)];
        [_hand runAction:moveToHand];
    }],
                                nil];
    
    [_hand runAction:sequenceHand];
    
    sequenceHand.tag = 1;
    
}


-(void)startAnimation
{
    didCapture = NO;
    didTouched = NO;
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    // Boat
    self.boat = [CCSprite spriteWithFile:@"scene4_boat.pvr.ccz"];
    _boat.anchorPoint = ccp(0.5,0.5);
    _boat.position = ccp(screenSize.width/2,screenSize.height/2+20);
    _boat.scaleX = 1.03f;
    _boat.scaleY = 1.03f;
    [self addChild:_boat z:3];
    _boat.tag = kBoat;
    
    int angleLeft = arc4random() % 4;   // Left hand side
    int angleRight = arc4random() % 5;  // Right hand side
    CCRotateTo *rockLeft = [CCRotateTo actionWithDuration:3 angle:angleLeft];
    CCRotateTo *rockRight = [CCRotateTo actionWithDuration:3 angle:-angleRight];
    CCSequence *sequence = [CCSequence actions:rockLeft, rockRight, nil];
    CCAction *repeat = [CCRepeatForever actionWithAction:sequence];
    
    [_boat runAction:repeat]; // Pause for screenshot
    
    // Background
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
            CCSprite * background = [CCSprite spriteWithFile:@"scene4_background.pvr.ccz"];
            background.anchorPoint = ccp(0,1);
            background.position = ccp(0,screenSize.height);
            [self addChild:background z:0];
        }
        if(result.height == 568)
        {
            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
            CCSprite * background = [CCSprite spriteWithFile:@"scene4_background-568h.pvr.ccz"];
            background.anchorPoint = ccp(0,1);
            background.position = ccp(0,screenSize.height);
            [self addChild:background z:0];
        }
    }
    
    // Big Wave
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            self.wave = [CCSprite spriteWithFile:@"scene4_bigwave.pvr.ccz"];
            
            _wave.anchorPoint = ccp(0,0);
            _wave.position = ccp(0,-10);
            
            self.flippedWave = [CCSprite spriteWithFile:@"scene4_bigwave.pvr.ccz"];
            _flippedWave.anchorPoint = ccp(0, 0);
            _flippedWave.position = ccp(screenSize.width, -10);
            _flippedWave.flipX = YES;
            
            [self addChild:_wave z:5 tag:kTagWave];
            [self addChild:_flippedWave z:5 tag: kTagFlippedWave];
        }
        if(result.height == 568)
        {
            self.wave = [CCSprite spriteWithFile:@"scene4_bigwave-568h.pvr.ccz"];
            _wave.anchorPoint = ccp(0,0);
            _wave.position = ccp(0,-10);
            
            self.flippedWave = [CCSprite spriteWithFile:@"scene4_bigwave-568h.pvr.ccz"];
            _flippedWave.anchorPoint = ccp(0, 0);
            _flippedWave.position = ccp(screenSize.width, -10);
            _flippedWave.flipX = YES;
            [self addChild:_wave z:5 tag:kTagWave];
            [self addChild:_flippedWave z:5 tag: kTagFlippedWave];
        }
    }
    
    // Wave
    [frameCache addSpriteFramesWithFile:@"scene4_frontwave.plist"];
    bnWave = [CCSpriteBatchNode batchNodeWithFile:@"scene4_frontwave.pvr.ccz"];
    [self addChild:bnWave z:10 tag:kBnWave];
    
    // Gooma 1st
    [frameCache addSpriteFramesWithFile:@"scene4_gooma_1st.plist"];
    bnGooma1st = [CCSpriteBatchNode batchNodeWithFile:@"scene4_gooma_1st.pvr.ccz"];
    [self addChild:bnGooma1st z:8 tag:kBnGooma1st];
    self.gooma1st = [CCSprite spriteWithSpriteFrameName:@"scene4_gooma1.png"];
    _gooma1st.anchorPoint = ccp(0.5,1);
    _gooma1st.position = ccp(screenSize.width/2, screenSize.height);
    [bnGooma1st addChild:_gooma1st];
    _gooma1st.tag = kGooma1st;
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 2; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene4_gooma%d.png", i]]];
        
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:5.0f];
    [anim setRestoreOriginalFrame:NO];
    [animFrames removeAllObjects];
    CCAnimate *animateGooma = [CCAnimate actionWithAnimation: anim];
    [_gooma1st runAction:[CCRepeatForever actionWithAction: animateGooma]]; // Pause for screenshot
    
    // Gooma 2nd
    [frameCache addSpriteFramesWithFile:@"scene4_gooma_2nd.plist"];
    bnGooma2nd = [CCSpriteBatchNode batchNodeWithFile:@"scene4_gooma_2nd.pvr.ccz"];
    [self addChild:bnGooma2nd z:8 tag:kBnGooma2nd];
    
    self.gooma2nd = [CCSprite spriteWithSpriteFrameName:@"scene4_gooma12.png"];
    _gooma2nd.anchorPoint = ccp(0.5,1);
    _gooma2nd.position = ccp(screenSize.width/2, screenSize.height);
    [_gooma2nd setVisible:YES];
    [bnGooma2nd addChild:_gooma2nd];
    _gooma2nd.tag = kGooma2nd;
    [_gooma2nd setVisible:NO];
    
    
    // Fox
    [frameCache addSpriteFramesWithFile:@"scene4_fox_1st.plist"];
    bnFox = [CCSpriteBatchNode batchNodeWithFile:@"scene4_fox_1st.pvr.ccz"];
    [self addChild:bnFox z:7 tag:kBnFox];
    self.fox = [CCSprite spriteWithSpriteFrameName:@"scene4_fox1.png"];
    
    _fox.anchorPoint = ccp(1, 0.5);

    _fox.position = ccp(screenSize.width, screenSize.height/2-20);
     [bnFox addChild:_fox];
    _fox.tag = kFox;
    
    isJumping = NO;
    
    int angleFoxLeft = arc4random() % 3;   // Left hand side
    int angleFoxRight = arc4random() % 4;  // Right hand side
    CCRotateTo *rockFoxLeft = [CCRotateTo actionWithDuration:1 angle:angleFoxLeft];
    CCRotateTo *rockFoxRight = [CCRotateTo actionWithDuration:1 angle:-angleFoxRight];
    CCSequence *sequenceFox = [CCSequence actions:
                               rockFoxLeft,
                               rockFoxRight, nil];
    CCAction *repeatFox = [CCRepeatForever actionWithAction:sequenceFox];
    
    [_fox runAction:repeatFox];

    
 
    [self showFrontWave];
    
    [frameCache addSpriteFramesWithFile:@"title.plist"];
    
    spriteSheet = [CCSpriteBatchNode
                   batchNodeWithFile:@"title.pvr.ccz"];
    [self addChild:spriteSheet z:10 tag:kSpriteSheet];
    
    //  Load hand
    self.hand = [CCSprite spriteWithSpriteFrameName:@"hand-hd.png"];
    _hand.anchorPoint = ccp(0.5,0.5);
    _hand.position = ccp(screenSize.width/2 + 140,screenSize.height/2 + 80);
    _hand.opacity = 0;
    [spriteSheet addChild:_hand z:55];
    self.tap = [CCSprite spriteWithSpriteFrameName:@"tap-hd.png"];
    _tap.anchorPoint = ccp(0.5,0.5);
    _tap.position = ccp(_hand.position.x - 17.0 - 5, _hand.position.y + 17.0 + 50);
    _tap.opacity = 0;
    [spriteSheet addChild:_tap z:50];
    
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
    [self schedule:@selector(upBoatMovement) interval:1.0f];

    [self scheduleUpdate]; // Pause for screenshot
    
 //    [self schedule:@selector(showHand) interval:5.0 repeat:999 delay:1.0]; // To be deleted
  //  [self freezeAllObjects];
    
    
}

-(void)freezeAllObjects
{
    [self pauseSchedulerAndActions];
    
    if ([[self getChildByTag:kBnFox] getChildByTag:kFox2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnFox] getChildByTag:kFox2nd]];
    }
    
    if ([[self getChildByTag:kBnGooma2nd] getChildByTag:kGooma2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGooma2nd] getChildByTag:kGooma2nd]];
    }
    
    if ([[self getChildByTag:kBnWave] getChildByTag:kFrontWave] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnWave] getChildByTag:kFrontWave]];
    }
    
    if ([self getChildByTag:kBoat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[self getChildByTag:kBoat]];
    }
    
    if ([self getChildByTag:kTagWave] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[self getChildByTag:kTagWave]];
    }
    
    if ([self getChildByTag:kTagFlippedWave] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[self getChildByTag:kTagFlippedWave]];
    }
    
    if ([[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st]];
    }
    
    if ([[self getChildByTag:kBnFox] getChildByTag:kFox] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnFox] getChildByTag:kFox]];
    }

}

-(void)unFreezeAllObjects
{
    [self resumeSchedulerAndActions];
  
    if ([[self getChildByTag:kBnFox] getChildByTag:kFox2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnFox] getChildByTag:kFox2nd]];
    }
    
    if ([[self getChildByTag:kBnGooma2nd] getChildByTag:kGooma2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGooma2nd] getChildByTag:kGooma2nd]];
    }
    
    if ([[self getChildByTag:kBnWave] getChildByTag:kFrontWave] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnWave] getChildByTag:kFrontWave]];
    }
    
    if ([self getChildByTag:kBoat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[self getChildByTag:kBoat]];
    }
    
    if ([self getChildByTag:kTagWave] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[self getChildByTag:kTagWave]];
    }
    
    if ([self getChildByTag:kTagFlippedWave] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[self getChildByTag:kTagFlippedWave]];
    }
    
    if ([[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st]];
    }
    
    if ([[self getChildByTag:kBnFox] getChildByTag:kFox] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnFox] getChildByTag:kFox]];
    }
}

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        self.isTouchEnabled = YES;
        isSwipedDown = NO;
        didCatch = NO;
        UISwipeGestureRecognizer *swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
        
        UISwipeGestureRecognizer *swipeGestureRecognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
        
   //     UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];

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
        
        /*
        [self addGestureRecognizer:tapGestureRecognizer];
        tapGestureRecognizer.numberOfTapsRequired = 1;
         */
        
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
        
    }
    return self;
}

-(void) update:(ccTime)delta
{
    CGPoint pos = _wave.position;
    CGPoint pos_flipped = _flippedWave.position;
    pos_flipped.x -= delta * 50;
    pos.x -= delta * 50;
    
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    // Reposition wave when they are out of bounds
    if (pos.x < -screenSize.width)
    {
        pos.x += screenSize.width * 2;
    }
    if (pos_flipped.x < -screenSize.width)
    {
        pos_flipped.x += screenSize.width * 2;
    }

    _wave.position = pos;
    _flippedWave.position = pos_flipped;
    
    CGPoint foxPos = _fox.position;
    foxPos.x = foxPos.x - 0.5;
    _fox.position = CGPointMake(foxPos.x, _fox.position.y);
    
    // Reposition wave when they are out of bounds
    if (foxPos.x < 0)
    {
        foxPos.x += screenSize.width + _fox.contentSize.width;
    }
    _fox.position = foxPos;
    
    
    if ((_fox.position.x < (screenSize.width/2 + _fox.contentSize.width/2 + 37)) && (!didCatch))
        {
            [self showGooma1st];
            didCatch = YES;
        }
    
    if ((_fox.position.x < (screenSize.width/2 + _fox.contentSize.width/2 + 20)) && (_fox.position.x > (screenSize.width/2 - _fox.contentSize.width/2 + 50)) && (!didCapture))
    {

        [self showFox2nd];
        [self showGooma2nd];
        didCapture = YES;
        
        // Effects to be deleted
        
        // CCLOG(@"Fox position %f", _fox.position.x);
        //     CCParticleSystemQuad *effect = [CCParticleSystemQuad particleWithFile:@"scene4_captured.plist"];
        //     [self addChild:effect z:100 tag:999];
        //     effect = nil;
        
    }
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
            preload = [CCSprite spriteWithFile:@"scene4.pvr.ccz"];
            [preload setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
            [self addChild:preload z:99 tag:99];
        }
        if(result.height == 568)
        {
            CCSprite *preload;
            preload = [CCSprite spriteWithFile:@"scene4-568h.pvr.ccz"];
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
    
    CCFadeTo *fadeTo = [CCFadeTo actionWithDuration:0.1 opacity:0];
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
    
    [self scheduleOnce:@selector(startAnimation) delay:0.0];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [self unscheduleAllSelectors];
  //  [self removeAllChildrenWithCleanup:YES];
    
     [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    //   [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    // [[self parent] removeFromParentAndCleanup:YES];
   
    
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
    CCMoveBy *moveClippingNodeUp = [CCMoveBy actionWithDuration:0.2 position:ccp(0,+55)];
    
    CCSequence *sequenceUp = [CCSequence actions:
                              moveClippingNodeUp,
                              turnIsSwipeDownToYes,
                              makeSettingLayerInVisible,
                              nil];
    [[[[self parent] parent] getChildByTag:1] runAction:sequenceUp];
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
        
        [[[[self parent] parent] getChildByTag:1] runAction:sequenceDown];
    }
}


-(void)handleSwipeLeft:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    [self freezeAllObjects];
    [self makeTransitionForward];
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    [self freezeAllObjects];
    [self makeTransitionBack];
}

/*
-(void)handleTap:(UITapGestureRecognizer *)aGestureRecognizer
{

}
 */

@end
