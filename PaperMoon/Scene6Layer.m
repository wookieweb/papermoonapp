//
//  Scene6Layer.m
//  PaperMoon
//
//  Created by Andy Woo on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Scene6Layer.h"
#import "SceneManager.h"
#import "Scene6.h"
#import "AppDelegate.h"
#import "SettingLayer.h"

#import "CCNode+SFGestureRecognizers.h"

@implementation Scene6Layer


static Scene6Layer *instance;

-(void)startGoomaRepeat
{
    GoomaLayer *gooma = [self goomaLayer];
   // [gooma showGoomaRepeat];
    [gooma showGoomaOnce];
 //   CCLOG(@"show gooma repeat");
}

-(void)stopGoomaRepeat
{
    GoomaLayer *gooma = [self goomaLayer];
    [[[gooma getChildByTag:kLayerTagGoomaRepeat] getChildByTag:10] stopAllActions];
}

-(void)startGoomaYelling
{
    GoomaLayer *gooma = [self goomaLayer];
//    [self stopGoomaRepeat];
 //   CCLOG(@"show gooma yelling");
    [gooma showGoomaYelling];
}

+(Scene6Layer*)sharedLayer
{
    NSAssert(instance != nil, @"Scene6Layer not available!");
    return instance;
}

-(GoomaLayer*)goomaLayer
{
    CCNode *layer = [self getChildByTag:kLayerTagGoomaRepeat];
    NSAssert([layer isKindOfClass:[GoomaLayer class]], @"%@: not a GoomaLayer!", NSStringFromSelector(_cmd));
    return (GoomaLayer*)layer;
}

-(ObjectsLayer*)objectsLayer
{
    CCNode *layer = [self getChildByTag:kLayerTagObjects];
        NSAssert([layer isKindOfClass:[ObjectsLayer class]], @"%@: not a ObjectsLayer!", NSStringFromSelector(_cmd));
    return (ObjectsLayer*)layer;
}

-(Scene6Layer*)scene6Layer
{
    CCNode *layer = [self getChildByTag:kLayerTagScene6Layer];
    NSAssert([layer isKindOfClass:[Scene6Layer class]], @"%@: not a Scene6Layer!", NSStringFromSelector(_cmd));
    return (Scene6Layer*)layer;
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

-(void) makeTransitionBack
{
    [[SceneManager sharedSceneManager] runSceneWithID:kScene5 withDirection:kRight withSender:[self parent]];
}


-(void) makeTransitionForward
{
    [[SceneManager sharedSceneManager] runSceneWithID:kScene7 withDirection:kLeft withSender:[self parent]];
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
    touchLocation = location;

    if (!isSwipedDown)
    {
        if (CGRectContainsPoint(CGRectMake(250, 110, 120, 120), location))
        {
     //       CCLOG(@"pull string");
            if ([self.objectsLayer.string numberOfRunningActions] == 0)
            {
                [self.objectsLayer toggleWindow];
                [self.objectsLayer animateString];
            }
       
        }
        else if (CGRectContainsPoint(CGRectMake(320, 0, 180, 150), location))
        {
     //       CCLOG(@"tap Gooma");
            if (self.goomaLayer.isGoomaRepeat)
            {
    //            [self.goomaLayer showGoomaOnce];
            }
            else if (self.goomaLayer.isGoomaYelling)
            {
     //           [self.goomaLayer showGoomaYellingOnce];
            }

      
        }
    }
}


-(id) init
{
    self = [super init];
    if (self != nil)
    {
        
        instance = self;
        self.isTouchEnabled = YES;
        isSwipedDown = NO;
        GoomaLayer *goomaLayer = [GoomaLayer node];
        [self addChild:goomaLayer z:10 tag:kLayerTagGoomaRepeat];
        
        ObjectsLayer *objectsLayer = [ObjectsLayer node];
        [self addChild:objectsLayer z:8 tag:kLayerTagObjects];
        
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

-(void)startAnimation
{
    
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
    // Top
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            CGSize screenSize = [[CCDirector sharedDirector] winSize];
            CCSprite * top = [CCSprite spriteWithFile:@"top.pvr.ccz"];
            top.anchorPoint = ccp(0.5,0.5);
            top.position = ccp(screenSize.width/2,screenSize.height/2);
            [self addChild:top z:50];
        }
        if(result.height == 568)
        {
            CGSize screenSize = [[CCDirector sharedDirector] winSize];
            CCSprite * top = [CCSprite spriteWithFile:@"top-568h.pvr.ccz"];
            top.anchorPoint = ccp(0.5,0.5);
            top.position = ccp(screenSize.width/2,screenSize.height/2);
            [self addChild:top z:50];
        }
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
            preload = [CCSprite spriteWithFile:@"scene6.pvr.ccz"];
            [preload setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
            [self addChild:preload z:99 tag:99];
        }
        if(result.height == 568)
        {
            CCSprite *preload;
            preload = [CCSprite spriteWithFile:@"scene6-568h.pvr.ccz"];
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
    
    SettingLayer *aSettingLayer = (SettingLayer*)[[self parent]  getChildByTag:2];
    
    /*
    [aSettingLayer.btnBack setOpacity:0];
    [aSettingLayer.backItem setIsEnabled:NO];
    
    [aSettingLayer.btnForward setOpacity:0];
    [aSettingLayer.forwardItem setIsEnabled:NO];
    
    [aSettingLayer.btnStop setOpacity:0];
    [aSettingLayer.stopItem setIsEnabled:NO];
    */
    
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

   // instance = nil;
    //    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
   
    
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
                              [CCSpawn actions:moveUp, nil],
                              turnIsSwipeDownToYes,
                              makeSettingLayerInVisible,
                            
                              nil];
    [self runAction:sequenceUp];
}

-(void)handleSwipeUp:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    if (isSwipedDown)
    {
            [self.objectsLayer unFreezeAllObjectsLayer];
            [self.goomaLayer unFreezeAllGoomaLayer];
            [self moveSceneUp];
    }
}



-(void)handleSwipeDown:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    if (!isSwipedDown)
    {
         CGSize screenSize = [[CCDirector sharedDirector] winSize];
        if (((touchLocation.x <= screenSize.width/2.5) || (touchLocation.x>= screenSize.width/1.25)) || (touchLocation.y >= screenSize.height/1.67))
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
                                 [self.objectsLayer freezeAllObjectsLayer];
                                [self.goomaLayer freezeAllGoomaLayer];
                                        }],
                                        nil];
            [self runAction:sequenceDown];
        }
        else
        {
            //       CCLOG(@"pull string");
            if ([self.objectsLayer.string numberOfRunningActions] == 0)
            {
                [self.objectsLayer toggleWindow];
                [self.objectsLayer animateString];
            }
        }
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
