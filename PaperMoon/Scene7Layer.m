//
//  Scene7Layer.m
//  PaperMoon
//
//  Created by Andy Woo on 8/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Scene7Layer.h"
#import "SceneManager.h"
#import "CCNode+SFGestureRecognizers.h"
// #import "SimpleAudioEngine.h"
#import "ClippingNode.h"
#import "AppDelegate.h"
 #import "UIDevice+Hardware.h"
#import "SettingLayer.h"

 #define IPHONE4 ([[[UIDevice currentDevice] hardwareDescription] isEqualToString:@"iPhone 4"] || [[[UIDevice currentDevice] hardwareDescription] isEqualToString:@"iPhone 4 (CDMA)"])

#define kGooma1st 1
#define kGooma2nd 2
#define kGooma3rd 3
#define kGoomaRepeat1st 4
#define kGoomaRepeat2nd 5
#define kGoomaRepeat3rd 6
#define kGhost 7
#define kFlower 8
#define kDoor 9
#define kCurtain 10
#define kFox 11
#define kSky 12

#define kBnGooma1st 20
#define kBnGooma2nd 21
#define kBnGooma3rd 22
#define kBnGoomaRepeat1st 23
#define kBnGoomaRepeat2nd 24
#define kBnGoomaRepeat3rd 25
#define kBnGhost 26
#define kBnFlower 27
#define kBnDoor 28



@implementation Scene7Layer

@synthesize gooma1st = _gooma1st;
@synthesize gooma2nd = _gooma2nd;
@synthesize gooma3rd = _gooma3rd;
@synthesize goomaRepeat1st = _goomaRepeat1st;
@synthesize goomaRepeat2nd = _goomaRepeat2nd;
@synthesize goomaRepeat3rd = _goomaRepeat3rd;
@synthesize ghost = _ghost;
@synthesize flower = _flower;
@synthesize door = _door;
@synthesize curtain = _curtain;
@synthesize fox = _fox;




-(void) makeTransitionBack
{
    
    [[SceneManager sharedSceneManager] runSceneWithID:kScene6 withDirection:kRight withSender:[self parent]];
}


-(void) makeTransitionForward
{
    [[SceneManager sharedSceneManager] runSceneWithID:kScene8 withDirection:kLeft withSender:[self parent]];
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
     CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGRect rect = CGRectMake(screenSize.width * 2 / 3, screenSize.height/3, screenSize.width/3, screenSize.height*2/3);
  //  CCLOG(@"rect = %f %f %f %f", screenSize.width * 2 / 3, screenSize.height/3, screenSize.width/3, screenSize.height*2/3);
  //  CCLOG(@"Touch point x: %f, y: %f", location.x, location.y);
    
    if ((!isDoorClosing) && (CGRectContainsPoint(rect, location)) && (!isSwipedDown))
    {
        doorClosed *= -1;
        [self showDoor];
    }
    
}

/*
-(void)cleanUpGoomaRepeat3rd
{
    [_goomaRepeat3rd removeFromParentAndCleanup:YES];
}
*/

-(void)cleanUpGooma3rd
{
    [_gooma3rd removeFromParentAndCleanup:YES];
    CCLOG(@"***** Cleaning up Gooma3rd *****");
}

-(void)showGooma3rd
{
    
    [_gooma2nd removeFromParentAndCleanup:YES];
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 13; i <= 18; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene7_gooma%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    self.gooma3rd = [CCSprite spriteWithSpriteFrameName:@"scene7_gooma13.png"];
    
    _gooma3rd.anchorPoint = ccp(0.5, 0.5);
    _gooma3rd.position = ccp(screenSize.width/2, screenSize.height/2);
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    
    CCCallFunc *callRepeat = [CCCallFunc actionWithTarget:self selector:@selector(showGoomaRepeat1st)];
    CCCallFunc *cleanup = [CCCallFunc actionWithTarget:self selector:@selector(cleanUpGooma3rd)];
    CCSequence *sequence = [CCSequence actions:animate, cleanup, callRepeat, nil];
    
    [anim setRestoreOriginalFrame:NO];
    
    
    [_gooma3rd runAction:sequence];
    
    [bnGooma3rd addChild:_gooma3rd];
    _gooma3rd.tag = kGooma3rd;
    
    [animFrames removeAllObjects];
    
}

-(void)showGooma2nd
{
    
    [_gooma1st removeFromParentAndCleanup:YES];
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 7; i <= 12; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene7_gooma%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    
    
    self.gooma2nd = [CCSprite spriteWithSpriteFrameName:@"scene7_gooma7.png"];
    
    
    _gooma2nd.anchorPoint = ccp(0.5, 0.5);
    _gooma2nd.position = ccp(screenSize.width/2, screenSize.height/2);
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    
    [anim setRestoreOriginalFrame:NO];
    CCSequence *sequence = [CCSequence actions:animate, [CCCallFunc actionWithTarget:self selector:@selector(showGooma3rd)], nil];
    
    [_gooma2nd runAction:sequence];
    
    [bnGooma2nd addChild:_gooma2nd];
    _gooma2nd.tag = kGooma2nd;
    
    [animFrames removeAllObjects];
    
}


-(void)showGooma1st
{
    [self loadGoomaRepeatBatchNodes];
    
    // Animation with Gooma 1st
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 6; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene7_gooma%d.png", i]]];
        
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.gooma1st = [CCSprite spriteWithSpriteFrameName:@"scene7_gooma1.png"];
    
    
    _gooma1st.anchorPoint = ccp(0.5, 0.5);
    _gooma1st.position = ccp(screenSize.width/2, screenSize.height/2);
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    
    CCSequence *sequence = [CCSequence actions:animate, [CCCallFunc actionWithTarget:self selector:@selector(showGooma2nd)], nil];
    
    [_gooma1st runAction:sequence];  // Pause for screenshot
    
    [bnGooma1st addChild:_gooma1st];
    _gooma1st.tag = kGooma1st;
    [animFrames removeAllObjects];
    
}

-(void)showGoomaRepeat3rd
{
    
   // [_goomaRepeat2nd removeFromParentAndCleanup:YES];
    [_goomaRepeat1st setVisible:NO];
    [_goomaRepeat2nd setVisible:NO];
    [_goomaRepeat3rd setVisible:YES];
    
    if ([[CCAnimationCache sharedAnimationCache] animationByName:@"scene7_goomaRepeat3rd"] == nil)
       {
           NSMutableArray *animFrames = [NSMutableArray array];
           for(int i = 13; i <= 18; ++i)
           {
               [animFrames addObject:
                [frameCache spriteFrameByName:
                 [NSString stringWithFormat:@"scene7_repeat%d.png", i]]];
           }
           CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
               [anim setRestoreOriginalFrame:NO];
              [animFrames removeAllObjects];
        }
    CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"scene7_goomaRepeat3rd"]];
  //  CCCallFunc *cleanup = [CCCallFunc actionWithTarget:self selector:@selector(cleanUpGoomaRepeat3rd)];
    CCCallFunc *callRepeat1st = [CCCallFunc actionWithTarget:self selector:@selector(showGoomaRepeat1st)];
    CCSequence *sequence = [CCSequence actions:animate,
    //                        cleanup,
                            callRepeat1st,
                            nil];
    [_goomaRepeat3rd runAction:sequence];
}


-(void)showGoomaRepeat2nd
{
    
  //  [_goomaRepeat1st removeFromParentAndCleanup:YES];
    [_goomaRepeat1st setVisible:NO];
    [_goomaRepeat2nd setVisible:YES];
    [_goomaRepeat3rd setVisible:NO];
    
        if ([[CCAnimationCache sharedAnimationCache] animationByName:@"scene7_goomaRepeat2nd"] == nil)
        {
            NSMutableArray *animFrames = [NSMutableArray array];
            for(int i = 7; i <= 12; ++i)
            {
                [animFrames addObject:
                 [frameCache spriteFrameByName:
                  [NSString stringWithFormat:@"scene7_repeat%d.png", i]]];
            }
    
            CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
                [anim setRestoreOriginalFrame:NO];
                [animFrames removeAllObjects];
        }

    CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"scene7_goomaRepeat2nd"]];
    CCSequence *sequence = [CCSequence actions:animate, [CCCallFunc actionWithTarget:self selector:@selector(showGoomaRepeat3rd)], nil];
    [_goomaRepeat2nd runAction:sequence];
}

-(void)showGoomaRepeat1st
{
    // Animation with GoomaRepeat 1st
    [_goomaRepeat1st setVisible:YES];
    [_goomaRepeat2nd setVisible:NO];
    [_goomaRepeat3rd setVisible:NO];
    
    if ([[CCAnimationCache sharedAnimationCache] animationByName:@"scene7_goomaRepeat1st"] == nil)
    {
        NSMutableArray *animFrames = [NSMutableArray array];
        for(int i = 1; i <= 6; ++i)
        {
            [animFrames addObject:
             [frameCache spriteFrameByName:
              [NSString stringWithFormat:@"scene7_repeat%d.png", i]]];
        }
        CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
        [anim setRestoreOriginalFrame:NO];
        [animFrames removeAllObjects];
    }
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"scene7_goomaRepeat1st"]];
    CCSequence *sequence = [CCSequence actions:animate, [CCCallFunc actionWithTarget:self selector:@selector(showGoomaRepeat2nd)], nil];
    [_goomaRepeat1st runAction:sequence];
}


-(void) prepareGoomaRepeat3rd
{
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 13; i <= 18; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene7_repeat%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"scene7_goomaRepeat3rd"];
    [animFrames removeAllObjects];
    [anim setRestoreOriginalFrame:NO];
}

-(void) prepareGoomaRepeat2nd
{
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 7; i <= 12; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene7_repeat%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"scene7_goomaRepeat2nd"];
    [animFrames removeAllObjects];
    [anim setRestoreOriginalFrame:NO];
}

-(void) prepareGoomaRepeat1st
{
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 6; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene7_repeat%d.png", i]]];
        
    }
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"scene7_goomaRepeat1st"];
     [anim setRestoreOriginalFrame:NO];
    [animFrames removeAllObjects];
}

-(void)loadGhost
{
    // Animation with Ghost
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 40; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene7_ghost%d.png", i]]];
        
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.1f];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"ghostAnimation"];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.ghost = [CCSprite spriteWithSpriteFrameName:@"scene7_ghost1.png"];
    [anim setRestoreOriginalFrame:NO];
    
    _ghost.anchorPoint = ccp(0.5, 0.5);
    _ghost.position = ccp(screenSize.width/2, screenSize.height/2);
    _ghost.tag = kGhost;
    
    [bnGhost addChild:_ghost];
    [animFrames removeAllObjects];
    
}

-(void)showGhost
{
    if ((!doorClosed) || (isGhostVisible))
    {
        if (isGhostVisible)
        {
            CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"ghostAnimation"]];
            CCSequence *sequence = [CCSequence actions:
                                animate,
                                [CCCallBlock actionWithBlock:^{
            if (isGhostVisible) isGhostVisible = NO;
               else isGhostVisible=YES;
        }],
                                nil];
             [_ghost runAction:sequence];  // Pause for screenshot
        }
        else
        {
            CCAction *animate = [[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"ghostAnimation"]] reverse];
            CCSequence *sequence = [CCSequence actions:
                                    (CCAnimate *)animate,
                                    [CCCallBlock actionWithBlock:^{
                if (isGhostVisible) isGhostVisible = NO;
                else isGhostVisible=YES;
            }],
                                    nil];
            [_ghost runAction:sequence];  // Pause for screenshot
            
        }
    }

    
}

-(void) loadDoor
{
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 28; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene7_door%d.png", i]]];
        
    }
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.1f];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"doorAnimation"];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.door = [CCSprite spriteWithSpriteFrameName:@"scene7_door1.png"];
    _door.anchorPoint = ccp(0.5, 0.5);
    _door.position = ccp(screenSize.width/2, screenSize.height/2);
    [anim setRestoreOriginalFrame:NO];
    [animFrames removeAllObjects];
    [bnDoor addChild:_door];
    _door.tag = kDoor;
    doorClosed = NO;
}

-(void)showDoor
{
    // Animation with Door
    CCLOG(@"doorClosed = %d", doorClosed);
    isDoorClosing = YES;
    if (!doorClosed)
    {
     //   if ([SceneManager sharedSceneManager].isMusicOn == YES)
      //      [[SimpleAudioEngine sharedEngine] playEffect:@"closingdoor.wav" pitch:1.0f pan:1.0f gain:0.5f];
        
        CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"doorAnimation"]];
        [_door runAction:[CCSequence actions:
                          animate,
                          [CCCallBlock actionWithBlock:^{
            isDoorClosing = NO;
        }],
                          nil]];  // Pause for screenshot

        doorClosed = YES;
    }
    else
    {
     //   if ([SceneManager sharedSceneManager].isMusicOn == YES)
     //       [[SimpleAudioEngine sharedEngine] playEffect:@"opendoor.wav" pitch:1.0f pan:1.0f gain:0.5f];
        
        CCAction *animate = [[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"doorAnimation"]] reverse];
        [_door runAction:[CCSequence actions:
                           (CCAnimate *)animate,
                           [CCCallBlock actionWithBlock:^{
            isDoorClosing = NO;
        }],
                           nil]];  // Pause for screenshot

        doorClosed = NO;
    }
}

-(void)showFlower
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.flower = [CCSprite spriteWithSpriteFrameName:@"scene7_flower1.png"];
    _flower.anchorPoint = ccp(0.5, 0.5);
    _flower.position = ccp(screenSize.width/2, screenSize.height/2);
    [bnFlower addChild:_flower];
    _flower.tag = kFlower;
    
    if (!IPHONE4)
    {
        // Animation with Flower
        
        NSMutableArray *animFrames = [NSMutableArray array];
        for(int i = 1; i <= 37; ++i)
        {
            [animFrames addObject:
             [frameCache spriteFrameByName:
              [NSString stringWithFormat:@"scene7_flower%d.png", i]]];
            
        }
        
        CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.1f];
        [animFrames removeAllObjects];
        CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
        [anim setRestoreOriginalFrame:NO];
        CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
        [_flower runAction:repeat];  // Pause for screenshot
    }
}

-(void) loadGoomaRepeatBatchNodes
{
    
    // GoomaRepeat 1st Batch Node
    [frameCache addSpriteFramesWithFile:@"scene7_goomaRepeat1st.plist"];
    bnGoomaRepeat1st = [CCSpriteBatchNode batchNodeWithFile:@"scene7_goomaRepeat1st.pvr.ccz"];
    [self addChild:bnGoomaRepeat1st z:8 tag:kBnGoomaRepeat1st];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.goomaRepeat1st = [CCSprite spriteWithSpriteFrameName:@"scene7_repeat1.png"];
    _goomaRepeat1st.anchorPoint = ccp(0.5, 0.5);
    _goomaRepeat1st.position = ccp(screenSize.width/2, screenSize.height/2);
    [bnGoomaRepeat1st addChild:_goomaRepeat1st];
    _goomaRepeat1st.tag = kGoomaRepeat1st;
    [_goomaRepeat1st setVisible:NO];
    [self prepareGoomaRepeat1st];
    
    // GoomaRepeat 2nd Batch Node
    [frameCache addSpriteFramesWithFile:@"scene7_goomaRepeat2nd.plist"];
    bnGoomaRepeat2nd = [CCSpriteBatchNode batchNodeWithFile:@"scene7_goomaRepeat2nd.pvr.ccz"];
    [self addChild:bnGoomaRepeat2nd z:8 tag:kBnGoomaRepeat2nd];
    self.goomaRepeat2nd = [CCSprite spriteWithSpriteFrameName:@"scene7_repeat7.png"];
    _goomaRepeat2nd.anchorPoint = ccp(0.5, 0.5);
    _goomaRepeat2nd.position = ccp(screenSize.width/2, screenSize.height/2);
    [bnGoomaRepeat2nd addChild:_goomaRepeat2nd];
    _goomaRepeat2nd.tag = kGoomaRepeat2nd;
    [_goomaRepeat2nd setVisible:NO];
    [self prepareGoomaRepeat2nd];
    
    // GoomaRepeat 3rd Batch Node
    [frameCache addSpriteFramesWithFile:@"scene7_goomaRepeat3rd.plist"];
    bnGoomaRepeat3rd = [CCSpriteBatchNode batchNodeWithFile:@"scene7_goomaRepeat3rd.pvr.ccz"];
    [self addChild:bnGoomaRepeat3rd z:8 tag:kBnGoomaRepeat3rd];
    self.goomaRepeat3rd = [CCSprite spriteWithSpriteFrameName:@"scene7_repeat13.png"];
    _goomaRepeat3rd.anchorPoint = ccp(0.5, 0.5);
    _goomaRepeat3rd.position = ccp(screenSize.width/2, screenSize.height/2);
    [bnGoomaRepeat3rd addChild:_goomaRepeat3rd];
    _goomaRepeat3rd.tag = kGoomaRepeat3rd;
    [_goomaRepeat3rd setVisible:NO];
    [self prepareGoomaRepeat3rd];
}

-(id) init
{
    self = [super init];
    if (self != nil)
    {

        
        self.isTouchEnabled = YES;
        doorClosed = -1;
        isDoorClosing = NO;
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

     }
    return self;
}

-(void)unFreezeAllObjects
{
    [self resumeSchedulerAndActions];
    
    if ([[self getChildByTag:kBnGooma3rd] getChildByTag:kGooma3rd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGooma3rd] getChildByTag:kGooma3rd]];
    }
    
    if ([[self getChildByTag:kBnGooma2nd] getChildByTag:kGooma2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGooma2nd] getChildByTag:kGooma2nd]];
    }
    
    if ([[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st]];
    }
    
    if ([[self getChildByTag:kBnGhost] getChildByTag:kGhost] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGhost] getChildByTag:kGhost]];
    }
    
    if ([[self getChildByTag:kBnDoor] getChildByTag:kDoor] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnDoor] getChildByTag:kDoor]];
    }
    
    if ([[self getChildByTag:kBnFlower] getChildByTag:kFlower] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnFlower] getChildByTag:kFlower]];
    }
    
    if ([[self getChildByTag:kBnGoomaRepeat1st] getChildByTag:kGoomaRepeat1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGoomaRepeat1st] getChildByTag:kGoomaRepeat1st]];
    }
    
    if ([[self getChildByTag:kBnGoomaRepeat2nd] getChildByTag:kGoomaRepeat2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGoomaRepeat2nd] getChildByTag:kGoomaRepeat2nd]];
    }
    
    if ([[self getChildByTag:kBnGoomaRepeat3rd] getChildByTag:kGoomaRepeat3rd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGoomaRepeat3rd] getChildByTag:kGoomaRepeat3rd]];
    }
    
    
}

-(void)freezeAllObjects
{
    [self pauseSchedulerAndActions];
    
    if ([[self getChildByTag:kBnGooma3rd] getChildByTag:kGooma3rd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGooma3rd] getChildByTag:kGooma3rd]];
    }
    
    if ([[self getChildByTag:kBnGooma2nd] getChildByTag:kGooma2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGooma2nd] getChildByTag:kGooma2nd]];
    }
    
    if ([[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st]];
    }
    
    if ([[self getChildByTag:kBnGhost] getChildByTag:kGhost] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGhost] getChildByTag:kGhost]];
    }
    
    if ([[self getChildByTag:kBnDoor] getChildByTag:kDoor] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnDoor] getChildByTag:kDoor]];
    }
    
    if ([[self getChildByTag:kBnFlower] getChildByTag:kFlower] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnFlower] getChildByTag:kFlower]];
    }
    
    if ([[self getChildByTag:kBnGoomaRepeat1st] getChildByTag:kGoomaRepeat1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGoomaRepeat1st] getChildByTag:kGoomaRepeat1st]];
    }
    
    if ([[self getChildByTag:kBnGoomaRepeat2nd] getChildByTag:kGoomaRepeat2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGoomaRepeat2nd] getChildByTag:kGoomaRepeat2nd]];
    }
    
    if ([[self getChildByTag:kBnGoomaRepeat3rd] getChildByTag:kGoomaRepeat3rd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGoomaRepeat3rd] getChildByTag:kGoomaRepeat3rd]];
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
            CCSprite * background = [CCSprite spriteWithFile:@"scene7_background-568h.pvr.ccz"];
            background.anchorPoint = ccp(0.5,0.5);
            background.position = ccp(screenSize.width/2,screenSize.height/2);
            [self addChild:background z:4 tag:kLayerTagBackground];
        }
        if(result.height == 568)
        {
            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
            CCSprite * background = [CCSprite spriteWithFile:@"scene7_background-568h.pvr.ccz"];
            background.anchorPoint = ccp(0.5,0.5);
            background.position = ccp(screenSize.width/2,screenSize.height/2);
            [self addChild:background z:4 tag:kLayerTagBackground];
        }
    }
    
    // Sky
    [frameCache addSpriteFramesWithFile:@"scene7_sky.plist"];
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
    CCSprite * sky = [CCSprite spriteWithSpriteFrameName:@"scene7_sky.png"];
    sky.anchorPoint = ccp(0.5,0.5);
    sky.position = ccp(screenSize.width/2,screenSize.height/2);
    sky.tag = kSky;
    [self addChild:sky z:2];
    
    // Curtains
    [frameCache addSpriteFramesWithFile:@"scene7_curtain.plist"];
    self.curtain = [CCSprite spriteWithSpriteFrameName:@"scene7_curtain.png"];
    _curtain.anchorPoint = ccp(0.5, 0.5);
    _curtain.position = ccp(screenSize.width/2 - 5, screenSize.height/2 + 38);
    [self addChild:_curtain z:5];
    _curtain.tag = kCurtain;
 
    // Fox
    [frameCache addSpriteFramesWithFile:@"scene7_fox.plist"];
    self.fox = [CCSprite spriteWithSpriteFrameName:@"scene7_fox.png"];
    _fox.anchorPoint = ccp(0.5, 0.5);
    _fox.position = ccp(screenSize.width/2 - 168,screenSize.height/2 + 95);
    [self addChild:_fox z:6];
    _fox.tag = kFox;
    
    
    // Gooma 1st Batch Node
    [frameCache addSpriteFramesWithFile:@"scene7_gooma1st.plist"];
    bnGooma1st = [CCSpriteBatchNode batchNodeWithFile:@"scene7_gooma1st.pvr.ccz"];
    [self addChild:bnGooma1st z:8 tag:kBnGooma1st];
    
    // Gooma 2nd Batch Node
    [frameCache addSpriteFramesWithFile:@"scene7_gooma2nd.plist"];
    bnGooma2nd = [CCSpriteBatchNode batchNodeWithFile:@"scene7_gooma2nd.pvr.ccz"];
    [self addChild:bnGooma2nd z:8 tag:kBnGooma2nd];
    
    // Gooma 3rd Batch Node
    [frameCache addSpriteFramesWithFile:@"scene7_gooma3rd.plist"];
    bnGooma3rd = [CCSpriteBatchNode batchNodeWithFile:@"scene7_gooma3rd.pvr.ccz"];
    [self addChild:bnGooma3rd z:8 tag:kBnGooma3rd];
    
    // Flower Batch Node
    [frameCache addSpriteFramesWithFile:@"scene7_flower.plist"];
    bnFlower = [CCSpriteBatchNode batchNodeWithFile:@"scene7_flower.pvr.ccz"];
    [self addChild:bnFlower z:50 tag:kBnFlower];
    
    // Door Batch Node
    [frameCache addSpriteFramesWithFile:@"scene7_door.plist"];
    bnDoor = [CCSpriteBatchNode batchNodeWithFile:@"scene7_door.pvr.ccz"];
    [self addChild:bnDoor z:7 tag:kBnDoor];
    
    // Ghost Batch Node
    [frameCache addSpriteFramesWithFile:@"scene7_ghost.plist"];
    bnGhost = [CCSpriteBatchNode batchNodeWithFile:@"scene7_ghost.pvr.ccz"];
    [self addChild:bnGhost z:3 tag:kBnGhost];
    isGhostVisible = YES;
    [self showGooma1st];
    [self loadGhost];
    [self showFlower];
    [self loadDoor];
    [self schedule:@selector(showGhost) interval:10.0f repeat:99 delay:0];
  //  [self scheduleOnce:@selector(showDoor) delay:3];
    
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
            preload = [CCSprite spriteWithFile:@"scene7.pvr.ccz"];
            [preload setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
            [self addChild:preload z:99 tag:99];
        }
        if(result.height == 568)
        {
            CCSprite *preload;
            preload = [CCSprite spriteWithFile:@"scene7-568h.pvr.ccz"];
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
    
    CCFadeTo *fadeTo = [CCFadeTo actionWithDuration:0.2 opacity:0];
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
    //  [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    
    // [[CCTextureCache sharedTextureCache] dumpCachedTextureInfo];

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
    [self makeTransitionForward];
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    [self makeTransitionBack];
}


@end
