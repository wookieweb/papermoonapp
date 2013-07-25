//
//  ShopSceneLayer.h
//  PaperMoon
//
//  Created by Andy Woo on 24/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <UIKit/UIKit.h>
#import "CCUIViewWrapper.h"



@interface ShopSceneLayer : CCLayer <UIGestureRecognizerDelegate, UIWebViewDelegate, UIAlertViewDelegate> {
    
    BOOL isSwipedDown;
    UIActivityIndicatorView *activityIndicatorView;
    UIWebView *_webView;
    CCUIViewWrapper *wrapper;
    
}

@property (nonatomic, strong) UIWebView *webView;

-(void)goBackShop;
-(void)goForwardShop;
-(void)stopLoadingShop;
-(void)stopActivitySpinner;
-(void)refreshPage;
-(void)goToCart;
-(void)goStoreFront;
@end
