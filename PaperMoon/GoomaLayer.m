//
//  GoomaLayer.m
//  PaperMoon
//
//  Created by Andy Woo on 5/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GoomaLayer.h"
#import "Scene6.h"

#define kGoomaRepeat 1
#define kGooma1st 2
#define kGoomaYelling 3

#define kBnGooma1st 10
#define kBnGoomaRepeat 11
#define kBnGoomaYelling 12


@implementation GoomaLayer

@synthesize goomaRepeat = _goomaRepeat;
@synthesize gooma1st = _gooma1st;
@synthesize goomaYelling = _goomaYelling;
@synthesize isGoomaRepeat;
@synthesize isGoomaYelling;


/*
-(BOOL) isTouchForMe:(CGPoint)touchLocation
{
    return CGRectContainsPoint(CGRectMake(320, 0, 180, 150), touchLocation);
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];

    bool isTouchHandled = [self isTouchForMe:location];
 
    if (isTouchHandled && isGoomaRepeat)
    {
   //     [self showGoomaOnce];
    }
    else if (isTouchHandled && isGoomaYelling)
    {
   //     [self showGoomaYellingOnce];
    }

}

*/


-(void)showGoomaOnce
{
    // CCLOG(@"isGoomaRepeat %d", isGoomaRepeat);
    if ((isGooma1st == NO) && (isGoomaRepeat == NO))
    {
        [_goomaRepeat stopAllActions];
        isGoomaRepeat = YES;
        isGoomaYelling = NO;
        _goomaYelling.visible = NO;
        _goomaRepeat.visible = YES;

            if ([[CCAnimationCache sharedAnimationCache] animationByName:@"goomaRepeat"] == nil)
            {
                NSMutableArray *animFrames = [NSMutableArray array];
                for(int i = 1; i <= 31; ++i)
                {
                    [animFrames addObject:
                     [frameCache spriteFrameByName:
                      [NSString stringWithFormat:@"scene6_goomaRepeat%d.png", i]]];
                }
                CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.12f];
                [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"goomaRepeat"];
                [animFrames removeAllObjects];
                [anim setRestoreOriginalFrame:NO];
            }
        CCLOG(@"gooma repeat once");
            CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"goomaRepeat"]];
        CCSequence *sequence = [CCSequence actions:
                                [CCCallBlock actionWithBlock:^{
            isGoomaRepeat = YES;
        }],
                                animate,
                                [CCCallBlock actionWithBlock:^{
            isGoomaRepeat = NO;
        }],
        nil];
        
            [_goomaRepeat runAction:sequence];
    
        CCSpriteFrame* frame = [frameCache spriteFrameByName:@"scene6_goomaYelling1.png"];
        [_goomaYelling setDisplayFrame:frame];
    }
}

-(void) prepareGoomaRepeat
{
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 31; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene6_goomaRepeat%d.png", i]]];
    }
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.12f];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"goomaRepeat"];
    [anim setRestoreOriginalFrame:NO];
    [animFrames removeAllObjects];
    
}

-(void)showGoomaRepeat
{
/*
  //  [_goomaRepeat stopAllActions];
    
        if ((isGooma1st == NO) && (isGoomaRepeat == NO))
        {
            CCLOG(@"Gooma Repeating...");
            isGoomaRepeat = YES;
            isGoomaYelling = NO;
            _goomaYelling.visible = NO;
            _goomaRepeat.visible = YES;
            
            if ([[CCAnimationCache sharedAnimationCache] animationByName:@"goomaRepeat"] == nil)
            {
                NSMutableArray *animFrames = [NSMutableArray array];
                for(int i = 1; i <= 31; ++i)
                {
                    [animFrames addObject:
                    [frameCache spriteFrameByName:
                      [NSString stringWithFormat:@"scene6_goomaRepeat%d.png", i]]];
                }
                CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.12f];
                [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"goomaRepeat"];
                [anim setRestoreOriginalFrame:NO];
                [animFrames removeAllObjects];
            }
            
            CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"goomaRepeat"]];
            CCRepeat *repeat = [CCRepeat actionWithAction:animate times:1];
            CCDelayTime *delay = [CCDelayTime actionWithDuration:12];
            CCSequence *sequence = [CCSequence actions:
                                    repeat,
                                    delay,
                                    nil];
            CCRepeatForever *repeatForever = [CCRepeatForever actionWithAction:sequence];
            [_goomaRepeat runAction:repeatForever];
            CCSpriteFrame* frame = [frameCache spriteFrameByName:@"scene6_goomaYelling1.png"];
            [_goomaYelling setDisplayFrame:frame];
        }
 */
}
 

-(void)cleanGooma1st
{
    [_gooma1st removeFromParentAndCleanup:YES];
    isGooma1st = NO;
}

-(void)showGooma1st
{
    
     _gooma1st.visible = YES;
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 24; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene6_gooma1st%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.12f];
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
    
    CCCallFunc *cleanGooma1st = [CCCallFunc actionWithTarget:self selector:@selector(cleanGooma1st)];
    CCCallFunc *didGooma1stFinished = [CCCallFunc actionWithTarget:self selector:@selector(showGoomaOnce)];
  //   CCCallFunc *didGooma1stFinished = [CCCallFunc actionWithTarget:self selector:@selector(showGoomaRepeat)];
    
    CCSequence *sequence = [CCSequence actions:
                            animate,
                            [CCCallBlock actionWithBlock:^{
        isGooma1st = NO;
    }],
                            cleanGooma1st,
                            didGooma1stFinished,
                            
                            
                            nil];
    [anim setRestoreOriginalFrame:NO];
    
    [_gooma1st runAction:sequence]; // Pause for screenshot
    
    [animFrames removeAllObjects];
    
}

-(void) prepareGoomaYellingAnimation
{
    NSMutableArray *animFrames = [NSMutableArray array];
    for(int i = 1; i <= 27; ++i)
    {
        [animFrames addObject:
         [frameCache spriteFrameByName:
          [NSString stringWithFormat:@"scene6_goomaYelling%d.png", i]]];
    }
    
    
    CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames delay:0.12f];
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"goomaYelling"];
    [anim setRestoreOriginalFrame:NO];
    [animFrames removeAllObjects];
}

-(void)showGoomaYellingOnce
{
    if ([_goomaYelling numberOfRunningActions] == 0)
    {
        isGoomaYelling = YES;
        isGoomaRepeat = NO;
        [_goomaRepeat setVisible:NO];
                
        CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"goomaYelling"]];
        [_goomaYelling runAction:animate];
        [_goomaYelling setVisible:YES];
    }
}

-(void)showGoomaYelling
{
    [_goomaRepeat setVisible:NO];
  
    isGoomaRepeat = NO;
    if (!isGoomaYelling) {
        isGoomaYelling = YES;
        isGoomaRepeat = NO;
        [_goomaRepeat setVisible:NO];
        CCAnimate *animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"goomaYelling"]];
        [_goomaYelling runAction:animate];
        [_goomaYelling setVisible:YES];
    }

}

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);

    }
    return self;
    
}

-(void)unFreezeAllGoomaLayer
{
    [self resumeSchedulerAndActions];
    
    if ([[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st]];
    }
    
    if ([[self getChildByTag:kBnGoomaRepeat] getChildByTag:kGoomaRepeat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGoomaRepeat] getChildByTag:kGoomaRepeat]];
    }
    
    if ([[self getChildByTag:kBnGoomaYelling] getChildByTag:kGoomaYelling] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:[[self getChildByTag:kBnGoomaYelling] getChildByTag:kGoomaYelling]];
    }
    
}

-(void)freezeAllGoomaLayer
{
    [self pauseSchedulerAndActions];
    
    if ([[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGooma1st] getChildByTag:kGooma1st]];
    }
    
    if ([[self getChildByTag:kBnGoomaRepeat] getChildByTag:kGoomaRepeat] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGoomaRepeat] getChildByTag:kGoomaRepeat]];
    }
    
    if ([[self getChildByTag:kBnGoomaYelling] getChildByTag:kGoomaYelling] != nil)
    {
        [[[CCDirector sharedDirector] actionManager] pauseTarget:[[self getChildByTag:kBnGoomaYelling] getChildByTag:kGoomaYelling]];
    }
        
}



-(void)startAnimation
{
    isGoomaYelling = NO;
    isGoomaRepeat = NO;
    isGooma1st = YES;
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    // Gooma Repeat Batch node
    [frameCache addSpriteFramesWithFile:@"scene6_goomaRepeat.plist"];
    bnGoomaRepeat = [CCSpriteBatchNode batchNodeWithFile:@"scene6_goomaRepeat.pvr.ccz"];
    [self addChild:bnGoomaRepeat z:5 tag:kBnGoomaRepeat]; // was tag:kLayerTagGoomaRepeat
    [self prepareGoomaRepeat];
    
    // Gooma1st Batch node
    [frameCache addSpriteFramesWithFile:@"scene6_gooma1st.plist"];
    bnGooma1st = [CCSpriteBatchNode batchNodeWithFile:@"scene6_gooma1st.pvr.ccz"];
    [self addChild:bnGooma1st z:5 tag:kBnGooma1st];
    
    // GoomaYelling Batch node
    [frameCache addSpriteFramesWithFile:@"scene6_goomaYelling.plist"];
    bnGoomaYelling = [CCSpriteBatchNode batchNodeWithFile:@"scene6_goomaYelling.pvr.ccz"];
    [self addChild:bnGoomaYelling z:5 tag:kBnGoomaYelling];
    [self prepareGoomaYellingAnimation];
    
    // Gooma Yelling Sprite
    self.goomaYelling = [CCSprite spriteWithSpriteFrameName:@"scene6_goomaYelling1.png"];
    [bnGoomaYelling addChild:_goomaYelling];
    _goomaYelling.tag = kGoomaYelling;
    _goomaYelling.anchorPoint = ccp(0.5,0.5);
    _goomaYelling.position = ccp(screenSize.width/2, screenSize.height/2);
    _goomaYelling.visible = NO;
    
    // Gooma1st Sprite
    self.gooma1st = [CCSprite spriteWithSpriteFrameName:@"scene6_gooma1st1.png"];
    [bnGooma1st addChild:_gooma1st];
    _gooma1st.tag = kGooma1st;
    _gooma1st.anchorPoint = ccp(0.5,0.5);
    _gooma1st.position = ccp(screenSize.width/2, screenSize.height/2);
    _gooma1st.visible = NO;
    
    // GoomaRepeat Sprite
    self.goomaRepeat = [CCSprite spriteWithSpriteFrameName:@"scene6_goomaRepeat1.png"];
    [bnGoomaRepeat addChild:_goomaRepeat];
    _goomaRepeat.tag = kGoomaRepeat;
    _goomaRepeat.anchorPoint = ccp(0.5,0.5);
    _goomaRepeat.position = ccp(screenSize.width/2, screenSize.height/2);
    _goomaRepeat.visible = NO;
    
    [self showGooma1st];
  //  [self freezeAllGoomaLayer];
}


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
    //  [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    
}

@end
