//
//  FlickrSceneLayer.h
//  PaperMoon
//
//  Created by Andy Woo on 27/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCUIViewWrapper.h"


@interface FlickrSceneLayer : CCLayer <UIGestureRecognizerDelegate, UIWebViewDelegate, UIAlertViewDelegate> {

    NSMutableArray *_arrayThumbnails;
    NSMutableArray *items;
    NSMutableArray *_arrayRotations;
    NSMutableArray *_arrayRandNums;
    NSMutableArray *_arrayImages;
    NSMutableArray *_arrayNames;
    NSMutableArray *_arrayTitles;
    NSMutableArray *_arrayURLs;
    NSMutableArray *_arrayOriginalURLs;
    
    int _count;
    int randNum;
    BOOL isLoading;
    BOOL isSelected;
    BOOL isHandled;
    BOOL isSwipedDown;
    BOOL isPhotoShown;
    BOOL isWebViewShown;
    
    CCSprite *lastSelected;
    CCSprite *_btnInfo;
    CCSprite *_btnReload;
    CCSprite *_btnLink;
    CCSprite *_btnFlickr;
       CCSprite *_btnBack;
       CCSprite *_btnStop;
       CCSprite *_btnForward;
       CCSprite *_btnRefresh;
    CCSprite *_sprite;
    CCSpriteFrameCache *frameCache;

       CCMenuItemSprite *_backItem;
       CCMenuItemSprite *_forwardItem;
       CCMenuItemSprite *_stopItem;
    CCMenuItemSprite *_refreshItem;
    CCMenuItemSprite *_flickrItem;
    
    CGPoint lastPos;
 
    UIActivityIndicatorView *activityIndicatorView;
    UIProgressView *progressView;
    UIWebView *_webView;
    CCUIViewWrapper *wrapper;
    
    NSMutableString *_selectedName;
    NSMutableString *_selectedTitle;
    NSMutableString *_selectedURL;
    NSMutableString *_selectedOriginalURL;
    
}

@property (nonatomic, strong) NSArray *recent;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *arrayThumbnails;
@property (nonatomic, strong) NSMutableArray *arrayRotations;
@property (nonatomic, strong) NSMutableArray *arrayRandNums;
@property (nonatomic, strong) NSMutableArray *arrayImages;
@property (nonatomic, strong) NSMutableArray *arrayNames;
@property (nonatomic, strong) NSMutableArray *arrayTitles;
@property (nonatomic, strong) NSMutableArray *arrayURLs;
@property (nonatomic, strong) NSMutableArray *arrayOriginalURLs;

@property (nonatomic, strong) NSMutableString *selectedName;
@property (nonatomic, strong) NSMutableString *selectedTitle;
@property (nonatomic, strong) NSMutableString *selectedURL;
@property (nonatomic, strong) NSMutableString *selectedOriginalURL;

@property (nonatomic, retain) CCSprite *btnInfo;
@property (nonatomic, strong) CCSprite *btnReload;
@property (nonatomic, strong) CCSprite *btnLink;
@property (nonatomic) int count;

@property (nonatomic, strong) UIWebView *webView;

 @property (nonatomic, strong) CCSprite *btnStop;
 @property (nonatomic, strong) CCSprite *btnBack;
 @property (nonatomic, strong) CCSprite *btnForward;
 @property (nonatomic, strong) CCSprite *btnRefresh;
@property (nonatomic, strong) CCSprite *btnFlickr;
 @property (nonatomic, strong) CCMenuItemSprite *backItem;
 @property (nonatomic, strong) CCMenuItemSprite *stopItem;
 @property (nonatomic, strong) CCMenuItemSprite *forwardItem;
@property (nonatomic, strong) CCMenuItemSprite *refreshItem;
@property (nonatomic, strong) CCMenuItemSprite *flickrItem;

-(void)goBackShop;
-(void)goForwardShop;
-(void)stopLoading;
-(void)stopActivitySpinner;
-(void)refreshPage;

@end
