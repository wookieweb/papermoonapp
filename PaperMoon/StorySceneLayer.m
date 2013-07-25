//
//  StorySceneLayer.m
//  PaperMoon
//
//  Created by Andy Woo on 20/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "StorySceneLayer.h"
#import "SceneManager.h"
#import "CCNode+SFGestureRecognizers.h"

@implementation StorySceneLayer


-(void) makeTransitionBack:(ccTime)dt
{
    [[SceneManager sharedSceneManager] runSceneWithID:kCreditsScene withDirection:kRight withSender:[self parent]];
}


-(void) makeTransitionForward:(ccTime)dt
{
    [[SceneManager sharedSceneManager] runSceneWithID:kScene1 withDirection:kLeft withSender:[self parent]];
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    if (location.x <= winSize.width/2)
    {
//        [self scheduleOnce:@selector(makeTransitionBack:) delay:0.2];
    }
    else
    {
 //       [self scheduleOnce:@selector(makeTransitionForward:) delay:0.2];
    }
    
}


-(id) init
{
    self = [super init];
    if (self != nil)
    {
        /*
        self.isTouchEnabled = YES;
        
        UISwipeGestureRecognizer *swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
        
        [self addGestureRecognizer:swipeGestureRecognizerRight];
        swipeGestureRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
        swipeGestureRecognizerRight.delegate = self;
        
        [self addGestureRecognizer:swipeGestureRecognizerLeft];
        swipeGestureRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        swipeGestureRecognizerLeft.delegate = self;

        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.position = ccp(0, -screenSize.height * 0.7);
 
        CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"Meet Moon Fox, a gentle seafarer\nwho floats with the moonlight." dimensions:CGSizeMake(400, 100) hAlignment:NSTextAlignmentCenter fontName:@"Helvetica" fontSize:20];
        label1.color = ccWHITE;
        label1.anchorPoint = ccp(0.5, 0.5);
        label1.position = ccp( screenSize.width/2 , screenSize.height/2 );
        
        CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Moon foxes sail in ships buoyed\nby dreams. Amid waves of whimsy,\nunder the quiet cover of nightfall, they\nare joined by others." dimensions:CGSizeZero hAlignment:NSTextAlignmentCenter fontName:@"Helvetica" fontSize:16];
        label2.color = ccWHITE;
        label2.anchorPoint = ccp(0.5, 0.5);
        label2.position = ccp (screenSize.width/2, 100);
        
        CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"The Moon Wanderers know what happens\nin the world while people are sleeping.\nand there are many stories to be told." dimensions:CGSizeZero hAlignment:NSTextAlignmentCenter fontName:@"Helvetica" fontSize:16];
        label3.color = ccWHITE;
        label3.anchorPoint = ccp(0.5, 0.5);
        label3.position = ccp (screenSize.width/2, 0);
  
        [self addChild: label1];
        [self addChild: label2];
        [self addChild: label3];
        
        CCMoveTo *move = [CCMoveTo actionWithDuration:20.0 position:ccp(0, screenSize.height /2 * 0.4)];
        [self runAction:move];
*/
        
    }
    return self;
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
    [self scheduleOnce:@selector(makeTransitionForward:) delay:0];
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    [self scheduleOnce:@selector(makeTransitionBack:) delay:0];
}




@end
