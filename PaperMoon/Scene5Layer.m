//
//  Scene5Layer.m
//  PaperMoon
//
//  Created by Andy Woo on 3/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Scene5Layer.h"
#import "SceneManager.h"
#import "CCNode+SFGestureRecognizers.h"
#import "ClippingNode.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"
#import "SettingLayer.h"
#import "CCShake.h"

#define kGooma1st 1
#define kGooma2nd 2
#define kTree 3
#define kLightOn 4
#define kDoor 5
#define kTopGreen 6
#define kBird 7
#define kBackGreen 20
#define kTallGreen 21
#define kBigTallGreen 22
#define kSmallBlue 23
#define kSmallGreen 24
#define kLight 25
#define kGrass 26
#define kBackground 27
#define kRedMonsterRepeat 28
#define kCloudSmall 29
#define kCloudBig 30
#define kBackground0 31
#define kBackground1 32
#define kRedMonster 33
#define kSmallBlueRepeat 34


#define kBnGooma1st 8
#define kBnGooma2nd 9
#define kBnOthers 10
#define kBnTopGreen 11
#define kBnDoor 12
#define kBnRedMonsterRepeat 13
#define kBnCloud 14
#define kBnSmallBlue 15


@implementation Scene5Layer
{
    float cloudDelayTime;
    float cloudBigDelayTime;
}


@synthesize gooma1st = _gooma1st;
@synthesize gooma2nd = _gooma2nd;
@synthesize tree = _tree;
@synthesize lightOn = _lightOn;
@synthesize door = _door;
@synthesize topGreen = _topGreen;
@synthesize bird = _bird;
@synthesize redMonster = _redMonster;
@synthesize redMonsterRepeat = _redMonsterRepeat;
// @synthesize smallBlue = _smallBlue;
@synthesize smallBlueRepeat = _smallBlueRepeat;


-(void) turnLightOn
{
    [_lightOn setVisible:YES];
    isLightOn = YES;
        if ([SceneManager sharedSceneManager].isMusicOn == YES)
            [[SimpleAudioEngine sharedEngine] playEffect:@"snd-switch.caf" pitch:1.0f pan:1.0f gain:0.5f];
    
}

-(void)removeGooma2nd:(CCSprite*)object
{
    [object removeFromParentAndCleanup:YES];
}

-(void)showGooma2nd
{
    
    [_gooma1st removeFromParentAndCleanup:YES];
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 22; i <= 56; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene5_gooma%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.11f];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    

    
    self.gooma2nd = [CCSprite spriteWithSpriteFrameName:@"scene5_gooma22.png"];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            _gooma2nd.position = ccp(screenSize.width/2 - 39, screenSize.height/2);
        }
        if(result.height == 568)
        {
            _gooma2nd.position = ccp(screenSize.width/2 + 5, screenSize.height/2);
        }
    }
    
    _gooma2nd.anchorPoint = ccp(0.5, 0.5);
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    CCCallFunc *turnLighOn = [CCCallFunc actionWithTarget:self selector:@selector(turnLightOn)];
    CCDelayTime *delay = [CCDelayTime actionWithDuration:3.0];
    CCCallFuncO *removeGooma2nd = [CCCallFuncO actionWithTarget:self selector:@selector(removeGooma2nd:) object:_gooma2nd];
    CCSequence *sequence = [CCSequence actions:animate,
                            delay,
                            turnLighOn,
                            removeGooma2nd,
                            nil];
    [anim setRestoreOriginalFrame:NO];
    
    
    [_gooma2nd runAction:sequence];
    
    [bnGooma2nd addChild:_gooma2nd];
    _gooma2nd.tag = kGooma2nd;
    
    [animFrames removeAllObjects];
    
}


-(void)showGooma1st
{
    // Animation with Gooma 1st
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 21; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene5_gooma%d.png", i]]];
        
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.11f];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.gooma1st = [CCSprite spriteWithSpriteFrameName:@"scene5_gooma1.png"];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            _gooma1st.position = ccp(screenSize.width/2 - 39, screenSize.height/2);
        }
        if(result.height == 568)
        {
            _gooma1st.position = ccp(screenSize.width/2+5, screenSize.height/2);
        }
    }
    
    _gooma1st.anchorPoint = ccp(0.5, 0.5);
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    
    CCSequence *sequence = [CCSequence actions:animate, [CCCallFunc actionWithTarget:self selector:@selector(showGooma2nd)], nil];
    
    [_gooma1st runAction:sequence]; // Pause for screenshot
    
    [bnGooma1st addChild:_gooma1st];
    _gooma1st.tag = kGooma1st;
    [animFrames removeAllObjects];
    
}

-(void)animateSmallBlueRepeat
{
    CCLOG(@"smallblue repeat once");
    [_smallBlueRepeat stopAllActions];
    CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"smallBlueRepeat"]];
    CCAnimate *reverseSmallBlueRepeat = (CCAnimate*)[[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"smallBlueRepeat"]] reverse];
    CCDelayTime *delaySmallBlueRepeat  = [CCDelayTime actionWithDuration:0.5];
    CCSequence *sequenceSmallBlueRepeat  = [CCSequence actions:
                                            animate,
                                            delaySmallBlueRepeat ,
                                            reverseSmallBlueRepeat ,
                                            nil];
    [_smallBlueRepeat runAction:sequenceSmallBlueRepeat ]; // Pause for screenshot
}


-(void)loadSmallBlueRepeat
{
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 49; i <= 130; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene5_smallBlue%d.png", i]]];
        
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.11f];
    [anim setRestoreOriginalFrame:NO];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"smallBlueRepeat"];
    [animFrames removeAllObjects];

    [self animateSmallBlueRepeat];
    
}



-(void)animateRedMonsterRepeat
{
    CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"redMonsterRepeat"]];
    CCAnimate *reverseRedMonsterRepeat = (CCAnimate*)[[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"redMonsterRepeat"]] reverse];
    CCDelayTime *delayRedMonsterRepeat = [CCDelayTime actionWithDuration:0.5];
    CCSequence *sequenceRedMonsterRepeat = [CCSequence actions:
                                      animate,
                                      delayRedMonsterRepeat,
                                      reverseRedMonsterRepeat,
                                      nil];
    [_redMonsterRepeat runAction:sequenceRedMonsterRepeat]; // Pause for screenshot
}

-(void)loadRedMonsterRepeat
{
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 71; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene5_redMonsterRepeat%d.png", i]]];
        
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.11f];
    [anim setRestoreOriginalFrame:NO];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"redMonsterRepeat"];
    [animFrames removeAllObjects];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.redMonsterRepeat = [CCSprite spriteWithSpriteFrameName:@"scene5_redMonsterRepeat1.png"];
    _redMonsterRepeat.position = ccp(0-5, screenSize.height/2);
    _redMonsterRepeat.anchorPoint = ccp(0, 0.5);
    [bnRedMonsterRepeat addChild:_redMonsterRepeat];
    _redMonsterRepeat.tag = kRedMonsterRepeat;
    
    
}

-(void)loadDoor
{    
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 31; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene5_door%d.png", i]]];
        
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.11f];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    self.door = [CCSprite spriteWithSpriteFrameName:@"scene5_door1.png"];
    
    _door.position = ccp(screenSize.width+84, screenSize.height/2);
    
    
    _door.anchorPoint = ccp(1, 0.5);
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    CCMoveBy *move = [CCMoveBy actionWithDuration:3 position:ccp(-80,0)];
    CCDelayTime *delay = [CCDelayTime actionWithDuration:1.0];
    CCSequence *sequence = [CCSequence actions:move,
                            delay,
                            animate,
                            nil];
    [_door runAction:sequence]; // Pause for screenshot
    
    [bnDoor addChild:_door];
    _door.tag = kDoor;
    [animFrames removeAllObjects];
    
}

-(void) rockBigTallGreen
{
    CCRotateTo *rotateLeft = [CCRotateTo actionWithDuration:2.0 angle:0.5];
    CCRotateTo *rotateRight = [CCRotateTo actionWithDuration:2.0 angle:-0.5];
    CCSequence *sequence = [CCSequence actions:rotateLeft,
                            rotateRight,
                            nil];
    CCRepeatForever *rock = [CCRepeatForever actionWithAction:sequence];
    [[[self getChildByTag:kBnOthers] getChildByTag:kBigTallGreen] runAction:rock];
}

-(void) rockTopGreen
{
    CCRotateTo *rotateLeft = [CCRotateTo actionWithDuration:1.0 angle:1.0];
    CCRotateTo *rotateRight = [CCRotateTo actionWithDuration:1.0 angle:-1.0];
    CCSequence *sequence = [CCSequence actions:rotateLeft,
                            rotateRight,
                            nil];
    CCRepeatForever *rock = [CCRepeatForever actionWithAction:sequence];
    [self.topGreen runAction:rock];
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
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnBird:)];
        [tapGestureRecognizer setNumberOfTapsRequired:1];
        [tapGestureRecognizer setNumberOfTouchesRequired:1];
        [self addGestureRecognizer:tapGestureRecognizer];

        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
        
               
    }
    return self;
}


-(void) makeTransitionBack
{
    [[SceneManager sharedSceneManager] runSceneWithID:kScene4 withDirection:kRight withSender:[self parent]];
}


-(void) makeTransitionForward
{
    [[SceneManager sharedSceneManager] runSceneWithID:kScene6 withDirection:kLeft withSender:[self parent]];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
    touchLocation = location;

}

-(void)unFreezeAllObjects
{
    [self resumeSchedulerAndActions];
    
    if ([[self getChildByTag:kBnCloud] getChildByTag:kCloudBig] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnCloud] getChildByTag:kCloudBig]];
    }
    
    if ([[self getChildByTag:kBnCloud] getChildByTag:kCloudSmall] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnCloud] getChildByTag:kCloudSmall]];
    }
    
    if ([[self getChildByTag:kBnRedMonsterRepeat] getChildByTag:kRedMonsterRepeat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnRedMonsterRepeat] getChildByTag:kRedMonsterRepeat]];
    }
    
    if ([[self getChildByTag:kBnOthers ] getChildByTag:kRedMonster] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnOthers] getChildByTag:kRedMonster]];
    }
    
    if ([[self getChildByTag:kBnGooma2nd] getChildByTag:kGooma2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGooma2nd] getChildByTag:kGooma2nd]];
    }
    
    if ([[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st]];
    }
    
    if ([[self getChildByTag:kBnDoor] getChildByTag:kDoor] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnDoor] getChildByTag:kDoor]];
    }
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kBackGreen] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnOthers] getChildByTag:kBackGreen]];
    }
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kTree] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnOthers] getChildByTag:kTree]];
    }
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kTopGreen] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnOthers] getChildByTag:kTopGreen]];
    }
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kTallGreen] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnOthers] getChildByTag:kTallGreen]];
    }
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kBigTallGreen] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnOthers] getChildByTag:kBigTallGreen]];
    }
    
    if ([[self getChildByTag:kBnSmallBlue] getChildByTag:kSmallBlueRepeat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnSmallBlue] getChildByTag:kSmallBlueRepeat]];
    }
    
    
    if ([[self getChildByTag:kBnTopGreen] getChildByTag:kSmallGreen] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnTopGreen] getChildByTag:kSmallGreen]];
    }
    
    if ([[self getChildByTag:kBnTopGreen] getChildByTag:kLight] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnTopGreen] getChildByTag:kLight]];
    }
    
    if ([[self getChildByTag:kBnTopGreen] getChildByTag:kLightOn] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnTopGreen] getChildByTag:kLightOn]];
    }
    
    if ([[self getChildByTag:kBnTopGreen] getChildByTag:kGrass] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnTopGreen] getChildByTag:kGrass]];
    }
    
    
    if ([self getChildByTag:kBird] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[self getChildByTag:kBird]];
    }
    
    if ([self getChildByTag:kBackground] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[self getChildByTag:kBackground]];
    }
    
    if ([self getChildByTag:kBackground0] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[self getChildByTag:kBackground0]];
    }
    
    if ([self getChildByTag:kBackground1] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[self getChildByTag:kBackground1]];
    }
    
}


-(void)freezeAllObjects
{
    [self pauseSchedulerAndActions];

    if ([[self getChildByTag:kBnCloud] getChildByTag:kCloudBig] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnCloud] getChildByTag:kCloudBig]];
    }

    if ([[self getChildByTag:kBnCloud] getChildByTag:kCloudSmall] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnCloud] getChildByTag:kCloudSmall]];
    }
    
    if ([[self getChildByTag:kBnRedMonsterRepeat] getChildByTag:kRedMonsterRepeat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnRedMonsterRepeat] getChildByTag:kRedMonsterRepeat]];
    }
    
    if ([[self getChildByTag:kBnOthers ] getChildByTag:kRedMonster] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnOthers] getChildByTag:kRedMonster]];
    }
    
    
    if ([[self getChildByTag:kBnGooma2nd] getChildByTag:kGooma2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGooma2nd] getChildByTag:kGooma2nd]];
    }
    
    if ([[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st]];
    }
    
    if ([[self getChildByTag:kBnDoor] getChildByTag:kDoor] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnDoor] getChildByTag:kDoor]];
    }
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kBackGreen] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnOthers] getChildByTag:kBackGreen]];
    }
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kTree] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnOthers] getChildByTag:kTree]];
    }
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kTopGreen] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnOthers] getChildByTag:kTopGreen]];
    }
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kTallGreen] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnOthers] getChildByTag:kTallGreen]];
    }

    if ([[self getChildByTag:kBnOthers] getChildByTag:kBigTallGreen] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnOthers] getChildByTag:kBigTallGreen]];
    }

    if ([[self getChildByTag:kBnSmallBlue] getChildByTag:kSmallBlueRepeat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnSmallBlue] getChildByTag:kSmallBlueRepeat]];
    }
 
    
    if ([[self getChildByTag:kBnTopGreen] getChildByTag:kSmallGreen] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnTopGreen] getChildByTag:kSmallGreen]];
    }
    
    if ([[self getChildByTag:kBnTopGreen] getChildByTag:kLight] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnTopGreen] getChildByTag:kLight]];
    }
    
    if ([[self getChildByTag:kBnTopGreen] getChildByTag:kLightOn] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnTopGreen] getChildByTag:kLightOn]];
    }
    
    if ([[self getChildByTag:kBnTopGreen] getChildByTag:kGrass] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnTopGreen] getChildByTag:kGrass]];
    }
    
    
    if ([self getChildByTag:kBird] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[self getChildByTag:kBird]];
    }
    
    if ([self getChildByTag:kBackground] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[self getChildByTag:kBackground]];
    }
    
    if ([self getChildByTag:kBackground0] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[self getChildByTag:kBackground0]];
    }
    
    if ([self getChildByTag:kBackground1] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[self getChildByTag:kBackground1]];
    }
    
}

-(void)animateCloudBig
{
    [_cloudBig stopAllActions];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCMoveBy *moveBigCloud = [CCMoveBy actionWithDuration:3.5 position:ccp(-150, -10)];
    CCMoveBy *moveBigCloud2 = [CCMoveBy actionWithDuration:3.5 position:ccp(-150, -10)];
    CCFadeIn *fadeInBigCloud = [CCFadeIn actionWithDuration:1.0];
    CCFadeOut *fadeOutBigCloud = [CCFadeOut actionWithDuration:1.5];
    CCCallBlock *resetBigCloudPos = [CCCallBlock actionWithBlock:^{
        _cloudBig.position = ccp(screenSize.width/2 - 50, screenSize.height/2 + 20);
        cloudBigDelayTime = ((arc4random() % 20) / 10.0) + 1.0;
        }];
    
    CCSequence *sequenceBigCloud = [CCSequence actions:
                                    [CCSpawn actions:
                                     fadeInBigCloud,
                                     moveBigCloud, nil],
                                    [CCSpawn actions:
                                     moveBigCloud2,
                                     fadeOutBigCloud, nil],
                                      resetBigCloudPos,
                                      
                                      nil];
    [_cloudBig runAction:sequenceBigCloud];
}

-(void)animateCloudSmall
{
    [_cloudSmall stopAllActions];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCMoveBy *moveSmallCloud = [CCMoveBy actionWithDuration:2.5 position:ccp(-100, -10)];
    CCMoveBy *moveSmallCloud2 = [CCMoveBy actionWithDuration:2.5 position:ccp(-100, -10)];
    CCFadeIn *fadeInSmallCloud = [CCFadeIn actionWithDuration:1.5];
    CCFadeOut *fadeOutSmallCloud = [CCFadeOut actionWithDuration:1.5];
    CCCallBlock *resetSmallCloudPos = [CCCallBlock actionWithBlock:^{
        _cloudSmall.position = ccp(screenSize.width/2 - 50, screenSize.height/3);
        cloudDelayTime = ((arc4random() % 20) / 10.0) + 1.0;
    }];
    
    CCSequence *sequenceSmallCloud = [CCSequence actions:
                                      [CCSpawn actions:
                                       fadeInSmallCloud,
                                       moveSmallCloud, nil],
                                      [CCSpawn actions:
                                       moveSmallCloud2,
                                       fadeOutSmallCloud, nil],
                                      resetSmallCloudPos,
                                      nil];
    [_cloudSmall runAction:sequenceSmallCloud];
}

-(void)startAnimation
{
    cloudDelayTime = ((arc4random() % 20) / 10.0) + 1.0;
    cloudBigDelayTime = ((arc4random() % 20) / 10.0) + 1.0;
    
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    // Background
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
            CCSprite *background0 = [CCSprite spriteWithFile:@"scene5_background0_small.pvr.ccz"];
            background0.anchorPoint = ccp(0, 1);
            background0.position = ccp (0, screenSize.height);
            [self addChild:background0 z:0 tag:kBackground0];
            CCAction *move = [CCMoveBy actionWithDuration:3.0 position:ccp(-94, 0)];
            [background0 runAction:move];
            
            CCSprite *background1 = [CCSprite spriteWithFile:@"scene5_background1_small.pvr.ccz"];
            background1.anchorPoint = ccp(0, 0);
            background1.position = ccp (0, -5);
            [self addChild:background1 z:3 tag:kBackground1];
            CCAction *move1 = [CCMoveBy actionWithDuration:3.0 position:ccp(-94, 0)];
            [background1 runAction:move1];
            
        //    CCSprite * background = [CCSprite spriteWithFile:@"scene5_background.pvr.ccz"];
        //    background.anchorPoint = ccp(0,0.5);
        //    background.position = ccp(0,screenSize.height/2);
        //    [self addChild:background z:0 tag:kBackground];
        //    CCAction *move = [CCMoveBy actionWithDuration:3 position:ccp(-100,0)];
        //    [background runAction:move]; // Pause for screenshot
        }
        if(result.height == 568)
        {
            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
            CCSprite *background0 = [CCSprite spriteWithFile:@"scene5_background0.pvr.ccz"];
            background0.anchorPoint = ccp(0, 1);
            background0.position = ccp (0, screenSize.height);
            [self addChild:background0 z:0 tag:kBackground0];
            CCAction *move = [CCMoveBy actionWithDuration:3.0 position:ccp(-94, 0)];
            [background0 runAction:move];
            
            CCSprite *background1 = [CCSprite spriteWithFile:@"scene5_background1.pvr.ccz"];
            background1.anchorPoint = ccp(0, 0);
            background1.position = ccp (0, -5);
            [self addChild:background1 z:3 tag:kBackground1];
            CCAction *move1 = [CCMoveBy actionWithDuration:3.0 position:ccp(-94, 0)];
            [background1 runAction:move1];
            
            
            
        //    CCSprite * background = [CCSprite spriteWithFile:@"scene5_background-568h.pvr.ccz"];
        //    background.anchorPoint = ccp(0,0.5);
        //    background.position = ccp(0,screenSize.height/2);
        //    [self addChild:background z:0 tag:kBackground];
         //   CCAction *move = [CCMoveBy actionWithDuration:3 position:ccp(-100,0)];
        //    [background runAction:move]; // Pause for screenshot
        }
    }
    
    // Gooma 1st
    [frameCache addSpriteFramesWithFile:@"scene5_gooma_1st.plist"];
    bnGooma1st = [CCSpriteBatchNode batchNodeWithFile:@"scene5_gooma_1st.pvr.ccz"];
    [self addChild:bnGooma1st z:8 tag:kBnGooma1st];
    
    // Gooma 2nd
    [frameCache addSpriteFramesWithFile:@"scene5_gooma_2nd.plist"];
    bnGooma2nd = [CCSpriteBatchNode batchNodeWithFile:@"scene5_gooma_2nd.pvr.ccz"];
    [self addChild:bnGooma2nd z:8 tag:kBnGooma2nd];
    
    // Other images Batchnode
    [frameCache addSpriteFramesWithFile:@"scene5_others.plist"];
    bnOthers = [CCSpriteBatchNode batchNodeWithFile:@"scene5_others.pvr.ccz"];
    [self addChild:bnOthers z:5 tag:kBnOthers];
    
    // Top Green Batchnode
    [frameCache addSpriteFramesWithFile:@"scene5_topgreen.plist"];
    bnTopGreen = [CCSpriteBatchNode batchNodeWithFile:@"scene5_topgreen.pvr.ccz"];
    [self addChild:bnTopGreen z:10 tag:kBnTopGreen];
    
    // Door Batchnode
    [frameCache addSpriteFramesWithFile:@"scene5_door.plist"];
    bnDoor = [CCSpriteBatchNode batchNodeWithFile:@"scene5_door.pvr.ccz"];
    [self addChild:bnDoor z:20 tag:kBnDoor];
    
    // Cloud Batchnode
    [frameCache addSpriteFramesWithFile:@"scene5_cloud.plist"];
    bnCloud = [CCSpriteBatchNode batchNodeWithFile:@"scene5_cloud.pvr.ccz"];
    [self addChild:bnCloud z:2 tag:kBnCloud];
    
    // Small Blue Batchnode
    [frameCache addSpriteFramesWithFile:@"scene5_smallBlue.plist"];
    bnSmallBlue = [CCSpriteBatchNode batchNodeWithFile:@"scene5_smallBlue.pvr.ccz"];
    [self addChild:bnSmallBlue z:4 tag:kBnSmallBlue];
    
    // Red Monster Repeat Batchnode
    [frameCache addSpriteFramesWithFile:@"scene5_redMonsterRepeat.plist"];
    bnRedMonsterRepeat = [CCSpriteBatchNode batchNodeWithFile:@"scene5_redMonsterRepeat.pvr.ccz"];
    [self addChild:bnRedMonsterRepeat z:30 tag:kBnRedMonsterRepeat];
    
    // Back Green
    CCSprite *backGreen = [CCSprite spriteWithSpriteFrameName:@"backgreen.png"];
    [bnOthers addChild:backGreen];
    backGreen.tag = kBackGreen;
    backGreen.anchorPoint = ccp(1,1);
    backGreen.position = ccp(screenSize.width - 80, screenSize.height);
    CCMoveBy *moveBackGreen = [CCMoveBy actionWithDuration:3 position:ccp(-90,0)];
    [backGreen runAction:moveBackGreen]; // Pause for screenshot
    
    // Tree
    self.tree = [CCSprite spriteWithSpriteFrameName:@"tree.png"];
    [bnOthers addChild:_tree];
    _tree.tag = kTree;
    _tree.anchorPoint = ccp(1,0.5);
    _tree.position = ccp(screenSize.width+91, screenSize.height/2);
    CCMoveBy *moveTree = [CCMoveBy actionWithDuration:3 position:ccp(-80,0)];
    [_tree runAction:moveTree]; // Pause for screenshot
    
    // cloud Small
    self.cloudSmall = [CCSprite spriteWithSpriteFrameName:@"scene5_smallCloud.png"];
    [bnCloud addChild:_cloudSmall];
    _cloudSmall.tag = kCloudSmall;
    _cloudSmall.anchorPoint = ccp (0.5, 0.5);
    [_cloudSmall setOpacity:0]; // pause for screenshot
    _cloudSmall.position = ccp(screenSize.width/2 - 50, screenSize.height/3);
    CCMoveBy *moveSCloud = [CCMoveBy actionWithDuration:3.0 position:ccp(-200, -10)];
    CCMoveBy *moveSCloud2 = [CCMoveBy actionWithDuration:3.0 position:ccp(-200, -10)];
    CCFadeIn *fadeInSCloud = [CCFadeIn actionWithDuration:0.5];
    CCFadeOut *fadeOutSCloud = [CCFadeOut actionWithDuration:0.5];
    CCCallBlock *resetSCloudPos = [CCCallBlock actionWithBlock:^{
        _cloudSmall.position = ccp(screenSize.width/2 - 50 - 100, screenSize.height/3);
    }];
    CCSequence *sequenceSCloud = [CCSequence actions:
                                  [CCSpawn actions:
                                   fadeInSCloud,
                                   moveSCloud, nil],
                                  [CCSpawn actions:
                                   moveSCloud2,
                                   fadeOutSCloud, nil],
                                  resetSCloudPos,
                                  nil];
    [_cloudSmall runAction:sequenceSCloud];
   

    [self schedule:@selector(animateCloudSmall) interval:(cloudDelayTime + 4.0)];
    
    // cloud Big
    self.cloudBig = [CCSprite spriteWithSpriteFrameName:@"scene5_bigCloud.png"];
    [bnCloud addChild:_cloudBig];
    _cloudBig.tag = kCloudBig;
    _cloudBig.anchorPoint = ccp (0.5, 0.5);
    _cloudBig.position = ccp(screenSize.width/2 + 50, screenSize.height/2 + 20);
     [_cloudBig setOpacity:0]; // pause for screenshot
    CCMoveBy *moveBCloud = [CCMoveBy actionWithDuration:3.0 position:ccp(-200, -10)];
    CCMoveBy *moveBCloud2 = [CCMoveBy actionWithDuration:3.0 position:ccp(-200, -10)];
    CCFadeIn *fadeInBCloud = [CCFadeIn actionWithDuration:1.0];
    CCFadeOut *fadeOutBCloud = [CCFadeOut actionWithDuration:1.0];
    CCCallBlock *resetBCloudPos = [CCCallBlock actionWithBlock:^{
        _cloudBig.position = ccp(screenSize.width/2 + 50 - 100, screenSize.height/2);
    }];
    CCSequence *sequenceBCloud = [CCSequence actions:
                                  [CCSpawn actions:
                                        fadeInBCloud,
                                      moveBCloud, nil],
                                  [CCSpawn actions:
                                   moveBCloud2,
                                   fadeOutBCloud, nil],
                                  resetBCloudPos,
                                      nil];
    [_cloudBig runAction:sequenceBCloud];
    
    
    [self schedule:@selector(animateCloudBig) interval:(cloudBigDelayTime + 6.0)];
    
    // Top Green
    self.topGreen = [CCSprite spriteWithSpriteFrameName:@"topgreen.png"];
    [bnOthers addChild:_topGreen];
    _topGreen.tag = kTopGreen;
    _topGreen.anchorPoint = ccp(1,1);
    _topGreen.position = ccp(screenSize.width+90, screenSize.height);
    CCMoveBy *moveTopGreen = [CCMoveBy actionWithDuration:3 position:ccp(-90,0)];
    CCSequence *sequence = [CCSequence actions:moveTopGreen,
                            [CCCallFunc actionWithTarget:self selector:@selector(rockTopGreen)],
                            nil];
    
    [_topGreen runAction:sequence]; // Pause for screenshot
    
    // Tall Green
    CCSprite *tallGreen = [CCSprite spriteWithSpriteFrameName:@"tallgreen.png"];
    [bnOthers addChild:tallGreen];
    tallGreen.tag = kTallGreen;
    tallGreen.anchorPoint = ccp(0.5,0);
    tallGreen.position = ccp(screenSize.width/2 * 0.2, screenSize.height *0.07);
    CCMoveBy *moveTallGreen = [CCMoveBy actionWithDuration:3 position:ccp(-100,0)];
    [tallGreen runAction:moveTallGreen]; // Pause for screenshot
    
    
    // Big Tall Green
    CCSprite *bigTallGreen = [CCSprite spriteWithSpriteFrameName:@"bigtallgreen.png"];
    [bnOthers addChild:bigTallGreen];
    bigTallGreen.tag = kBigTallGreen;
  //  [bigTallGreen setTag:kTallGreen];
    bigTallGreen.anchorPoint = ccp(0.5,0);
    bigTallGreen.position = ccp(screenSize.width/2 * 0.4, screenSize.height *0.07);
    CCMoveBy *moveBigTallGreen = [CCMoveBy actionWithDuration:3 position:ccp(-100,0)];
    CCSequence *sequenceBigTallGreen = [CCSequence actions:
                                        moveBigTallGreen,
                                        [CCCallFunc actionWithTarget:self selector:@selector(rockBigTallGreen)],
                                        nil];
    [bigTallGreen runAction:sequenceBigTallGreen]; // Pause for screenshot
    
    // Red Monster
    self.redMonster = [CCSprite spriteWithSpriteFrameName:@"redmonster.png"];
    [bnOthers addChild:_redMonster];
    _redMonster.tag = kRedMonster;
    _redMonster.anchorPoint = ccp(0.0, 0.5);
    _redMonster.position = ccp(0.0, screenSize.height/2 * 0.33);
    CCMoveBy *moveRedMonster = [CCMoveBy actionWithDuration:3 position:ccp(-100, 0)];
    CCCallBlock *removeRedMonster = [CCCallBlock actionWithBlock:^{
        [_redMonster removeFromParentAndCleanup:YES];
    }];
    CCSequence *sequenceRedMonster = [CCSequence actions:
                                      moveRedMonster,
                                      removeRedMonster,
                                      nil];
    [_redMonster runAction:sequenceRedMonster];
    
    
    // Small Blue
    self.smallBlueRepeat = [CCSprite spriteWithSpriteFrameName:@"scene5_smallBlue49.png"];
    _smallBlueRepeat.anchorPoint = ccp(0.5, 0.5);
    _smallBlueRepeat.position = ccp(screenSize.width/2 + 94, screenSize.height/2);
    [bnSmallBlue addChild:_smallBlueRepeat];
    _smallBlueRepeat.tag = kSmallBlueRepeat;
    [self loadSmallBlueRepeat];
 
    CCMoveBy *moveSmallBlueRepeat = [CCMoveBy actionWithDuration:3 position:ccp(-94,0)];
    [_smallBlueRepeat runAction:moveSmallBlueRepeat]; // Pause for screenshot
    [self schedule:@selector(animateSmallBlueRepeat) interval:15.0 repeat:999 delay:10.0];
    
    
    CCSprite *smallBlue = [CCSprite spriteWithSpriteFrameName:@"smallblue.png"];
    [bnOthers addChild:smallBlue];
    smallBlue.tag = kSmallBlue;
    smallBlue.anchorPoint = ccp(0.5,0);
    [smallBlue setOpacity:0];
    smallBlue.position = ccp(screenSize.width/2 + (smallBlue.contentSize.width * 1.2), screenSize.height *0.1);
    CCMoveBy *moveSmallBlue = [CCMoveBy actionWithDuration:3 position:ccp(-94,0)];
    [smallBlue runAction:moveSmallBlue]; // Pause for screenshot
    
    
    // Bird
    [frameCache addSpriteFramesWithFile:@"scene5_bird.plist"];
    self.bird = [CCSprite spriteWithSpriteFrameName:@"bird.png"];
    [self addChild:_bird z:5];
    _bird.tag = kBird;
    _bird.anchorPoint = ccp(0.5,0.5);
    _bird.position = ccp(_tree.position.x - 230, screenSize.height/2 + 135);
    CCMoveBy *moveBird = [CCMoveBy actionWithDuration:3 position:ccp(-80,0)];
    [_bird runAction:moveBird]; // Pause for screenshot
    

    
    ////////////////////////////////////////////////////////////////////////////////////////////
    
    // Small Green
    CCSprite *smallGreen = [CCSprite spriteWithSpriteFrameName:@"smallgreen.png"];
    [bnTopGreen addChild:smallGreen];
    smallGreen.tag = kSmallGreen;
    smallGreen.anchorPoint = ccp(1,1);
    smallGreen.position = ccp(screenSize.width - 225, screenSize.height - 10);
    CCMoveBy *moveSmallGreen = [CCMoveBy actionWithDuration:3 position:ccp(-90,0)];
    [smallGreen runAction:moveSmallGreen]; // Pause for screenshot
    
    // Light
    CCSprite *light = [CCSprite spriteWithSpriteFrameName:@"light.png"];
    [bnTopGreen addChild:light];
    light.tag = kLight;
    light.anchorPoint = ccp(0.5,1);
    light.position = ccp(screenSize.width - 80, screenSize.height - 50);
    CCMoveBy *moveLight = [CCMoveBy actionWithDuration:3 position:ccp(-90,0)];
    [light runAction:moveLight]; // Pause for screenshot
    
    // LightOn
    self.lightOn = [CCSprite spriteWithSpriteFrameName:@"scene5_lightOn.png"];
    [bnTopGreen addChild:_lightOn z:50];
    _lightOn.tag = kLightOn;
    _lightOn.anchorPoint = ccp(0.5,0.5);
    _lightOn.position = ccp(_tree.position.x - 175, screenSize.height/2 + 80);
    [_lightOn setVisible:NO];
    isLightOn = NO;
    CCMoveBy *moveLightOn = [CCMoveBy actionWithDuration:3 position:ccp(-90,0)];
    [_lightOn runAction:moveLightOn];
    
    // Grass
    CCSprite *grass = [CCSprite spriteWithSpriteFrameName:@"grass.png"];
    [bnTopGreen addChild:grass];
    grass.tag = kGrass;
    grass.anchorPoint = ccp(0.5,0);
    grass.position = ccp(screenSize.width/2 - 80, screenSize.height * 0.03);
    CCMoveBy *moveGrass = [CCMoveBy actionWithDuration:3 position:ccp(-100,0)];
    [grass runAction:moveGrass]; // Pause for screenshot
    
    [self showGooma1st];
    [self loadDoor];
    [self loadRedMonsterRepeat];
    
    [self schedule:@selector(animateRedMonsterRepeat) interval:20.0 repeat:999 delay:5.0];
    
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

   // [self freezeAllObjects]; // pause for screenshot
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
            preload = [CCSprite spriteWithFile:@"scene5.pvr.ccz"];
            [preload setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
            [self addChild:preload z:99 tag:99];
        }
        if(result.height == 568)
        {
            CCSprite *preload;
            preload = [CCSprite spriteWithFile:@"scene5-568h.pvr.ccz"];
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

    //    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    // [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];

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

-(void)handleTapOnBird:(UITapGestureRecognizer *)aGestureRecognizer
{
    if (!isSwipedDown)
    {
        if (CGRectContainsPoint(_bird.boundingBox, touchLocation))
        {
            CCLOG(@"Bird is touched");
            CCShake *shake = [CCShake actionWithDuration:.5f amplitude:ccp(8,0) dampening:true shakes:0];
            [_bird runAction:[CCSequence actions:shake, [CCStopGrid action], nil]];
        }
        
        if (CGRectContainsPoint(_lightOn.boundingBox, touchLocation))
        {
            CCLOG(@"Light is touched");
            if (isLightOn)
            {
                [_lightOn setVisible:NO];
                isLightOn = NO;
                if ([SceneManager sharedSceneManager].isMusicOn == YES)
                    [[SimpleAudioEngine sharedEngine] playEffect:@"snd-switch.caf" pitch:1.0f pan:1.0f gain:0.5f];
            }
            else
            {
                [_lightOn setVisible:YES];
                isLightOn = YES;
                if ([SceneManager sharedSceneManager].isMusicOn == YES)
                    [[SimpleAudioEngine sharedEngine] playEffect:@"snd-switch.caf" pitch:1.0f pan:1.0f gain:0.5f];
            }
        }
        
        if (CGRectContainsPoint([[self getChildByTag:kBnOthers] getChildByTag:kSmallBlue].boundingBox, touchLocation))
        {
            CCLOG(@"SmallBlue is touched");
            CCShake *shake = [CCShake actionWithDuration:.5f amplitude:ccp(8,0) dampening:true shakes:0];
            [_smallBlueRepeat runAction:[CCSequence actions:shake, [CCStopGrid action], nil]];
        }

    }
}


@end
