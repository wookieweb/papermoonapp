//
//  Scene3Layer.m
//  PaperMoon
//
//  Created by Andy Woo on 28/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Scene3Layer.h"
#import "SceneManager.h"
#import "CCNode+SFGestureRecognizers.h"
#import "AppDelegate.h"
#import "SettingLayer.h"

#define kBigFox1st 1
#define kBigFox2nd 2
#define kFrontFox1st 3
#define kFrontFox2nd 4
#define kGooma1st 5
#define kGooma2nd 6
#define kBackFox 7
#define kSmallFox 8

#define kSpriteSheet1 9
#define kSpriteSheet2 10
#define kSpriteSheet3 11
#define kSpriteSheet4 12
// #define kSpriteSheet5 13
#define kSpriteSheet6 14
#define kSpriteSheet7 15



@implementation Scene3Layer

@synthesize bigFox1st = _bigFox1st;
@synthesize bigFox2nd = _bigFox2nd;
@synthesize frontFox1st = _frontFox1st;
@synthesize frontFox2nd = _frontFox2nd;
@synthesize gooma1st = _gooma1st;
@synthesize gooma2nd = _gooma2nd;
@synthesize backFox = _backFox;
@synthesize smallFox = _smallFox;


-(void) makeTransitionBack
{
     [[SceneManager sharedSceneManager] runSceneWithID:kScene2 withDirection:kRight withSender:[self parent]];
}


-(void) makeTransitionForward
{
     [[SceneManager sharedSceneManager] runSceneWithID:kScene4 withDirection:kLeft withSender:[self parent]];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCLOG(@"Scene3: Touches Began...");
    UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
}

-(void)showGooma2nd
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;

    
    [_gooma1st removeFromParentAndCleanup:YES];
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 34; i <= 74; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene3_gooma%d.png", i]]];
    }
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.12f];
    [animFrames removeAllObjects];
    [anim setRestoreOriginalFrame:NO];
    
 //   CGSize screenSize = [CCDirector sharedDirector].winSize;

    self.gooma2nd = [CCSprite spriteWithSpriteFrameName:@"scene3_gooma34.png"];
    
    _gooma2nd.anchorPoint = ccp(1,0);
    _gooma2nd.position = ccp(screenSize.width, 0);
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    
    CCAction *repeat = [CCRepeatForever actionWithAction:animate];
    
    [_gooma2nd runAction:repeat];
    
    [spriteSheet4 addChild:_gooma2nd];
    _gooma2nd.tag = kGooma2nd;
}


-(void)showGooma1st
{
   // [[CCTextureCache sharedTextureCache] addImageAsync:@"scene3_gooma_2nd.pvr.ccz" target:self selector:@selector(gooma_2ndDidLoad:)];
    
    // Animation with Gooma 1st
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 33; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene3_gooma%d.png", i]]];
        
    }
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.11f];
    [animFrames removeAllObjects];
    [anim setRestoreOriginalFrame:NO];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.gooma1st = [CCSprite spriteWithSpriteFrameName:@"scene3_gooma1.png"];
    
    _gooma1st.anchorPoint = ccp(1,0);
    _gooma1st.position = ccp(screenSize.width, 0);
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    
    CCSequence *sequence = [CCSequence actions:animate, [CCCallFunc actionWithTarget:self selector:@selector(showGooma2nd)], nil];
    
    [_gooma1st runAction:sequence]; // Pause for screenshot
    
    [spriteSheet3 addChild:_gooma1st];
    _gooma1st.tag = kGooma1st;
}

-(void)showFrontFox2nd
{
    [frameCache addSpriteFramesWithFile:@"scene3_frontfox_2nd.plist"];
    spriteSheet7 = [CCSpriteBatchNode batchNodeWithFile:@"scene3_frontfox_2nd.pvr.ccz"];
    [self addChild:spriteSheet7 z:11];
    
    [_frontFox1st removeFromParentAndCleanup:YES];
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 23; i <= 44; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene3_frontfox%d.png", i]]];
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.20f];
    [animFrames removeAllObjects];
    [anim setRestoreOriginalFrame:NO];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.frontFox2nd = [CCSprite spriteWithSpriteFrameName:@"scene3_frontfox23.png"];
    _frontFox2nd.position = ccp(screenSize.width/2, screenSize.height/2 - 20);
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    CCAction *repeat = [CCRepeatForever actionWithAction:animate];
    [_frontFox2nd runAction:repeat];
    [spriteSheet7 addChild:_frontFox2nd];
    _frontFox2nd.tag = kFrontFox2nd;
}


-(void)showFrontFox1st
{
  //  [[CCTextureCache sharedTextureCache] addImageAsync:@"scene3_frontfox_2nd.pvr.ccz" target:self selector:@selector(frontfox_2ndDidLoad:)];
    
    // Animation with Fox 1st
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 22; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene3_frontfox%d.png", i]]];
        
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.20f];
    [animFrames removeAllObjects];
    [anim setRestoreOriginalFrame:NO];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.frontFox1st = [CCSprite spriteWithSpriteFrameName:@"scene3_frontfox1.png"];
  //  _frontFox1st.anchorPoint = ccp(1,0);
    _frontFox1st.position = ccp(screenSize.width/2, screenSize.height/2 -20 );
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    CCSequence *sequence = [CCSequence actions:animate, [CCCallFunc actionWithTarget:self selector:@selector(showFrontFox2nd)], nil];
    [_frontFox1st runAction:sequence]; // Pause for screenshot
    [spriteSheet6 addChild:_frontFox1st];
    _frontFox1st.tag = kFrontFox1st;
}

-(void)showFox2nd
{
    [frameCache addSpriteFramesWithFile:@"scene3_bigfox_2nd.plist"];
    spriteSheet2 = [CCSpriteBatchNode batchNodeWithFile:@"scene3_bigfox_2nd.pvr.ccz"];
    [self addChild:spriteSheet2 z:9];
    
    [_bigFox1st removeFromParentAndCleanup:YES];
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 34; i <= 65; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene3_bigfox%d.png", i]]];
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.12f];
    [animFrames removeAllObjects];
    [anim setRestoreOriginalFrame:NO];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.bigFox2nd = [CCSprite spriteWithSpriteFrameName:@"scene3_bigfox34.png"];
    _bigFox2nd.anchorPoint = ccp(1,0);
    _bigFox2nd.position = ccp(screenSize.width, 0);
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    CCAction *repeat = [CCRepeatForever actionWithAction:animate];
    [_bigFox2nd runAction:repeat];
    [spriteSheet2 addChild:_bigFox2nd];
    _bigFox2nd.tag = kBigFox2nd;
}


-(void)showFox1st
{
    
    // Animation with Fox 1st
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 33; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene3_bigfox%d.png", i]]];
        
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.11f];
    [animFrames removeAllObjects];
    [anim setRestoreOriginalFrame:NO];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.bigFox1st = [CCSprite spriteWithSpriteFrameName:@"scene3_bigfox1.png"];
    _bigFox1st.anchorPoint = ccp(1,0);
    _bigFox1st.position = ccp(screenSize.width, 0);
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    CCSequence *sequence = [CCSequence actions:animate, [CCCallFunc actionWithTarget:self selector:@selector(showFox2nd)], nil];
    [_bigFox1st runAction:sequence]; // Pause for screenshot
    [spriteSheet1 addChild:_bigFox1st];
    _bigFox1st.tag = kBigFox1st;
}

-(void)showBackFox
{
    // Animation with Back Fox 
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 21; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene3_backfox%d.png", i]]];
        
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.2f];
    [animFrames removeAllObjects];
    [anim setRestoreOriginalFrame:NO];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.backFox = [CCSprite spriteWithSpriteFrameName:@"scene3_backfox1.png"];
    _backFox.anchorPoint = ccp(1,0.5);
    _backFox.position = ccp(screenSize.width-276, screenSize.height/2);
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    CCAction *repeat = [CCRepeatForever actionWithAction:animate];
    [_backFox runAction:repeat]; // Pause for screenshot
    [spriteSheet3 addChild:_backFox];
    _backFox.tag = kBackFox;
}

-(void)showSmallFox
{
    // Animation with Back Fox
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 21; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene3_smallfox%d.png", i]]];
        
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.2f];
    [animFrames removeAllObjects];
    [anim setRestoreOriginalFrame:NO];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.smallFox = [CCSprite spriteWithSpriteFrameName:@"scene3_smallfox1.png"];
    _smallFox.anchorPoint = ccp(1,0.5);
    _smallFox.position = ccp(screenSize.width, screenSize.height/2);
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    CCAction *repeat = [CCRepeatForever actionWithAction:animate];
    [_smallFox runAction:repeat]; // Pause for screenshot
    [spriteSheet3 addChild:_smallFox];
    _smallFox.tag = kSmallFox;
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

        
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
        

    }
    return self;
}

/*
-(void) gooma_2ndDidLoad:(CCTexture2D*) texture
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"scene3_gooma_2nd.plist" texture:(CCTexture2D*)texture];
    spriteSheet4 = [CCSpriteBatchNode batchNodeWithTexture:texture];
    [self addChild:spriteSheet4 z:8];
    
    // Moon and Stars
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCSprite * moon = [CCSprite spriteWithSpriteFrameName:@"scene3_moon.png"];
    moon.anchorPoint = ccp(0.5,0.5);
    moon.position = ccp(screenSize.width/2,screenSize.height/2);
    [spriteSheet4 addChild:moon z:2];
    
}
*/
/*
-(void) gooma_1stDidLoad:(CCTexture2D*) texture
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"scene3_gooma_1st.plist" texture:(CCTexture2D*)texture];
    spriteSheet3 = [CCSpriteBatchNode batchNodeWithTexture:texture];
    [self addChild:spriteSheet3 z:7];
    [self showGooma1st];
    [self showSmallFox];
    [self showBackFox];
    
}
*/
/*
-(void) frontfox_2ndDidLoad:(CCTexture2D*) texture
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"scene3_frontfox_2nd.plist" texture:(CCTexture2D*)texture];
    spriteSheet7 = [CCSpriteBatchNode batchNodeWithTexture:texture];
    [self addChild:spriteSheet7 z:11 tag:kSpriteSheet7];
    
}
*/
/*
-(void) frontfox_1stDidLoad:(CCTexture2D*) texture
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"scene3_frontfox_1st.plist" texture:(CCTexture2D*)texture];
    spriteSheet6 = [CCSpriteBatchNode batchNodeWithTexture:texture];
    [self addChild:spriteSheet6 z:11];
    [self showFrontFox1st];
    
}
*/

/*
-(void) bigfox_2ndDidLoad:(CCTexture2D*) texture
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"scene3_bigfox_2nd.plist" texture:(CCTexture2D*)texture];
    spriteSheet2 = [CCSpriteBatchNode batchNodeWithTexture:texture];
    [self addChild:spriteSheet2 z:9 tag:kSpriteSheet2];
    
}
*/

/*
-(void) bigfox_1stDidLoad:(CCTexture2D*) texture
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"scene3_bigfox_1st.plist" texture:(CCTexture2D*)texture];
    spriteSheet1 = [CCSpriteBatchNode batchNodeWithTexture:texture];
    [self addChild:spriteSheet1 z:9];
    [self showFox1st];
    
}
*/


-(void)unFreezeAllObjects
{
    [self resumeSchedulerAndActions];
    
    if ([[self getChildByTag:kSpriteSheet4] getChildByTag:kGooma2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet4] getChildByTag:kGooma2nd]];
    }
    
    if ([[self getChildByTag:kSpriteSheet3] getChildByTag:kGooma1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet3] getChildByTag:kGooma1st]];
    }
    
    if ([[self getChildByTag:kSpriteSheet7] getChildByTag:kFrontFox2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet7] getChildByTag:kFrontFox2nd]];
    }
    
    if ([[self getChildByTag:kSpriteSheet6] getChildByTag:kFrontFox1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet6] getChildByTag:kFrontFox1st]];
    }
    
    if ([[self getChildByTag:kSpriteSheet2] getChildByTag:kBigFox2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet2] getChildByTag:kBigFox2nd]];
    }
    
    if ([[self getChildByTag:kSpriteSheet1] getChildByTag:kBigFox1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet1] getChildByTag:kBigFox1st]];
    }
    
    if ([[self getChildByTag:kSpriteSheet3] getChildByTag:kBackFox] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet3] getChildByTag:kBackFox]];
    }
    
    if ([[self getChildByTag:kSpriteSheet3] getChildByTag:kSmallFox] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet3] getChildByTag:kSmallFox]];
    }
    
    
}

-(void)freezeAllObjects
{
    [self pauseSchedulerAndActions];
    
    if ([[self getChildByTag:kSpriteSheet4] getChildByTag:kGooma2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet4] getChildByTag:kGooma2nd]];
    }
    
    if ([[self getChildByTag:kSpriteSheet3] getChildByTag:kGooma1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet3] getChildByTag:kGooma1st]];
    }
    
    if ([[self getChildByTag:kSpriteSheet7] getChildByTag:kFrontFox2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet7] getChildByTag:kFrontFox2nd]];
    }
    
    if ([[self getChildByTag:kSpriteSheet6] getChildByTag:kFrontFox1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet6] getChildByTag:kFrontFox1st]];
    }
    
    if ([[self getChildByTag:kSpriteSheet2] getChildByTag:kBigFox2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet2] getChildByTag:kBigFox2nd]];
    }
    
    if ([[self getChildByTag:kSpriteSheet1] getChildByTag:kBigFox1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet1] getChildByTag:kBigFox1st]];
    }
    
    if ([[self getChildByTag:kSpriteSheet3] getChildByTag:kBackFox] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet3] getChildByTag:kBackFox]];
    }
    
    if ([[self getChildByTag:kSpriteSheet3] getChildByTag:kSmallFox] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet3] getChildByTag:kSmallFox]];
    }
    
    
}
-(void)startAnimation
{

    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            CCSprite *backgroundImage;
            backgroundImage = [CCSprite spriteWithFile:@"scene3_background-568h.pvr.ccz"];
            [self addChild:backgroundImage z:0];
            [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
        }
        if(result.height == 568)
        {
            CCSprite *backgroundImage;
            backgroundImage = [CCSprite spriteWithFile:@"scene3_background-568h.pvr.ccz"];
            [self addChild:backgroundImage z:0];
            [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
        }
        
        
        
    }
     
    
    // Pre-load images for Big Fox 1st and 2nd
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    [frameCache addSpriteFramesWithFile:@"scene3_bigfox_1st.plist"];
    spriteSheet1 = [CCSpriteBatchNode batchNodeWithFile:@"scene3_bigfox_1st.pvr.ccz"];
    [self addChild:spriteSheet1 z:9 tag:kSpriteSheet1];
    
    /*
    [frameCache addSpriteFramesWithFile:@"scene3_bigfox_2nd.plist"];
    spriteSheet2 = [CCSpriteBatchNode batchNodeWithFile:@"scene3_bigfox_2nd.pvr.ccz"];
    [self addChild:spriteSheet2 z:9];
    */
    
    // Pre-load images for Front Fox 1st and 2nd
    [frameCache addSpriteFramesWithFile:@"scene3_frontfox_1st.plist"];
    spriteSheet6 = [CCSpriteBatchNode batchNodeWithFile:@"scene3_frontfox_1st.pvr.ccz"];
    [self addChild:spriteSheet6 z:11 tag:kSpriteSheet6];
    
    /*
    [frameCache addSpriteFramesWithFile:@"scene3_frontfox_2nd.plist"];
    spriteSheet7 = [CCSpriteBatchNode batchNodeWithFile:@"scene3_frontfox_2nd.pvr.ccz"];
    [self addChild:spriteSheet7 z:11];
    */
    
    // Pre-load images for Gooma and Back Fox + Small Fox
    [frameCache addSpriteFramesWithFile:@"scene3_gooma_1st.plist"];
    spriteSheet3 = [CCSpriteBatchNode batchNodeWithFile:@"scene3_gooma_1st.pvr.ccz"];
    [self addChild:spriteSheet3 z:7 tag:kSpriteSheet3];
    
    
    [frameCache addSpriteFramesWithFile:@"scene3_gooma_2nd.plist"];
    spriteSheet4 = [CCSpriteBatchNode batchNodeWithFile:@"scene3_gooma_2nd.pvr.ccz"];
    [self addChild:spriteSheet4 z:8 tag:kSpriteSheet4];
    

    
    // Moon and Stars (same batchnode of Gooma_2nd)
    CCSprite * moon = [CCSprite spriteWithSpriteFrameName:@"scene3_moon.png"];
    moon.anchorPoint = ccp(0.5,0.5);
    moon.position = ccp(screenSize.width/2,screenSize.height/2);
    [spriteSheet4 addChild:moon z:2];
    

    
    [self showSmallFox];
    [self showBackFox];
    [self showFox1st];
    [self showGooma1st];
    [self showFrontFox1st];
    

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
 //   [self freezeAllObjects];

    
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
            preload = [CCSprite spriteWithFile:@"scene3.pvr.ccz"];
            [preload setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
            [self addChild:preload z:99 tag:99];
        }
        if(result.height == 568)
        {
              CCSprite *preload;
            preload = [CCSprite spriteWithFile:@"scene3-568h.pvr.ccz"];
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
    
    //
    //  [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    
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
            [[[self parent]  getChildByTag:2] setVisible:YES];
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
    [self freezeAllObjects];
    [self makeTransitionForward];
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    [self freezeAllObjects];
    [self makeTransitionBack];
}


@end
