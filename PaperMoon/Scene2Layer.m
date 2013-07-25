//
//  Scene2Layer.m
//  PaperMoon
//
//  Created by Andy Woo on 28/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Scene2Layer.h"
#import "SceneManager.h"
#import "CCNode+SFGestureRecognizers.h"
#import "SimpleAudioEngine.h"
#import "AppDelegate.h"
#import "Star.h"
#import "SettingLayer.h"
#import "UIDevice+Hardware.h"

#define BASE 50
#define kGooma1st 1
#define kGooma2nd 2
#define kFrontFox1st 3
#define kFrontFox2nd 4
#define kBackFox 5
#define kWave1st 6
#define kWave2nd 7

#define kSpriteSheet 5
#define kSpriteSheet1 3
#define kSpriteSheet2 4
#define kSpriteSheet3 1
#define kSpriteSheet4 2
#define kSpriteSheet5 6

#define IPHONE4 ([[[UIDevice currentDevice] hardwareDescription] isEqualToString:@"iPhone 4"] || [[[UIDevice currentDevice] hardwareDescription] isEqualToString:@"iPhone 4 (CDMA)"])

@implementation Scene2Layer

@synthesize gooma1st = _gooma1st;
@synthesize gooma2nd = _gooma2nd;
@synthesize frontFox1st = _frontFox1st;
@synthesize frontFox2nd = _frontFox2nd;
@synthesize backFox = _backFox;
@synthesize waves1st = _waves1st;
@synthesize waves2nd = _waves2nd;
@synthesize starArray = _starArray;
@synthesize hand = _hand;
@synthesize tap = _tap;


-(void) makeTransitionBack
{
     [[SceneManager sharedSceneManager] runSceneWithID:kScene1 withDirection:kRight withSender:[self parent]];
}


-(void) makeTransitionForward
{
     [[SceneManager sharedSceneManager] runSceneWithID:kScene3 withDirection:kLeft withSender:[self parent]];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCLOG(@"Scene2: Touches Began...");
    UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
    touchLocation = location;
    
}

-(void)showBackFox
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.backFox = [CCSprite spriteWithSpriteFrameName:@"scene2_backfox1.png"];
    _backFox.tag = kBackFox;
    _backFox.anchorPoint = ccp(0.5,0);
    _backFox.position = ccp(screenSize.width/2, 0);
    [spriteSheet1 addChild:_backFox];
    
    if (!IPHONE4)
    {
        // Animation with back Fox
        
        NSMutableArray *animFrames = [NSMutableArray array];
        for(int i = 1; i <= 10; ++i)
        {
            [animFrames addObject:
             [frameCache spriteFrameByName:
              [NSString stringWithFormat:@"scene2_backfox%d.png", i]]];
        }
        
        CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.22f];
        [animFrames removeAllObjects];
        [anim setRestoreOriginalFrame:NO];
        
        CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
        CCAction *repeat = [CCRepeatForever actionWithAction:animate];
        [_backFox runAction:repeat]; // Pause for screenshot
    }
}


-(void)showWaves2nd
{
    [_waves1st removeFromParentAndCleanup:YES];
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 18; i <= 53; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene2_waves%d.png", i]]];
    }
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:kSCENE2WAVESPEED];
    [animFrames removeAllObjects];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    self.waves2nd = [CCSprite spriteWithSpriteFrameName:@"scene2_waves16.png"];
    _waves2nd.position = ccp(winSize.width/2, winSize.height/2);
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    CCAction *repeat = [CCRepeatForever actionWithAction:animate];
    [_waves2nd runAction:repeat];
    [spriteSheet5 addChild:_waves2nd];
    _waves2nd.tag = kWave2nd;
}

-(void)showWaves
{
    
    // Animation with Waves 1st
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 15; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene2_waves%d.png", i]]];
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:kSCENE2WAVESPEED];
    [animFrames removeAllObjects];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    self.waves1st = [CCSprite spriteWithSpriteFrameName:@"scene2_waves1.png"];
    _waves1st.position = ccp(winSize.width/2, winSize.height/2);
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    CCSequence *sequence = [CCSequence actions:animate, [CCCallFunc actionWithTarget:self selector:@selector(showWaves2nd)], nil];
    [_waves1st runAction:sequence]; // Pause for screenshot
    [spriteSheet5 addChild:_waves1st];
    _waves1st.tag = kWave1st;
}

-(void)showFox2nd
{    
    [_frontFox1st removeFromParentAndCleanup:YES];
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 21; i <= 40; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene2_frontfox%d.png", i]]];
    }
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.11f];
    [animFrames removeAllObjects];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    self.frontFox2nd = [CCSprite spriteWithSpriteFrameName:@"scene2_frontfox21.png"];
    _frontFox2nd.position = ccp(winSize.width/2, winSize.height/2);
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    CCAction *repeat = [CCRepeatForever actionWithAction:animate];
    [_frontFox2nd runAction:repeat];
    [spriteSheet2 addChild:_frontFox2nd];
    _frontFox2nd.tag = kFrontFox2nd;
}

-(void)showFox1st
{
    [[CCTextureCache sharedTextureCache] addImageAsync:@"scene2_frontfox_2nd.pvr.ccz" target:self selector:@selector(frontfox_2ndDidLoad:)]; // Async load
    
    // Animation with Fox 1st

    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 20; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene2_frontfox%d.png", i]]];
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.11f];
    [animFrames removeAllObjects];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    self.frontFox1st = [CCSprite spriteWithSpriteFrameName:@"scene2_frontfox1.png"];
    _frontFox1st.position = ccp(winSize.width/2, winSize.height/2);
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    CCSequence *sequence = [CCSequence actions:animate, [CCCallFunc actionWithTarget:self selector:@selector(showFox2nd)], nil];
    [_frontFox1st runAction:sequence];  // Pause for screenshot
    [spriteSheet1 addChild:_frontFox1st];
    _frontFox1st.tag = kFrontFox1st;
}


-(void) animGooma
{
    [_gooma1st removeFromParentAndCleanup:YES];
    
    NSMutableArray *animFrames1 = [NSMutableArray array];
    for(int j = 21; j <= 40; ++j)
    {
        [animFrames1 addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene2_gooma%d.png", j]]];
    }
    CCAnimation *anim1 = [CCAnimation animationWithSpriteFrames:animFrames1 delay:0.1f];
    [animFrames1 removeAllObjects];
    self.gooma2nd = [CCSprite spriteWithSpriteFrameName:@"scene2_gooma21.png"];
    _gooma2nd.anchorPoint = ccp(0,0);
    _gooma2nd.position = ccp(0, 30);
    CCAnimate *animate1 = [CCAnimate actionWithAnimation:anim1];
    [anim1 setRestoreOriginalFrame:NO];
    
    CCAction *repeat = [CCRepeatForever actionWithAction:animate1];
    [_gooma2nd runAction:repeat];
    [spriteSheet4 addChild:_gooma2nd];
    _gooma2nd.tag = kGooma2nd;
}

-(void)showGooma
{
    [[CCTextureCache sharedTextureCache] addImageAsync:@"scene2_gooma_2nd.pvr.ccz" target:self selector:@selector(gooma_2ndDidLoad:)]; // Async load

    // Animation with Gooma
    // CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];

    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 20; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene2_gooma%d.png", i]]];
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.11f];
    self.gooma1st = [CCSprite spriteWithSpriteFrameName:@"scene2_gooma1.png"];
    _gooma1st.anchorPoint = ccp(0,0);
    _gooma1st.position = ccp(0, 30);
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    CCSequence *sequence = [CCSequence actions:animate, [CCCallFunc actionWithTarget:self selector:@selector(animGooma)], nil];
    [_gooma1st runAction:sequence]; // Pause for screenshot
    [spriteSheet3 addChild:_gooma1st];
    _gooma1st.tag = kGooma1st;
    [animFrames removeAllObjects];
}

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        self.isTouchEnabled = YES;
        isSwipedDown = NO;
    
        UISwipeGestureRecognizer *swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        
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
        
        [self addGestureRecognizer:tapGestureRecognizer];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    }
    return self;
}

/*
-(void) update:(ccTime)delta
{
    
}
*/

-(void) wavesDidLoad:(CCTexture2D*) texture
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"scene2_waves_1st.plist" texture:(CCTexture2D*)texture];
    spriteSheet5 = [CCSpriteBatchNode batchNodeWithTexture:texture];
    [self addChild:spriteSheet5 z:4 tag:kSpriteSheet5];
    [self showWaves];
}

-(void) spriteDidLoad:(CCTexture2D*) texture
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"scene2_frontfox_1st.plist" texture:(CCTexture2D*)texture];
    spriteSheet1 = [CCSpriteBatchNode batchNodeWithTexture:texture];
    [self addChild:spriteSheet1 z:2 tag:kSpriteSheet1];
     [self showBackFox];
     [self showFox1st];
}

-(void) frontfox_2ndDidLoad:(CCTexture2D*) texture
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"scene2_frontfox_2nd.plist" texture:(CCTexture2D*)texture];
    spriteSheet2 = [CCSpriteBatchNode batchNodeWithTexture:texture];
    [self addChild:spriteSheet2 z:3 tag:kSpriteSheet2];
}

-(void) gooma_1stDidLoad:(CCTexture2D*) texture
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"scene2_gooma_1st.plist" texture:(CCTexture2D*)texture];
    spriteSheet3 = [CCSpriteBatchNode batchNodeWithTexture:texture];
    [self addChild:spriteSheet3 z:5 tag:kSpriteSheet3];
    [self showGooma];
}

-(void) gooma_2ndDidLoad:(CCTexture2D*) texture
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"scene2_gooma_2nd.plist" texture:(CCTexture2D*)texture];
    spriteSheet4 = [CCSpriteBatchNode batchNodeWithTexture:texture];
    [self addChild:spriteSheet4 z:5 tag:kSpriteSheet4];
}

-(void) showHand
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    _hand.anchorPoint = ccp(0.5,0.5);
    _hand.position = ccp(screenSize.width/2 + 50,screenSize.height - 150);
   
    CCScaleBy *scaleUpTap = [CCScaleBy actionWithDuration:0.1 scale:1.2];
    CCScaleTo *scaleToTap = [CCScaleTo actionWithDuration:0.1 scale:1.0];
    CCSequence *sequenceTap = [CCSequence actions:scaleUpTap, scaleToTap, nil];
    CCFadeIn *fadeInHand = [CCFadeIn actionWithDuration:0.1];
    CCScaleBy *scaleToHand = [CCScaleBy actionWithDuration:0.5 scale:0.8];
    CCSequence *sequenceHand = [CCSequence actions:fadeInHand,
                                [CCCallBlock actionWithBlock:^{

        int adjX = -BASE + arc4random() % (BASE - (-BASE));
        int adjY = -BASE + arc4random() % (BASE - (-BASE));
        CCMoveBy *moveToHand = [CCMoveBy actionWithDuration:0.3 position:ccp(-50.0 + adjX, 50.0 + adjY)];
        [_hand runAction:moveToHand];
    }],
                                [CCDelayTime actionWithDuration:0.3],
                                scaleToHand,
                                [CCCallBlock actionWithBlock:^{
        CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:0.1];
        CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:0.5];
        _tap.position = ccp(_hand.position.x - 17.0, _hand.position.y + 17.0);
        
        // Create a random star
        CCNode *thisStar = [Star node];
        [thisStar setPosition:ccp(_hand.position.x - 17.0, _hand.position.y + 17.0)];
        [self addChild:thisStar];
   //     CCLOG(@"star object %@", thisStar);
        int randDelayTime = 5 + arc4random() % (10 - 5);
        id action1 = [CCDelayTime actionWithDuration:randDelayTime];
        id cleanupAction = [CCCallBlock actionWithBlock:^{
            [thisStar removeFromParentAndCleanup:YES];
        }];
        id seq = [CCSequence actions:
                  action1,
                  cleanupAction,
                  nil];
        [thisStar runAction:seq];
        
        CCSequence *sequence = [CCSequence actions:
                                fadeIn,
                                sequenceTap,
                                fadeOut,
                                nil];
        [_tap runAction:sequence];
        
    }],
                                [CCCallBlock actionWithBlock:^{
        CCScaleTo *scaleBackHand = [CCScaleTo actionWithDuration:0.5 scale:1];
        [_hand runAction:scaleBackHand];
    }],
                                [CCDelayTime actionWithDuration:0.3],
                                [CCCallBlock actionWithBlock:^{
        CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:0.5];
        [_hand runAction:fadeOut];
    }],
                                [CCCallBlock actionWithBlock:^{
        CCMoveTo *moveToHand = [CCMoveTo actionWithDuration:2.0 position:ccp(screenSize.width/2 + 50,screenSize.height - 150)];
        [_hand runAction:moveToHand];
    }],
                                nil];
    
    [_hand runAction:sequenceHand];
    
    sequenceHand.tag = 1;
    
}

-(void)unFreezeAllObjects
{
    [self resumeSchedulerAndActions];
    
    if ([[self getChildByTag:kSpriteSheet1] getChildByTag:kFrontFox1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet1] getChildByTag:kFrontFox1st]];
    }
    
    if ([[self getChildByTag:kSpriteSheet3] getChildByTag:kGooma1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet3] getChildByTag:kGooma1st]];
    }
    
    if ([[self getChildByTag:kSpriteSheet5] getChildByTag:kWave1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet5] getChildByTag:kWave1st]];
    }
    
    if ([[self getChildByTag:kSpriteSheet1] getChildByTag:kBackFox] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet1] getChildByTag:kBackFox]];
    }
    
    if ([[self getChildByTag:kSpriteSheet5] getChildByTag:kWave2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet5] getChildByTag:kWave2nd]];
    }
    
    if ([[self getChildByTag:kSpriteSheet2] getChildByTag:kFrontFox2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet2] getChildByTag:kFrontFox2nd]];
    }
    
    if ([[self getChildByTag:kSpriteSheet4] getChildByTag:kGooma2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet4] getChildByTag:kGooma2nd]];
    }
    
    
}

-(void)freezeAllObjects
{
    [self pauseSchedulerAndActions];
    
    if ([[self getChildByTag:kSpriteSheet1] getChildByTag:kFrontFox1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet1] getChildByTag:kFrontFox1st]];
    }
    
    if ([[self getChildByTag:kSpriteSheet3] getChildByTag:kGooma1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet3] getChildByTag:kGooma1st]];
    }
   
    if ([[self getChildByTag:kSpriteSheet5] getChildByTag:kWave1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet5] getChildByTag:kWave1st]];
    }
   
    if ([[self getChildByTag:kSpriteSheet1] getChildByTag:kBackFox] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet1] getChildByTag:kBackFox]];
    }
    
    if ([[self getChildByTag:kSpriteSheet5] getChildByTag:kWave2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet5] getChildByTag:kWave2nd]];
    }
    
    if ([[self getChildByTag:kSpriteSheet2] getChildByTag:kFrontFox2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet2] getChildByTag:kFrontFox2nd]];
    }
    
    if ([[self getChildByTag:kSpriteSheet4] getChildByTag:kGooma2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet4] getChildByTag:kGooma2nd]];
    }
   
    
}

-(void) startAnimation
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    self.starArray = [CCArray arrayWithCapacity:10];
    
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
 
    
    [frameCache addSpriteFramesWithFile:@"title.plist"];
    
    spriteSheet = [CCSpriteBatchNode
                   batchNodeWithFile:@"title.pvr.ccz"];
    [self addChild:spriteSheet z:10 tag:kSpriteSheet];
    
    //  Load hand
    self.hand = [CCSprite spriteWithSpriteFrameName:@"hand-hd.png"];
    _hand.anchorPoint = ccp(0.5,0.5);
    _hand.position = ccp(screenSize.width/2 + 50,screenSize.height - 150);
    _hand.opacity = 0;
    [spriteSheet addChild:_hand z:55];
    
    didTap = NO;
    self.tap = [CCSprite spriteWithSpriteFrameName:@"tap-hd.png"];
    _tap.anchorPoint = ccp(0.5,0.5);
    // _tap.position = ccp(_hand.position.x - 17.0 - 50, _hand.position.y + 17.0 + 50);
    _tap.position = _hand.position;
    _tap.opacity = 0;
    [spriteSheet addChild:_tap z:50];
    
    [self schedule:@selector(showHand) interval:3.0 repeat:999 delay:1.0]; // Pause for screenshot
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
            CCSprite * background = [CCSprite spriteWithFile:@"scene2_background-568h.pvr.ccz"];
            background.anchorPoint = ccp(0.5,0.5);
            background.position = ccp(screenSize.width/2 ,screenSize.height/2);
            [self addChild:background z:0 tag:888];
        }
        if(result.height == 568)
        {
            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
            CCSprite * background = [CCSprite spriteWithFile:@"scene2_background-568h.pvr.ccz"];
            background.anchorPoint = ccp(0.5,0.5);
            background.position = ccp(screenSize.width/2,screenSize.height/2);
            [self addChild:background z:0 tag:888];
        }
        
        // Pre-load images for Front Fox 1st and Back Fox
          [frameCache addSpriteFramesWithFile:@"scene2_frontfox_1st.plist"];
          spriteSheet1 = [CCSpriteBatchNode batchNodeWithFile:@"scene2_frontfox_1st.pvr.ccz"];
        [self addChild:spriteSheet1 z:2 tag:kSpriteSheet1];
    
        // Front Fox 2nd
        /*
          [frameCache addSpriteFramesWithFile:@"scene2_frontfox_2nd.plist"];
          spriteSheet2 = [CCSpriteBatchNode batchNodeWithFile:@"scene2_frontfox_2nd.pvr.ccz"];
          [self addChild:spriteSheet2 z:3];
         */
        
        // Pre-load images for Gooma
          [frameCache addSpriteFramesWithFile:@"scene2_gooma_1st.plist"];
          spriteSheet3 = [CCSpriteBatchNode batchNodeWithFile:@"scene2_gooma_1st.pvr.ccz"];
        [self addChild:spriteSheet3 z:5 tag:kSpriteSheet3];
        
      /*
          [frameCache addSpriteFramesWithFile:@"scene2_gooma_2nd.plist"];
          spriteSheet4 = [CCSpriteBatchNode batchNodeWithFile:@"scene2_gooma_2nd.pvr.ccz"];
          [self addChild:spriteSheet4 z:5];
        */
        
        
        // Pre-load images for waves
        
          [frameCache addSpriteFramesWithFile:@"scene2_waves_1st.plist"];
          spriteSheet5 = [CCSpriteBatchNode batchNodeWithFile:@"scene2_waves_1st.pvr.ccz"];
        [self addChild:spriteSheet5 z:4 tag:kSpriteSheet5];
        
        
          [self showBackFox];
          [self showGooma];
          [self showFox1st];
          [self showWaves];
        
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
    //    [self freezeAllObjects];
    }
}

-(void)prepareForTransition
{
    [self unscheduleAllSelectors];
    [self unscheduleUpdate];
}

-(void) onEnter
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super onEnter];
    
    // Pre-load a static image for scene transition
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height == 480)
    {
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        CCSprite * preload = [CCSprite spriteWithFile:@"scene2.pvr.ccz"];
        preload.anchorPoint = ccp(0.5,0.5);
        preload.position = ccp(screenSize.width/2 ,screenSize.height/2);
        [self addChild:preload z:99 tag:99];
    }
    if(result.height == 568)
    {
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        CCSprite * preload = [CCSprite spriteWithFile:@"scene2-568h.pvr.ccz"];
        preload.anchorPoint = ccp(0.5,0.5);
        preload.position = ccp(screenSize.width/2,screenSize.height/2);
        [self addChild:preload z:99 tag:99];
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
    
    CCFadeTo *fadeTo = [CCFadeTo actionWithDuration:0.05 opacity:0];
    [[self getChildByTag:99] runAction:fadeTo];
    
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
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    //  [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    //  [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    //
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
        
        CCMoveBy *moveDown = [CCMoveBy actionWithDuration:0.2 position:ccp(0,-55)];
        
        CCCallBlock *makeSettingLayerVisible = [CCCallBlock actionWithBlock:^{
            [[[self parent] getChildByTag:2] setVisible:YES];
        }];
        
        CCSequence *sequenceDown = [CCSequence actions:
                                    makeSettingLayerVisible,
                                    moveDown,
                                    writeIsSwipeDown,
                                    [CCCallBlock actionWithBlock:^{
                                    [self freezeAllObjects];
                                   }],
                                    nil];
     
        [self runAction:sequenceDown];
    }
}

-(void)handleSwipeLeft:(UISwipeGestureRecognizer *)aGestureRecognizer
{

    [self prepareForTransition];
    [self freezeAllObjects];
    CCParticleSystemQuad *aStar;
     CCARRAY_FOREACH(self.starArray, aStar)
    {
        [aStar stopSystem];
 //       [aStar removeFromParentAndCleanup:YES];
 //       CCLOG(@"-");
    }
    aStar = nil;
    [self makeTransitionForward];

}

-(void)handleSwipeRight:(UISwipeGestureRecognizer *)aGestureRecognizer
{

    [self prepareForTransition];
[self freezeAllObjects];
    CCParticleSystemQuad *aStar;
    CCARRAY_FOREACH(self.starArray, aStar)
    {
        [aStar stopSystem];
 //       [aStar removeFromParentAndCleanup:YES];
 //       CCLOG(@"-");
    }
    aStar = nil;
    [self makeTransitionBack];
}

-(void)handleTap:(UITapGestureRecognizer *)aGestureRecognizer
{    
    if (([self.starArray count] < 10) && (touchLocation.y > 120) && (!isSwipedDown))
    {
        if (!didTap)
            [self unschedule:@selector(showHand)];
        didTap = YES;
        if ([SceneManager sharedSceneManager].isMusicOn == YES)
            [[SimpleAudioEngine sharedEngine] playEffect:@"ding.caf" pitch:1.0f pan:1.0f gain:0.5f];
        
        CCParticleSystemQuad *newStar = [CCParticleSystemQuad particleWithFile:@"scene2_stars.plist"];
    
        newStar.position = touchLocation;
        newStar.positionType = kCCPositionTypeRelative;
    
        
        [self addChild:newStar z:1 tag:999];
    
        for (int i = 0 ; i < 300 ; i++)
            [newStar update:.1];
    
        [self.starArray addObject:newStar];
        newStar=nil;
    }
    
}

@end
