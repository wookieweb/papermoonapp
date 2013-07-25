//
//  AppDelegate.h
//  PaperMoon
//
//  Created by Andy Woo on 25/12/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "Reachability.h"


@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*__weak director_;							// weak ref
    BOOL isSwipeDown_;
    int cartItem_;
    BOOL isLoadCart_;
    BOOL internetActive_;
    BOOL hostActive_;
    Reachability *hostReachable;
    Reachability *internetReachable;
}

@property (nonatomic, strong) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (weak, readonly) CCDirectorIOS *director;
@property (nonatomic) BOOL isSwipeDown;
@property (nonatomic) BOOL isLoadCart;
@property (nonatomic) int cartItem;
@property (nonatomic) BOOL internetActive;
@property (nonatomic) BOOL hostActive;



@end
