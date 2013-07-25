//
//  ObjectsLayer.m
//  PaperMoon
//
//  Created by Andy Woo on 6/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ObjectsLayer.h"
#import "Scene6Layer.h"
#import "CurtainWaves.h" 
#import "SceneManager.h"
#import "SimpleAudioEngine.h"


#define kString 1
#define kFlash 2
#define kCurtainOpenRepeat 3
#define kCurtainClosing 4
#define kSky 5
#define kSun 6
#define kCurtainClosedRepeatLeft 7
#define kCurtainClosedRepeatRight 8
#define kRod 9
#define kFlower 10
#define kFox 11
#define kLeaf1 12
#define kLeaf2 13
#define kLeaf3 14
#define kSea 15
#define kPot 16

#define kBnOthers 20
#define kBnCurtainOpenRepeat 21
#define kBnCurtainClosing 22
#define kBnSky 23


@implementation ObjectsLayer


@synthesize string = _string;
@synthesize flash = _flash;
@synthesize curtainOpenRepeat = _curtainOpenRepeat;
@synthesize curtainClosing = _curtainClosing;
@synthesize sky = _sky;
@synthesize sun = _sun;
@synthesize curtainClosedRepeatLeft = _curtainClosedRepeatLeft;
@synthesize curtainClosedRepeatRight = _curtainClosedRepeatRight;
@synthesize rod = _rod;
@synthesize flower = _flower;






-(BOOL) isTouchForMe:(CGPoint)touchLocation
{
    return  CGRectContainsPoint(CGRectMake(250, 110, 120, 120), touchLocation);
}


-(void)toggleWindow
{
    if (self.curtainOpenRepeat.visible) [self.curtainOpenRepeat setVisible:NO];
 
        if (windowState == stateClosed)
        { // to Open

            [self showCurtainClosing:kOpen];
            windowState = stateOpen;
            CCLOG(@"Window state: %i", stateOpen);
            
            if ([SceneManager sharedSceneManager].isMusicOn == YES)
                [[SimpleAudioEngine sharedEngine] playEffect:@"snd-openCurtain.caf" pitch:1.0f pan:1.0f gain:0.5f];
        }
        else
        { // To Close
     
            [self showCurtainClosing:kClose];
            windowState = stateClosed;
             CCLOG(@"Window state: %i", stateClosed);
            if ([SceneManager sharedSceneManager].isMusicOn == YES)
                [[SimpleAudioEngine sharedEngine] playEffect:@"snd-closeCurtain.caf" pitch:1.0f pan:1.0f gain:0.5f];
        }

}

-(void) showCurtainOpenRepeat
{
    [_curtainOpenRepeat stopAllActions];
    if (!self.curtainOpenRepeat.visible) [self.curtainOpenRepeat setVisible:YES];
    currentState = kOpen;
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 6; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene6_curtainOpenRepeat%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"openCurtain"];
    [anim setRestoreOriginalFrame:NO];
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    CCAction *reverse = [[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"openCurtain"]] reverse];
    CCSequence *sequence = [CCSequence actions:animate,
                            reverse,
                            nil];
    CCRepeatForever *repeatForever = [CCRepeatForever actionWithAction:sequence];
   [_curtainOpenRepeat runAction:repeatForever]; // Pause for screenshot
    
     [_curtainClosing setVisible:NO];
}

-(void) showCurtainClosedWaving
{
    if (!self.curtainClosedRepeatLeft.visible) [self.curtainClosedRepeatLeft setVisible:YES];
    if (!self.curtainClosedRepeatRight.visible) [self.curtainClosedRepeatRight setVisible:YES];
    if (!self.rod.visible) [self.rod setVisible:YES];
    if (!self.flower.visible) [self.flower setVisible:YES];
    
    int angleCurtainLeft = (arc4random() % 10) / 10;   // Left hand side
    int angleCurtainRight = (arc4random() % 10) / 10;  // Right hand side
    CCRotateTo *rockCurtainLeft = [CCRotateTo actionWithDuration:1 angle:angleCurtainLeft];
    CCRotateTo *rockCurtainRight = [CCRotateTo actionWithDuration:1 angle:-angleCurtainRight];
    CCSequence *sequenceCurtainLeft = [CCSequence actions:
                               rockCurtainLeft,
                               rockCurtainRight, nil];
    CCAction *repeatCurtainLeft = [CCRepeatForever actionWithAction:sequenceCurtainLeft];
  
    
    int angleCurtainLeft2 = (arc4random() % 10) / 10;   // Left hand side
    int angleCurtainRight2 = (arc4random() % 10) / 10;  // Right hand side
    CCRotateTo *rockCurtainLeft2 = [CCRotateTo actionWithDuration:1 angle:angleCurtainLeft2];
    CCRotateTo *rockCurtainRight2 = [CCRotateTo actionWithDuration:1 angle:-angleCurtainRight2];
    CCSequence *sequenceCurtainRight = [CCSequence actions:
                                       rockCurtainLeft2,
                                       rockCurtainRight2, nil];
    CCAction *repeatCurtainRight = [CCRepeatForever actionWithAction:sequenceCurtainRight];
    [_curtainClosedRepeatLeft runAction:repeatCurtainLeft];
    [_curtainClosedRepeatRight runAction:repeatCurtainRight];
    
//    CurtainWaves *waveLeft = [CurtainWaves actionWithWaves:5 amplitude:8 horizontal:NO vertical:YES grid:ccg(10,5) duration:20];
 //   [_curtainClosedRepeatLeft runAction:[CCRepeatForever actionWithAction:waveLeft]];
    
  //  CurtainWaves *waveRight = [CurtainWaves actionWithWaves:5 amplitude:8 horizontal:NO vertical:YES grid:ccg(10,5) duration:20];
  //  [_curtainClosedRepeatRight runAction:[CCRepeatForever actionWithAction:waveRight]];
    
}

/*
-(void) prepareCurtainClosedRepeatAnimation
{
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 6; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene6_curtainClosedRepeat%d.png", i]]];
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.3f];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"closedCurtainRepeat"];
    [animFrames removeAllObjects];
}
 */

-(void) prepareCloseCurtainAnimation
{
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 6; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene6_curtainClosing%d.png", i]]];
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"closeCurtain"];
    [animFrames removeAllObjects];
    
}

-(void)showCurtainClosing:(ActionTypes)action
{
    currentState = kClose;
    
    if (action == kOpen)
    { // Open curtain
        [_curtainClosing setVisible:YES];
        CCCallFunc *callCurtainOpenRepeat = [CCCallFunc actionWithTarget:self selector:@selector(showCurtainOpenRepeat)];
        CCCallBlock *hideCurtainClosing = [CCCallBlock actionWithBlock:^{
            [_curtainClosing stopAllActions];
            [_curtainClosing setVisible:NO];
        }];
        CCCallBlock *hideCurtainClosedRepeat = [CCCallBlock actionWithBlock:^{

            if (self.rod.visible) [self.rod setVisible:NO];
            if (self.flower.visible) [self.flower setVisible:NO];
            if (self.curtainClosedRepeatLeft.visible)
                                                {
                                                    [self.curtainClosedRepeatLeft stopAllActions];
                                                    [self.curtainClosedRepeatLeft setVisible:NO];
                                                }
                                                if (self.curtainClosedRepeatRight.visible)
                                                {
                                                    [self.curtainClosedRepeatRight stopAllActions];
                                                    [self.curtainClosedRepeatRight setVisible:NO];
                                                }
        }];
        
        CCSequence *sequence = [CCSequence actions:
                                hideCurtainClosedRepeat,
                                [[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"closeCurtain"]] reverse],
                                hideCurtainClosing,
                                callCurtainOpenRepeat,
                                nil];
        [_curtainClosing runAction:sequence];


    }
    else // action == kClose
    { // Close curtain
        [_curtainClosing setVisible:YES];
         CCCallFunc *callCurtainClosedRepeat = [CCCallFunc actionWithTarget:self selector:@selector(showCurtainClosedWaving)];
        CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"closeCurtain"]];
        CCCallBlock *hideCurtainClosing = [CCCallBlock actionWithBlock:^{
            [_curtainClosing stopAllActions];
            [_curtainClosing setVisible:NO];
        }];
        CCSequence *sequence = [CCSequence actions:animate,
                                hideCurtainClosing,
                                callCurtainClosedRepeat,
                                nil];
        [_curtainClosing runAction:sequence];
 
    }
    
}

-(void)animateString
{
    didPullString = YES;
    [self flashOff];
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 56; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene6_string%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.05f];
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    
    
    [anim setRestoreOriginalFrame:NO];
    
    [_string runAction:animate];
    
    [animFrames removeAllObjects];
    
}

-(void)flashOff
{
    [_flash setVisible:NO];
}

-(id) init
{
    self = [super init];
    if (self != nil)
    {
 
    }

    return self;
}

-(void)timerUpdate
{
   //  CGSize screenSize = [[CCDirector sharedDirector] winSize];
    if (windowState == kClose && fox.opacity == 50)
    {
        CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:3.0 opacity:255];
        [fox runAction:fadeIn];

    }
    else if (windowState == kOpen && fox.opacity == 255)
    {
        CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:3.0 opacity:50];
        [fox runAction:fadeOut];
    }
    
    if (fox.opacity == 50)
    {
       [[Scene6Layer sharedLayer] startGoomaYelling];
  //      CCLOG(@"fox dispear");
  //      CCLOG(@"sharedLayer object %@", [Scene6Layer sharedLayer]);
    }
    else if (fox.opacity == 255)
    {
        [[Scene6Layer sharedLayer] startGoomaRepeat];
   //     CCLOG(@"fox shown");
    }

}

-(void)unFreezeAllObjectsLayer
{
    [self resumeSchedulerAndActions];
    
    if ([[self getChildByTag:kBnSky] getChildByTag:kSky] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnSky] getChildByTag:kSky]];
    }
    
    if ([[self getChildByTag:kBnSky] getChildByTag:kLeaf1] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnSky] getChildByTag:kLeaf1]];
    }
    
    if ([[self getChildByTag:kBnSky] getChildByTag:kLeaf2] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnSky] getChildByTag:kLeaf2]];
    }
    
    if ([[self getChildByTag:kBnSky] getChildByTag:kLeaf3] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnSky] getChildByTag:kLeaf3]];
    }
    
    if ([[self getChildByTag:kBnSky] getChildByTag:kSun] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnSky] getChildByTag:kSun]];
    }
    
    if ([[self getChildByTag:kBnSky] getChildByTag:kSea] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnSky] getChildByTag:kSea]];
    }
    
    if ([[self getChildByTag:kBnCurtainOpenRepeat] getChildByTag:kCurtainOpenRepeat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnCurtainOpenRepeat] getChildByTag:kCurtainOpenRepeat]];
    }
    
    if ([[self getChildByTag:kBnCurtainClosing] getChildByTag:kCurtainClosing] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnCurtainClosing] getChildByTag:kCurtainClosing]];
    }
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kFox] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnOthers] getChildByTag:kFox]];
    }
    
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kPot] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnOthers] getChildByTag:kPot]];
    }
    
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kString] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnOthers] getChildByTag:kString]];
    }
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kFlash] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnOthers] getChildByTag:kFlash]];
    }
    
    if ([self getChildByTag:kRod] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[self getChildByTag:kRod]];
    }
    
    if ([self getChildByTag:kFlower] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[self getChildByTag:kFlower]];
    }
    
    if ([self getChildByTag:kCurtainClosedRepeatRight] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[self getChildByTag:kCurtainClosedRepeatRight]];
    }
    
    if ([self getChildByTag:kCurtainClosedRepeatLeft] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[self getChildByTag:kCurtainClosedRepeatLeft]];
    }
    
}

-(void)freezeAllObjectsLayer
{
    [self pauseSchedulerAndActions];
    
    if ([[self getChildByTag:kBnSky] getChildByTag:kSky] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnSky] getChildByTag:kSky]];
    }
    
    if ([[self getChildByTag:kBnSky] getChildByTag:kLeaf1] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnSky] getChildByTag:kLeaf1]];
    }
    
    if ([[self getChildByTag:kBnSky] getChildByTag:kLeaf2] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnSky] getChildByTag:kLeaf2]];
    }
    
    if ([[self getChildByTag:kBnSky] getChildByTag:kLeaf3] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnSky] getChildByTag:kLeaf3]];
    }
    
    if ([[self getChildByTag:kBnSky] getChildByTag:kSun] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnSky] getChildByTag:kSun]];
    }
    
    if ([[self getChildByTag:kBnSky] getChildByTag:kSea] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnSky] getChildByTag:kSea]];
    }
    
    if ([[self getChildByTag:kBnCurtainOpenRepeat] getChildByTag:kCurtainOpenRepeat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnCurtainOpenRepeat] getChildByTag:kCurtainOpenRepeat]];
    }
    
    if ([[self getChildByTag:kBnCurtainClosing] getChildByTag:kCurtainClosing] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnCurtainClosing] getChildByTag:kCurtainClosing]];
    }
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kFox] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnOthers] getChildByTag:kFox]];
    }
    
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kPot] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnOthers] getChildByTag:kPot]];
    }
        
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kString] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnOthers] getChildByTag:kString]];
    }
    
    if ([[self getChildByTag:kBnOthers] getChildByTag:kFlash] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnOthers] getChildByTag:kFlash]];
    }
    
    if ([self getChildByTag:kRod] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[self getChildByTag:kRod]];
    }
    
    if ([self getChildByTag:kFlower] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[self getChildByTag:kFlower]];
    }
    
    if ([self getChildByTag:kCurtainClosedRepeatRight] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[self getChildByTag:kCurtainClosedRepeatRight]];
    }
    
    if ([self getChildByTag:kCurtainClosedRepeatLeft] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[self getChildByTag:kCurtainClosedRepeatLeft]];
    }
    
}



-(void)startAnimation
{
    
    windowState = stateOpen;
    didPullString = NO;
    
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Background
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
           
            CCSprite * background = [CCSprite spriteWithFile:@"scene6_background.pvr.ccz"];
            background.anchorPoint = ccp(0,0.5);
            background.position = ccp(0,screenSize.height/2);
            [self addChild:background z:2 tag:kLayerTagBackground];
        }
        if(result.height == 568)
        {
            
            CCSprite * background = [CCSprite spriteWithFile:@"scene6_background-568h.pvr.ccz"];
            background.anchorPoint = ccp(0,0.5);
            background.position = ccp(0,screenSize.height/2);
            [self addChild:background z:2 tag:kLayerTagBackground];
        }
    }
    
    // Static Sky
    [frameCache addSpriteFramesWithFile:@"scene6_sky.plist"];
    bnSky = [CCSpriteBatchNode batchNodeWithFile:@"scene6_sky.pvr.ccz"];
    [self addChild:bnSky z:1 tag:kBnSky];
    self.sky = [CCSprite spriteWithSpriteFrameName:@"scene6_sky.png"];
    [_sky setColor:ccc3(138, 106, 160)];
    [bnSky addChild:_sky];
    _sky.tag = kSky;
    _sky.anchorPoint = ccp(0.5,0.5);
    _sky.position = ccp(screenSize.width/2, screenSize.height/2);
    CCTintTo *tintToWhite = [CCTintTo actionWithDuration:5.0 red:255 green:255 blue:255];
    [_sky runAction:tintToWhite]; // Pause for screenshot
   
    // Leaves
    CCSprite *leaf1 = [CCSprite spriteWithSpriteFrameName:@"scene6_leaf1.png"];
    CCSprite *leaf2 = [CCSprite spriteWithSpriteFrameName:@"scene6_leaf2.png"];
    CCSprite *leaf3 = [CCSprite spriteWithSpriteFrameName:@"scene6_leaf3.png"];
    [bnSky addChild:leaf1];
    [bnSky addChild:leaf2];
    [bnSky addChild:leaf3];
    leaf1.tag = kLeaf1;
    leaf2.tag = kLeaf2;
    leaf3.tag = kLeaf3;
    leaf1.anchorPoint = ccp(0.5,0.5);
    leaf2.anchorPoint = ccp(0.5,0.5);
    leaf3.anchorPoint = ccp(0.5,0.5);
    leaf1.position = ccp(screenSize.width/2, screenSize.height/2);
    leaf2.position = ccp(screenSize.width/2, screenSize.height/2);
    leaf3.position = ccp(screenSize.width/2, screenSize.height/2);
    
    // Leaf 1
    CCRotateTo *rotateLeft1 = [CCRotateTo actionWithDuration:1.0 angle:2.0];
    CCRotateTo *rotateRight1 = [CCRotateTo actionWithDuration:1.0 angle:-2.0];
    id waitRandomTime1 = [CCDelayTime actionWithDuration: (arc4random()%8)/10];
    CCSequence *sequenceLeaf1 = [CCSequence actions:
                            waitRandomTime1,
                            rotateLeft1,
                            rotateRight1,
                            nil];
    CCRepeatForever *rock1 = [CCRepeatForever actionWithAction:sequenceLeaf1];
    [leaf1 runAction:rock1];  // Pause for screenshot
    
    // Leaf 2
    CCRotateTo *rotateLeft2 = [CCRotateTo actionWithDuration:1.0 angle:1.5];
    CCRotateTo *rotateRight2 = [CCRotateTo actionWithDuration:1.0 angle:-1.5];
    id waitRandomTime2 = [CCDelayTime actionWithDuration: (arc4random()%8)/10];
    CCSequence *sequenceLeaf2 = [CCSequence actions:
                                 waitRandomTime2,
                                 rotateLeft2,
                                 rotateRight2,
                                 nil];
    CCRepeatForever *rock2 = [CCRepeatForever actionWithAction:sequenceLeaf2];
    [leaf2 runAction:rock2];  // Pause for screenshot
    
    // Leaf 3
    CCRotateTo *rotateLeft3 = [CCRotateTo actionWithDuration:1.0 angle:1.0];
    CCRotateTo *rotateRight3 = [CCRotateTo actionWithDuration:1.0 angle:-1.0];
    id waitRandomTime3 = [CCDelayTime actionWithDuration: (arc4random()%8)/10];
    CCSequence *sequenceLeaf3 = [CCSequence actions:
                                 waitRandomTime3,
                                 rotateLeft3,
                                 rotateRight3,
                                 nil];
    CCRepeatForever *rock3 = [CCRepeatForever actionWithAction:sequenceLeaf3];
    [leaf3 runAction:rock3];  // Pause for screenshot

    
    // Sun
    self.sun = [CCSprite spriteWithSpriteFrameName:@"scene6_sun.png"];
    _sun.anchorPoint = ccp(0.5,0.5);
    _sun.position = ccp(screenSize.width/2 - 80 ,screenSize.height/2 - 80);
    [bnSky addChild:_sun];
    _sun.tag = kSun;
    CCMoveBy *move = [CCMoveBy actionWithDuration:5.0 position:ccp(80,80)];
    [_sun runAction:move];  // Pause for screenshot
    
    // Static Sea
    CCSprite *sea = [CCSprite spriteWithSpriteFrameName:@"scene6_sea.png"];
    sea.anchorPoint = ccp(0.5,0.5);
    sea.position = ccp(screenSize.width/2,screenSize.height/2);
    [bnSky addChild:sea];
    sea.tag = kSea;
   
    
    // Other images Batchnode
    [frameCache addSpriteFramesWithFile:@"scene6_others.plist"];
    bnOthers = [CCSpriteBatchNode batchNodeWithFile:@"scene6_others.pvr.ccz"];
    [self addChild:bnOthers z:5 tag:kBnOthers];

    
    // curtainOpenRepeat Batchnode
    [frameCache addSpriteFramesWithFile:@"scene6_curtainOpenRepeat.plist"];
    bnCurtainOpenRepeat = [CCSpriteBatchNode batchNodeWithFile:@"scene6_curtainOpenRepeat.pvr.ccz"];
    
    self.curtainOpenRepeat = [CCSprite spriteWithSpriteFrameName:@"scene6_curtainOpenRepeat1.png"];
    [bnCurtainOpenRepeat addChild:_curtainOpenRepeat];
    _curtainOpenRepeat.tag = kCurtainOpenRepeat;
    _curtainOpenRepeat.anchorPoint = ccp(0.5, 0.5);
    _curtainOpenRepeat.position = ccp(screenSize.width/2, screenSize.height/2);
    [self addChild:bnCurtainOpenRepeat z:3 tag:kBnCurtainOpenRepeat];
    [self showCurtainOpenRepeat];
    
    
    [frameCache addSpriteFramesWithFile:@"scene6_curtainClosedLeft.plist"];
    [frameCache addSpriteFramesWithFile:@"scene6_curtainClosedRight.plist"];
    
    // curtainClosedLeft
    self.curtainClosedRepeatLeft = [CCSprite spriteWithSpriteFrameName:@"scene6_curtainClosedRepeatLeft.png"];
    [self addChild:_curtainClosedRepeatLeft z:4];
    _curtainClosedRepeatLeft.tag = kCurtainClosedRepeatLeft;
    _curtainClosedRepeatLeft.anchorPoint = ccp(0.5,1);
    _curtainClosedRepeatLeft.position = ccp(screenSize.width/2, screenSize.height);
    _curtainClosedRepeatLeft.visible=NO;
    

    
    // curtainClosedRight
    self.curtainClosedRepeatRight = [CCSprite spriteWithSpriteFrameName:@"scene6_curtainClosedRepeatRight.png"];
    [self addChild:_curtainClosedRepeatRight z:4];
    _curtainClosedRepeatRight.tag = kCurtainClosedRepeatRight;
    _curtainClosedRepeatRight.anchorPoint = ccp(0.5,1);
    _curtainClosedRepeatRight.position = ccp(screenSize.width/2, screenSize.height);
    _curtainClosedRepeatRight.visible=NO;
    
    // Rod
    [frameCache addSpriteFramesWithFile:@"scene6_rod.plist"];
    self.rod = [CCSprite spriteWithSpriteFrameName:@"rod.png"];
    [self addChild:_rod z:3];
    _rod.tag = kRod;
    _rod.anchorPoint = ccp(0.5,0.5);
    _rod.position = ccp(screenSize.width/2, screenSize.height/2);
    [_rod setVisible:NO];
    
    // Flower
    [frameCache addSpriteFramesWithFile:@"scene6_flower.plist"];
    self.flower = [CCSprite spriteWithSpriteFrameName:@"scene6_flower.png"];
    [self addChild:_flower z:3];
    _flower.tag = kFlower;
    _flower.anchorPoint = ccp(0.5,0.5);
    _flower.position = ccp(screenSize.width/2, screenSize.height/2);
    [_flower setVisible:NO];

    
    // curtainClosing Batchnode
    [frameCache addSpriteFramesWithFile:@"scene6_curtainClosing.plist"];
    bnCurtainClosing = [CCSpriteBatchNode batchNodeWithFile:@"scene6_curtainClosing.pvr.ccz"];
    
    self.curtainClosing = [CCSprite spriteWithSpriteFrameName:@"scene6_curtainClosing1.png"];
    [bnCurtainClosing addChild:_curtainClosing];
    _curtainClosing.tag = kCurtainClosing;
    _curtainClosing.anchorPoint = ccp(0.5, 0.5);
    _curtainClosing.position = ccp(screenSize.width/2, screenSize.height/2);
    [_curtainClosing setVisible:NO];
    [self addChild:bnCurtainClosing z:4 tag:kBnCurtainClosing];
    [self prepareCloseCurtainAnimation];
    
    // string
    self.string = [CCSprite spriteWithSpriteFrameName:@"scene6_string1.png"];
    [bnOthers addChild:_string];
    _string.tag = kString;
    _string.anchorPoint = ccp(0.5,0.5);
    _string.position = ccp(screenSize.width/2, screenSize.height/2);
    
    // Flash
    self.flash = [CCSprite spriteWithSpriteFrameName:@"flash.png"];
    [bnOthers addChild:_flash z:50];
    _flash.tag = kFlash;
    _flash.anchorPoint = ccp(0.5,0.5);
    _flash.position = ccp(screenSize.width/2 - 40, screenSize.height/2 + 5);
    _flash.scale = 1.5;
    
    CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:1.0];
    CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:1.0];
    CCDelayTime *delay = [CCDelayTime actionWithDuration:0.5];
    CCSequence *sequence = [CCSequence actions:fadeIn, delay, fadeOut, delay, nil];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:sequence];
    [_flash runAction:repeat]; // Pause for screenshot
    
    // Moon Fox
    fox = [CCSprite spriteWithSpriteFrameName:@"moonfox-clear.png"];
    [bnOthers addChild:fox];
    fox.tag = kFox;
    fox.anchorPoint = ccp(0.5,0.5);
    fox.position = ccp(screenSize.width/2, screenSize.height/2);
    fox.opacity = 255;
    
    // Pot
    CCSprite *pot = [CCSprite spriteWithSpriteFrameName:@"pot.png"];
    [bnOthers addChild:pot];
    pot.tag = kPot;
    pot.anchorPoint = ccp(0.5,0.5);
    pot.position = ccp(screenSize.width/2, screenSize.height/2);

    
    windowState = kOpen;
    
    [self schedule:@selector(timerUpdate) interval:1]; // Pause for screenshot
  //  [self freezeAllObjectsLayer];

}

/*
- (void)update:(float)dt
{
    totalTime += dt;
    [_curtainClosedRepeatLeft.shaderProgram use];
  //  [_curtainClosedRepeatRight.shaderProgram use];
    glUniform1f(timeUniformLocation, totalTime);
 //   glUniform1f(timeUniformLocation1, totalTime);
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

}

-(void) onEnterTransitionDidFinish
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super onEnterTransitionDidFinish];
    
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
    //   [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];

}

@end
