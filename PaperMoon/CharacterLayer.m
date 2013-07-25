//
//  CharacterLayer.m
//  PaperMoon
//
//  Created by Andy Woo on 25/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CharacterLayer.h"
#import "SceneManager.h"
// #import "LoadingScene.h"
#import "CCNode+SFGestureRecognizers.h"
#import "AppDelegate.h"
#import "ClippingNode.h"
#import "SettingLayer.h"
#import "CCShake.h"
// #import "UIDevice+Hardware.h"

#define kpositionY 0.92
#define kSettingBar 99

// #define IPHONE4 ([[[UIDevice currentDevice] hardwareDescription] isEqualToString:@"iPhone 4"] || [[[UIDevice currentDevice] hardwareDescription] isEqualToString:@"iPhone 4 (CDMA)"])
// #define IPHONE5 ([[[UIDevice currentDevice] hardwareDescription] isEqualToString:@"iPhone 5"] || [[[UIDevice currentDevice] hardwareDescription] isEqualToString:@"iPhone 5 (GSM+CDMA)"])

#define kGoomaRepeat 1
#define kGoomaSprite 2
#define kAnimGooma 3
#define kGoomaAway 4
#define kFrontWave 5
#define kFrontWave2nd 6
#define kFrontWaveRepeat 7
#define kBackWave 8
#define kBackWaveRepeat 9
#define kTitle 50

#define kBnGoomaRepeat 10
#define kSpriteSheet1 11
#define kSpriteSheet2 12
#define kSpriteSheet3 13
#define kSpriteSheet 14
#define kBnBackWave 15
#define kBnBackWaveRepeat 16
#define kBnFrontWave 17
#define kBnFrontWaveRepeat 18
#define kBnFrontWave2nd 19

@implementation CharacterLayer
{
    BOOL didShownSettingBar;
}

@synthesize title = _title;
@synthesize hand = _hand;
@synthesize swipeFinger = _swipeFinger;
@synthesize tap = _tap;
@synthesize goomaSprite = _goomaSprite;
@synthesize goomaSprite1 = _goomaSprite1;
@synthesize goomaSprite2 = _goomaSprite2;
@synthesize backwave = _backwave;
@synthesize backwaveRepeat = _backwaveRepeat;
@synthesize frontwave = _frontwave;
@synthesize frontwaveRepeat = _frontwaveRepeat;
@synthesize frontwave2nd = _frontwave2nd;
@synthesize goomaRepeat = _goomaRepeat;


-(void)showSettingLayerHint
{
    CCFadeTo *fadeTo = [CCFadeTo actionWithDuration:1.0 opacity:255];
    CCDelayTime *delay = [CCDelayTime actionWithDuration:5.0];
    //  CCMoveBy *moveBy = [CCMoveBy actionWithDuration:0.5 position:ccp(0, 50)];
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:1.0 opacity:0];
    CCSequence *sequence = [CCSequence actions:
                            fadeTo,
                            delay,
                            //    moveBy,
                            fadeOut,
                            nil];
    [(CCSprite*)[self getChildByTag:kSettingBar] runAction:sequence];
}

-(void) makeTransition
{
    [[SceneManager sharedSceneManager] runSceneWithID:kScene2 withDirection:kLeft withSender:[self parent]];
}

-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    UIDevice *currDevice = [UIDevice currentDevice];
    [currDevice beginGeneratingDeviceOrientationNotifications];
    
    float newAccelerationY = acceleration.y;
    
    if (currDevice.orientation == 3)
        newAccelerationY = -newAccelerationY;
    
  //  CCLOG(@"newAccelerationY = %f", newAccelerationY);
   
    
    if (newAccelerationY < -0.1)
    {
        CCAction *rotate = [CCRotateTo actionWithDuration:0.5f angle:5];
        [_title runAction:rotate];
  //      CCLOG(@"rotation: %f", _title.rotation);
    }
    else if (newAccelerationY > 0.1)
    {
        CCAction *rotate = [CCRotateTo actionWithDuration:0.5f angle:-5];
        [_title runAction:rotate];
    }
    else
    {
        CCAction *restore = [CCRotateTo actionWithDuration:1.0f angle:0];
        [_title runAction:restore];
    }
}



-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    if (!isSwipedDown)
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 568)
            {
             //   if ((!didTouched) && (CGRectContainsPoint(CGRectMake(winSize.width * 0.22, winSize.height * 0.12, 640, 490), location)) && didGoomaAnimationFinish)
                if ((!didTouched) && (CGRectContainsPoint(CGRectMake(winSize.width / 3.0, winSize.height / 3.0, winSize.width / 3.0, winSize.height / 3.0), location)) && didGoomaAnimationFinish)
                {
                    [self animGooma];
                    [_hand stopActionByTag:1];
                    CCFadeTo *fadeTo = [CCFadeTo actionWithDuration:1.0 opacity:0];
                    [_hand runAction:fadeTo];
                    [self unschedule: @selector(showHand)];
                    didTouched = YES;
                }
                
                if (CGRectContainsPoint(CGRectMake(0, 271, 568, 320), location))
                {
                    CCLOG(@"You touched the setting bar");
                    didShownSettingBar = YES;
                    
                    /*
                    CCCallBlock *makeSettingLayerVisible = [CCCallBlock actionWithBlock:^{
                        [[[[self parent] parent] getChildByTag:2] setVisible:YES];
                    }];
                    CCCallBlock *makeSettingLayerInVisible = [CCCallBlock actionWithBlock:^{
                        [[[[self parent] parent] getChildByTag:2] setVisible:NO];
                    }];
                    CCMoveBy *moveSceneDown = [CCMoveBy actionWithDuration:0.08 position:ccp(0, -30)];
                    CCEaseIn *easeSceneDown = [CCEaseIn actionWithAction:moveSceneDown rate:1];
                    CCDelayTime *delayMoveSceneDown = [CCDelayTime actionWithDuration:0.1];
                    CCMoveBy *moveSceneUp = [CCMoveBy actionWithDuration:0.05 position:ccp(0, 30)];
                    CCEaseIn *easeSceneUp = [CCEaseIn actionWithAction:moveSceneUp rate:1];
                    CCShake *shakeUpDown = [CCShake actionWithDuration:.1f amplitude:ccp(0,8) dampening:true shakes:2];
                    CCSequence *sequenceGiggleSceneUpDown = [CCSequence actions:
                                                       easeSceneDown,
                                                             makeSettingLayerVisible,
                                                       delayMoveSceneDown,
                                                       easeSceneUp,
                                                       shakeUpDown,
                                                             makeSettingLayerInVisible,
                                                       nil];
                    [[[[self parent] parent] getChildByTag:1] runAction:sequenceGiggleSceneUpDown];
                    [[[[self parent]  getChildByTag:0] getChildByTag: kSettingBar] setVisible:NO];
                    CCLOG(@" object %@",[[[self parent] getChildByTag:0] getChildByTag: kSettingBar] );
                     */
                }
                
            }
            if(result.height == 480)
            {
                if ((!didTouched) && (CGRectContainsPoint(CGRectMake(winSize.width / 3.0, winSize.height / 3.0, winSize.width / 3.0, winSize.height / 3.0), location)) && didGoomaAnimationFinish)
                {
                    [self animGooma];
                    
                    [_hand stopActionByTag:1];
                    CCFadeTo *fadeTo = [CCFadeTo actionWithDuration:1.0 opacity:0];
                    [_hand runAction:fadeTo];
                    
                    [self unschedule: @selector(showHand)];
                    didTouched = YES;
                }
                
            }
        }
    }
    

    
}



 - (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
 
     return YES;
}


-(void) cleanupGoomaSprite2
{
    [_goomaSprite2 removeFromParentAndCleanup:YES];
}

-(void) cleanupGoomaSprite1
{
    [_goomaSprite1 removeFromParentAndCleanup:YES];
}

-(void) moveAwayGooma
{
     CGSize winSize = [CCDirector sharedDirector].winSize;
    
    [_goomaSprite1 removeFromParentAndCleanup:YES];
    
    NSMutableArray *animFrames1 = [NSMutableArray array];
    for(int j = 1; j <= 46; ++j)
    {
        [animFrames1 addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"scene1_gooma_3rd%d.png", j]]];
    }
    CCAnimation *anim1 = [CCAnimation animationWithSpriteFrames:animFrames1 delay:0.08f];
    self.goomaSprite2 = [CCSprite spriteWithSpriteFrameName:@"scene1_gooma_3rd1.png"];

    [spriteSheet3 addChild:_goomaSprite2];
    _goomaSprite2.tag = kGoomaAway;
    
    [animFrames1 removeAllObjects];
    
    
    _goomaSprite2.anchorPoint = ccp(0,0.5);
    _goomaSprite2.position = ccp(0, winSize.height/2 * kpositionY);
    
    CCAnimate *animate1 = [CCAnimate actionWithAnimation:anim1];
    [anim1 setRestoreOriginalFrame:NO];
    

    
    CCCallFunc *cleanUp = [CCCallFunc actionWithTarget:self selector:@selector(cleanupGoomaSprite2)];
    
    CCSequence *sequence = [CCSequence actions:animate1,
                         
                               cleanUp,
                         
                            nil];
    [_goomaSprite2 runAction:sequence];

  
    
}

-(void) animGooma
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    [_goomaRepeat removeFromParentAndCleanup:YES];
    
    NSMutableArray *animFrames1 = [NSMutableArray array];
    for(int j = 1; j <= 21; ++j)
    {
        [animFrames1 addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"scene1_gooma_2nd%d.png", j]]];
    }
    CCAnimation *anim1 = [CCAnimation animationWithSpriteFrames:animFrames1 delay:0.1f];
    self.goomaSprite1 = [CCSprite spriteWithSpriteFrameName:@"scene1_gooma_2nd21.png"];
    [spriteSheet2 addChild:_goomaSprite1];
    _goomaSprite1.tag = kAnimGooma;
    
    [animFrames1 removeAllObjects];
    
    _goomaSprite1.anchorPoint = ccp(0,0.5);
    _goomaSprite1.position = ccp(0, winSize.height/2 * kpositionY);
    CCAnimate *animate1 = [CCAnimate actionWithAnimation:anim1];
    [anim1 setRestoreOriginalFrame:NO];
    
    CCSequence *sequence = [CCSequence actions:animate1, 
                            [CCCallFunc actionWithTarget:self selector:@selector(moveAwayGooma)],

                            [CCCallFunc actionWithTarget:self selector:@selector(cleanupGoomaSprite1)],
                            
                            [CCCallFunc actionWithTarget:self selector:@selector(showTitle)],
                            
                            nil];
    
    [_goomaSprite1 runAction:sequence];
    
}

-(void) repeatGooma
{

    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
      didGoomaAnimationFinish = YES;
    [_goomaSprite removeFromParentAndCleanup:YES];
    NSMutableArray *animFrames1 = [NSMutableArray array];
    for(int j = 1; j <= 10; ++j) // original end at 21
    {
        [animFrames1 addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"scene1_goomaRepeat%d.png", j]]];
    }
    CCAnimation *anim1 = [CCAnimation animationWithSpriteFrames:animFrames1 delay:0.10f];
    self.goomaRepeat = [CCSprite spriteWithSpriteFrameName:@"scene1_goomaRepeat1.png"];
    [bnGoomaRepeat addChild:_goomaRepeat];
    _goomaRepeat.tag = kGoomaRepeat;
    
    [animFrames1 removeAllObjects];
    
    _goomaRepeat.anchorPoint = ccp(0,0.5);
    _goomaRepeat.position = ccp(0, winSize.height/2 *kpositionY);
    CCAnimate *animate1 = [CCAnimate actionWithAnimation:anim1];
    [anim1 setRestoreOriginalFrame:NO];
    
    CCAction *repeat = [CCRepeatForever actionWithAction:animate1];
        
    [_goomaRepeat runAction:repeat];
    
    // preload go away gooma
    [frameCache addSpriteFramesWithFile:@"scene1_gooma_3rd.plist"];
    spriteSheet3 = [CCSpriteBatchNode
                    batchNodeWithFile:@"scene1_gooma_3rd.pvr.ccz"];
    [self addChild:spriteSheet3 z:3 tag:kSpriteSheet3];

}

-(void) showGoomaSprite
{
    // Animation with showGoomaSprite
        
    
    NSMutableArray *animFrames = [NSMutableArray array];
  
    
    for(int i = 1; i <= 21; ++i)
    {
        [animFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"scene1_gooma%d.png", i]]];
    }
    

    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.18f];
    [animFrames removeAllObjects];
    [anim setRestoreOriginalFrame:NO];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    self.goomaSprite = [CCSprite spriteWithSpriteFrameName:@"scene1_gooma1.png"];
    
    _goomaSprite.anchorPoint = ccp(0,0.5);
    _goomaSprite.position = ccp(0, winSize.height/2 * kpositionY);
    _goomaSprite.tag = kGoomaSprite;
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    CCSequence *sequence = [CCSequence actions:animate,
                            [CCCallFunc actionWithTarget:self selector:@selector(repeatGooma)],
                            nil];
    
    [_goomaSprite runAction:sequence]; // pause for screenshot
    
    [spriteSheet1 addChild:_goomaSprite];
   

}

-(void) showFrontWaveRepeat
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"scene1_frontwave_repeat.plist"];
    
    bnFrontWaveRepeat = [CCSpriteBatchNode
                         batchNodeWithFile:@"scene1_frontwave_repeat.pvr.ccz"];
    
    [self addChild:bnFrontWaveRepeat z:2 tag:kBnFrontWaveRepeat];
    
    [_frontwave2nd removeFromParentAndCleanup:YES];
    [bnFrontWave2nd removeFromParentAndCleanup:YES];
    NSMutableArray *animFrames = [NSMutableArray array];
    
    
    for(int i = 1; i <= 35; ++i)
    {
        [animFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"scene1_frontwaveRepeat%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.10f];
    
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    self.frontwaveRepeat = [CCSprite spriteWithSpriteFrameName:@"scene1_frontwaveRepeat1.png"];
    
    [animFrames removeAllObjects];
    _frontwaveRepeat.anchorPoint = ccp(0.5,0.5);
    _frontwaveRepeat.position = ccp(winSize.width/2, winSize.height/2);
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    
    
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
    
    [_frontwaveRepeat runAction:repeat];
    
    [bnFrontWaveRepeat addChild:_frontwaveRepeat];
    _frontwaveRepeat.tag = kFrontWaveRepeat;
    
    
}

-(void) showFrontWave2nd


{
     frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    [frameCache addSpriteFramesWithFile:@"scene1_frontwave_2nd.plist"];
    
    bnFrontWave2nd = [CCSpriteBatchNode
                      batchNodeWithFile:@"scene1_frontwave_2nd.pvr.ccz"];
    
    [self addChild:bnFrontWave2nd z:2 tag:kBnFrontWave2nd];
    
    [_frontwave removeFromParentAndCleanup:YES];
    [bnFrontWave removeFromParentAndCleanup:YES];
    NSMutableArray *animFrames = [NSMutableArray array];
    
    
    for(int i = 31; i <= 65; ++i)
    {
        [animFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"scene1_frontwave%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    self.frontwave2nd = [CCSprite spriteWithSpriteFrameName:@"scene1_frontwave31.png"];
    
    [animFrames removeAllObjects];
    _frontwave2nd.anchorPoint = ccp(0.5,0.5);
    _frontwave2nd.position = ccp(winSize.width/2, winSize.height/2);
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    
    
    CCSequence *sequence = [CCSequence actions:animate,
                            [CCCallFunc actionWithTarget:self selector:@selector(showFrontWaveRepeat)],
                            
                            nil];
    
    [_frontwave2nd runAction:sequence];
    
    [bnFrontWave2nd addChild:_frontwave2nd];
    _frontwave2nd.tag = kFrontWave2nd;
    
}

-(void) showFrontWave1st
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    [frameCache addSpriteFramesWithFile:@"scene1_frontwave_1st.plist"];
    
    bnFrontWave = [CCSpriteBatchNode
                   batchNodeWithFile:@"scene1_frontwave_1st.pvr.ccz"];
    [self addChild:bnFrontWave z:2 tag:kBnFrontWave];
    
    NSMutableArray *animFrames = [NSMutableArray array];
    
    
    for(int i = 1; i <= 30; ++i)
    {
        [animFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"scene1_frontwave%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    self.frontwave = [CCSprite spriteWithSpriteFrameName:@"scene1_frontwave1.png"];
    
    [animFrames removeAllObjects];
    _frontwave.anchorPoint = ccp(0.5,0.5);
    _frontwave.position = ccp(winSize.width/2, winSize.height/2);
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    
    
    CCSequence *sequence = [CCSequence actions:animate,
                        //    [CCCallFunc actionWithTarget:self selector:@selector(showFrontWaveRepeat)],
                           [CCCallFunc actionWithTarget:self selector:@selector(showFrontWave2nd)],
                            nil];
    
    [_frontwave runAction:sequence]; // pause for screenshot
    
    [bnFrontWave addChild:_frontwave];
    _frontwave.tag = kFrontWave;
    
}

-(void) showBackWaveRepeat
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    [frameCache addSpriteFramesWithFile:@"scene1_backwaveRepeat.plist"];
    
    bnBackWaveRepeat = [CCSpriteBatchNode
                        batchNodeWithFile:@"scene1_backwaveRepeat.pvr.ccz"];
    
    [self addChild:bnBackWaveRepeat z:1 tag:kBnBackWaveRepeat];
    
    [_backwave removeFromParentAndCleanup:YES];
    NSMutableArray *animFrames = [NSMutableArray array];
    
    
    for(int i = 1; i <= 41; ++i)
    {
        [animFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"scene1_backwaveRepeat%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    self.backwaveRepeat = [CCSprite spriteWithSpriteFrameName:@"scene1_backwaveRepeat1.png"];
    
    [animFrames removeAllObjects];
    _backwaveRepeat.anchorPoint = ccp(0.5,0.5);
    _backwaveRepeat.position = ccp(winSize.width/2, winSize.height/2);
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    
    
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
    
    [_backwaveRepeat runAction:repeat];
    
    [bnBackWaveRepeat addChild:_backwaveRepeat];
    _backwaveRepeat.tag = kBackWaveRepeat;
    
}



-(void) showBackWave1st
{
     frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"scene1_backwave_1st.plist"];
    
    bnBackWave = [CCSpriteBatchNode
                  batchNodeWithFile:@"scene1_backwave_1st.pvr.ccz"];
    
    [self addChild:bnBackWave z:1 tag:kBnBackWave];
    
    NSMutableArray *animFrames = [NSMutableArray array];
    
    
    for(int i = 1; i <= 45; ++i)
    {
        [animFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"scene1_backwave%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.25f];
    
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    self.backwave = [CCSprite spriteWithSpriteFrameName:@"scene1_backwave1.png"];
    
    [animFrames removeAllObjects];
    _backwave.anchorPoint = ccp(0.5,0.5);
    _backwave.position = ccp(winSize.width/2, winSize.height/2);
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    
    
    CCSequence *sequence = [CCSequence actions:animate,
                            [CCCallFunc actionWithTarget:self selector:@selector(showBackWaveRepeat)],
                            
                        nil];
    
     [_backwave runAction:sequence]; // pause for screenshot
    
    [bnBackWave addChild:_backwave];
    _backwave.tag = kBackWave;
    
}

-(void) showHand
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    _hand.anchorPoint = ccp(0.5,0.5);
    _hand.position = ccp(300 ,screenSize.height - 200);
    CCScaleBy *scaleUpTap = [CCScaleBy actionWithDuration:0.1 scale:1.2];
    CCScaleTo *scaleToTap = [CCScaleTo actionWithDuration:0.1 scale:1.0];
    CCSequence *sequenceTap = [CCSequence actions:scaleUpTap, scaleToTap, nil];
    CCFadeIn *fadeInHand = [CCFadeIn actionWithDuration:0.3];
    CCScaleBy *scaleToHand = [CCScaleBy actionWithDuration:0.5 scale:0.8];
    CCSequence *sequenceHand = [CCSequence actions:fadeInHand,
                                [CCCallBlock actionWithBlock:^{
                                    CCMoveBy *moveToHand = [CCMoveBy actionWithDuration:0.5 position:ccp(-50.0, 50.0)];
                                    [_hand runAction:moveToHand];
                                }],
                                [CCDelayTime actionWithDuration:1.0],
                                scaleToHand,
                                [CCCallBlock actionWithBlock:^{
                                                        CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:0.1];
                                                        CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:0.5];
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
                               [CCDelayTime actionWithDuration:1.0],
                                [CCCallBlock actionWithBlock:^{
                                        CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:0.5];
                                        [_hand runAction:fadeOut];
                                }],
                                [CCCallBlock actionWithBlock:^{
                                        CCMoveTo *moveToHand = [CCMoveTo actionWithDuration:2.0 position:ccp(300,screenSize.height - 200)];
                                        [_hand runAction:moveToHand];
                                }],
                                nil];
    
    [_hand runAction:sequenceHand];
    
    sequenceHand.tag = 1;

}

-(void) cycleShowSwipe
{
    [self schedule:@selector(showSwipe) interval:5.0 repeat:999 delay:1.0];
}

-(void) update:(ccTime)delta
{
    CGPoint tempPos = _swipeFinger.position;
    tempPos.x = tempPos.x + 10;
    tempPos.y = tempPos.y + 20;
    
    streck.position = tempPos;
}


-(void) showSwipe
{
    isShowingSwiping = YES;
    [_swipeFinger stopAllActions];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    _swipeFinger.anchorPoint = ccp(0.5,0.5);
    _swipeFinger.position = ccp(screenSize.width - 100,screenSize.height - 200);
    

    
    

    CCFadeIn *fadeInHand = [CCFadeIn actionWithDuration:0.3];
    CCScaleBy *scaleToHand = [CCScaleBy actionWithDuration:0.3 scale:0.8];
    CCSequence *sequenceHand = [CCSequence actions:fadeInHand,
                                scaleToHand,
                                [CCCallBlock actionWithBlock:^{
        [streck setVisible:YES];
        CCMoveBy *moveToHand = [CCMoveBy actionWithDuration:0.5 position:ccp(-150.0, 0.0)];
        [_swipeFinger runAction:moveToHand];
    }],
                                [CCDelayTime actionWithDuration:0.5],
                               // scaleToHand,
                                [CCCallBlock actionWithBlock:^{
        CCScaleTo *scaleBackHand = [CCScaleTo actionWithDuration:0.3 scale:1];
        [_swipeFinger runAction:scaleBackHand];
    }],
                                [CCDelayTime actionWithDuration:0.5],
                                [CCCallBlock actionWithBlock:^{
        CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:0.2];
        [_swipeFinger runAction:fadeOut];
    }],
                                [CCCallBlock actionWithBlock:^{
        [streck setVisible:NO];
        CCMoveTo *moveToHand = [CCMoveTo actionWithDuration:2.0 position:ccp(screenSize.width - 100,screenSize.height - 200)];
        [_swipeFinger runAction:moveToHand];
    }],
                                nil];
    
    [_swipeFinger runAction:sequenceHand];
    
    sequenceHand.tag = 1;

    
}

-(void) showTitle
{
    // Animation with title
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 18; ++i)
    {
        [animFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"title%d.png", i]]];
    }
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.1f];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    self.title = [CCSprite spriteWithSpriteFrameName:@"title1.png"];
    [spriteSheet addChild:_title];
    [animFrames removeAllObjects];
   
    _title.anchorPoint = ccp(0.5, 1);
    _title.position = ccp(winSize.width/2, winSize.height+10);
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    [anim setRestoreOriginalFrame:NO];
    
    CCEaseIn *easeIn = [CCEaseIn actionWithAction:animate rate:1];
    CCCallFunc *callShowSwipe = [CCCallFunc actionWithTarget:self selector:@selector(cycleShowSwipe)];
    CCSequence *sequence = [CCSequence actions:easeIn,
                            callShowSwipe,
                            nil];

    [_title runAction:sequence];
  //  [self scheduleOnce:@selector(makeTransition:) delay:5.0f];
    
}



-(void) startAnimation
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
   //
    // Pre-load Gooma images
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
   // [frameCache addSpriteFramesWithFile:@"scene1_gooma_1st.plist"];
    
    spriteSheet1 = [CCSpriteBatchNode
                    batchNodeWithFile:@"scene1_gooma_1st.pvr.ccz"];
    
    [self addChild:spriteSheet1 z:3 tag:kSpriteSheet1];
    
  //  [frameCache addSpriteFramesWithFile:@"scene1_gooma_2nd.plist"];
    spriteSheet2 = [CCSpriteBatchNode
                    batchNodeWithFile:@"scene1_gooma_2nd.pvr.ccz"];
    [self addChild:spriteSheet2 z:3 tag:kSpriteSheet2];

 //   [frameCache addSpriteFramesWithFile:@"scene1_goomaRepeat.plist"];
    bnGoomaRepeat = [CCSpriteBatchNode
                     batchNodeWithFile:@"scene1_goomaRepeat.pvr.ccz"];
    [self addChild:bnGoomaRepeat z:3 tag:kBnGoomaRepeat];
    
 //   [frameCache addSpriteFramesWithFile:@"title.plist"];
    
    spriteSheet = [CCSpriteBatchNode
                   batchNodeWithFile:@"title.pvr.ccz"];
    [self addChild:spriteSheet z:10 tag:kSpriteSheet];
    
    [self showGoomaSprite];
    
    //  Load hand
  //  CGSize screenSize = [[CCDirector sharedDirector] winSize];
     self.hand = [CCSprite spriteWithSpriteFrameName:@"hand-hd.png"];
  //  self.hand = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] textureForKey:@"hand-hd.png"]];
    _hand.anchorPoint = ccp(0.5,0.5);
 //   _hand.position = ccp(screenSize.width - 140,screenSize.height - 200);
    _hand.position = ccp(300.0,screenSize.height - 200);
    _hand.opacity = 0;
    [spriteSheet addChild:_hand z:55];
    
    // Load Tap
     self.tap = [CCSprite spriteWithSpriteFrameName:@"tap-hd.png"];
  //  self.tap = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] textureForKey:@"tap-hd.png"]];
    _tap.anchorPoint = ccp(0.5,0.5);
 //   _tap.position = ccp(_hand.position.x - 17.0 - 50, _hand.position.y + 17.0 + 50);
    _tap.position = ccp(_hand.position.x - 17.0 - 50, _hand.position.y + 17.0 + 50);
    _tap.opacity = 0;
    [spriteSheet addChild:_tap z:50];
    
    // Load SwipeFinger
    self.swipeFinger = [CCSprite spriteWithSpriteFrameName:@"swipefinger-hd.png"];
    _swipeFinger.anchorPoint = ccp(0.5, 0.5);
    _swipeFinger.position = ccp(300.0,screenSize.height - 200);
    _swipeFinger.opacity = 0;
    [spriteSheet addChild:_swipeFinger z:55];
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
    streck = [CCMotionStreak streakWithFade:0.5 minSeg:0.5 width:5 color:ccWHITE textureFilename:@"swipetrail-hd.png"];
    [self addChild:streck z:54];
    [streck setVisible:NO];
    [streck reset];
 
    
     [self schedule:@selector(showHand) interval:10.0 repeat:999 delay:1.5]; // Pause for screenshot
    [self showBackWave1st];
    [self showFrontWave1st];
    
 
    
    //    self.isTouchEnabled = YES;
    self.isAccelerometerEnabled = YES;
    didGoomaAnimationFinish = NO;
    didTouched = NO;
    
    // Top
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            CCSprite * top = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] textureForKey:@"top.pvr.ccz"]];
            top.anchorPoint = ccp(0.5,0.5);
            top.position = ccp(screenSize.width/2,screenSize.height/2);
            [self addChild:top z:50];
        }
        if(result.height == 568)
        {
            CCSprite * top = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] textureForKey:@"top-568h.pvr.ccz"]];
            top.anchorPoint = ccp(0.5,0.5);
            top.position = ccp(screenSize.width/2,screenSize.height/2);
            [self addChild:top z:50];
            
            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
            CCSprite * settingBar = [CCSprite spriteWithFile:@"scene1_settingBar-568h.pvr.ccz"];
            settingBar.anchorPoint = ccp(0.5,1.0);
            settingBar.position = ccp(screenSize.width/2 ,screenSize.height);
            [self addChild:settingBar z:100 tag:kSettingBar];
            [settingBar setOpacity:0];
        }
    }
  //  [self freezeAllObjects]; // pause for screenshot
    
    [self scheduleUpdate];
    
}

-(void)unFreezeAllObjects
{
    [self resumeSchedulerAndActions];
   
    // Gooma Repeat
    if ([[self getChildByTag:kBnGoomaRepeat] getChildByTag:kGoomaRepeat] != nil)
    {
    [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGoomaRepeat] getChildByTag:kGoomaRepeat]];
    }
    else
        CCLOG(@"Gooma Repeat is not available");
    
    // Gooma Anim
    if ([[self getChildByTag:kSpriteSheet2] getChildByTag:kAnimGooma] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet2] getChildByTag:kAnimGooma]];
    }
    else
        CCLOG(@"Gooma Anim is not available");
    
    // Gooma Move Away
    if ([[self getChildByTag:kSpriteSheet3] getChildByTag:kGoomaAway] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet3] getChildByTag:kGoomaAway]];
    }
    else
        CCLOG(@"Gooma Move Away is not available");
    
    // Gooma Sprite
    if ([[self getChildByTag:kSpriteSheet1] getChildByTag:kGoomaSprite] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet1] getChildByTag:kGoomaSprite]];
    }
    else
        CCLOG(@"Gooma Sprite is not available");
    
    if ([[self getChildByTag:kBnFrontWaveRepeat] getChildByTag:kFrontWaveRepeat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnFrontWaveRepeat] getChildByTag:kFrontWaveRepeat]];
    }
    
    if ([[self getChildByTag:kBnFrontWave2nd] getChildByTag:kFrontWave2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnFrontWave2nd] getChildByTag:kFrontWave2nd]];
    }
    
    if ([[self getChildByTag:kBnFrontWave] getChildByTag:kFrontWave] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnFrontWave] getChildByTag:kFrontWave]];
    }
    
    if ([[self getChildByTag:kBnBackWaveRepeat] getChildByTag:kBackWaveRepeat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnBackWaveRepeat] getChildByTag:kBackWaveRepeat]];
    }
    
    if ([[self getChildByTag:kBnBackWave] getChildByTag:kBackWave] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnBackWave] getChildByTag:kBackWave]];
    }
    
    if ([[self getChildByTag:kSpriteSheet] getChildByTag:kTitle] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kSpriteSheet] getChildByTag:kTitle]];
    }
}

-(void)freezeAllObjects
{
    [self pauseSchedulerAndActions];
   
    // Gooma Repeat
    if ([[self getChildByTag:kBnGoomaRepeat] getChildByTag:kGoomaRepeat] != nil)
    {
    [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGoomaRepeat] getChildByTag:kGoomaRepeat]];
    }
    else
        CCLOG(@"Gooma Repeat is not available");
    
    // Gooma Anim
    if ([[self getChildByTag:kSpriteSheet2] getChildByTag:kAnimGooma] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet2] getChildByTag:kAnimGooma]];
    }
    else
        CCLOG(@"Gooma Anim is not available");
    
    // Gooma Move Away
    if ([[self getChildByTag:kSpriteSheet3] getChildByTag:kGoomaAway] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet3] getChildByTag:kGoomaAway]];
        CCLOG(@"goomaaway %@", [[self getChildByTag:kSpriteSheet3] getChildByTag:kGoomaAway] );
    //    CCLOG(@"spritesheet3 %@",[[self getChildByTag:kSpriteSheet3] children]  );
    }
    else
        CCLOG(@"Gooma Move Away is not available");
    
    // Gooma Sprite
    if ([[self getChildByTag:kSpriteSheet1] getChildByTag:kGoomaSprite] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet1] getChildByTag:kGoomaSprite]];
    }
    else
        CCLOG(@"Gooma Sprite is not available");
    
    
    if ([[self getChildByTag:kBnFrontWaveRepeat] getChildByTag:kFrontWaveRepeat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnFrontWaveRepeat] getChildByTag:kFrontWaveRepeat]];
    }
    
    if ([[self getChildByTag:kBnFrontWave2nd] getChildByTag:kFrontWave2nd] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnFrontWave2nd] getChildByTag:kFrontWave2nd]];
    }
    
    if ([[self getChildByTag:kBnFrontWave] getChildByTag:kFrontWave] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnFrontWave] getChildByTag:kFrontWave]];
    }
    
    if ([[self getChildByTag:kBnBackWaveRepeat] getChildByTag:kBackWaveRepeat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnBackWaveRepeat] getChildByTag:kBackWaveRepeat]];
    }
  
    if ([[self getChildByTag:kBnBackWave] getChildByTag:kBackWave] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnBackWave] getChildByTag:kBackWave]];
    }
   
    if ([[self getChildByTag:kSpriteSheet] getChildByTag:kTitle] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kSpriteSheet] getChildByTag:kTitle]];
    }
    
}

-(id) init
{
    self = [super init];
    if (self != nil)
    {
    
        self.isTouchEnabled = YES;
        isShowingSwiping = NO;
        didShownSettingBar = NO;
        
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
    
    // Pre-load a static image for scene transition
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height == 480)
    {
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        CCSprite * preload = [CCSprite spriteWithFile:@"scene1.pvr.ccz"];
        preload.anchorPoint = ccp(0.5,0.5);
        preload.position = ccp(screenSize.width/2 ,screenSize.height/2);
        [self addChild:preload z:99 tag:99];
    }
    if(result.height == 568)
    {
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        CCSprite * preload = [CCSprite spriteWithFile:@"scene1-568h.pvr.ccz"];
        preload.anchorPoint = ccp(0.5,0.5);
        preload.position = ccp(screenSize.width/2,screenSize.height/2);
        [self addChild:preload z:99 tag:99];
    }
     
    
}


-(void)prepareForTransition
{
    [self unscheduleAllSelectors];
    [self unscheduleUpdate];
}


-(void) onExit
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
    [super onExit];
   

}

-(void) onEnterTransitionDidFinish
{
     [super onEnterTransitionDidFinish];
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    CCFadeTo *fadeTo = [CCFadeTo actionWithDuration:0.05 opacity:0];
    [[self getChildByTag:99] runAction:fadeTo];
    
    SettingLayer *aSettingLayer = (SettingLayer*)[[[self parent] parent] getChildByTag:2];
    [aSettingLayer.btnHome setOpacity:100];
    [aSettingLayer.homeItem setIsEnabled:NO];
    
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
         CCLOG(@"cart item = %d", app.cartItem);
        [aSettingLayer.btnCart setOpacity:0];
        [aSettingLayer.cartItem setIsEnabled:NO];
        
    }
    
    aSettingLayer = nil;
    
    CCLOG(@"Scene %@", [[[self parent] parent] getChildByTag:2]);

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
   
  //  [[[CCDirector sharedDirector] touchDispatcher]removeDelegate:self];
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

-(void)handleSwipeLeft:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    [self prepareForTransition];
    [self makeTransition];
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer *)aGestureRecognizer
{
   // [self freezeAllObjects];
    CCMoveBy *moveSceneRight = [CCMoveBy actionWithDuration:0.1 position:ccp(50, 0)];
    CCEaseIn *easeSceneRight = [CCEaseIn actionWithAction:moveSceneRight rate:2];
    CCDelayTime *delayMoveSceneRight = [CCDelayTime actionWithDuration:0.1];
    CCMoveBy *moveSceneLeft = [CCMoveBy actionWithDuration:0.1 position:ccp(-50, 0)];
    CCEaseIn *easeSceneLeft = [CCEaseIn actionWithAction:moveSceneLeft rate:2];
    CCShake *shake = [CCShake actionWithDuration:.1f amplitude:ccp(16,0) dampening:true shakes:0];
    CCSequence *sequenceGiggleScene = [CCSequence actions:
                                easeSceneRight,
                                delayMoveSceneRight,
                                easeSceneLeft,
                                shake,
                                nil];
    [[[self parent] parent] runAction:sequenceGiggleScene];
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
    CCMoveTo *moveUp = [CCMoveTo actionWithDuration:0.2 position:ccp(0,0)];
    CCSequence *sequenceUp = [CCSequence actions:
                              moveUp,
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
        [(CCSprite*)[self getChildByTag:kSettingBar] setVisible:NO];
        CCCallBlock *writeIsSwipeDown = [CCCallBlock actionWithBlock:^{
            isSwipedDown = YES;
            AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
            app.isSwipeDown = YES;
        }];
        CCMoveTo *moveDown = [CCMoveTo actionWithDuration:0.2 position:ccp(0,-55)];
        CCCallBlock *makeSettingLayerVisible = [CCCallBlock actionWithBlock:^{
            [[[[self parent] parent] getChildByTag:2] setVisible:YES];
        }];
        CCSequence *sequenceDown = [CCSequence actions:
                                    makeSettingLayerVisible,
                                    moveDown,
                                    writeIsSwipeDown,
                                   [CCCallBlock actionWithBlock:^{
            [self freezeAllObjects];
                                    }],
                                    nil];
        [[[[self parent] parent] getChildByTag:1] runAction:sequenceDown];
    }
}

@end
