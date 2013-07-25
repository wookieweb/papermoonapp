//
//  FlickrSceneLayer.m
//  PaperMoon
//
//  Created by Andy Woo on 27/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

static const float MIN_SCALE = 0.5;
static const float MAX_SCALE = 2.0;

#import "FlickrSceneLayer.h"
#import "CCNode+SFGestureRecognizers.h"
#import "SceneManager.h"
#import "FlickrFetcher.h"
#import <dispatch/dispatch.h>
#import "AppDelegate.h"
#import "SettingLayer.h"
#import "FlickrScene.h"
#import "CCShake.h"

#define ARC4RANDOM_MAX 0xFFFFFFFF
#define ADJ_ANGLE 10.0
#define ADJ_POS 10.0

#define kWrapper 969
#define kLayerColor 979
#define kLabel 20
#define kSpriteRect 30
#define kFlickrSprite 40
#define kBlurLayer 900

@implementation FlickrSceneLayer

@synthesize recent = _recent;
@synthesize items = _items;
@synthesize arrayThumbnails = _arrayThumbnails;
@synthesize arrayRotations = _arrayRotations;
@synthesize arrayRandNums = _arrayRandNums;
@synthesize arrayImages = _arrayImages;
@synthesize arrayNames = _arrayNames;
@synthesize arrayTitles = _arrayTitles;
@synthesize arrayURLs = _arrayURLs;
@synthesize arrayOriginalURLs = _arrayOriginalURLs;
@synthesize btnReload = _btnReload;
@synthesize count = _count;
@synthesize selectedName = _selectedName;
@synthesize selectedTitle = _selectedTitle;
@synthesize selectedURL = _selectedURL;
@synthesize selectedOriginalURL = _selectedOriginalURL;
@synthesize btnInfo = _btnInfo;
@synthesize btnLink = _btnLink;
@synthesize webView = _webView;

 @synthesize btnBack = _btnBack;
 @synthesize btnStop = _btnStop;
 @synthesize btnForward = _btnForward;
 @synthesize backItem = _backItem;
 @synthesize stopItem = _stopItem;
 @synthesize forwardItem = _forwardItem;
 @synthesize refreshItem = _refreshItem;
 @synthesize btnRefresh = _btnRefresh;
@synthesize flickrItem = _flickrItem;
@synthesize btnFlickr = _btnFlickr;

-(void) makeTransitionBack:(ccTime)dt
{
    [[SceneManager sharedSceneManager] runSceneWithID:kCreditsScene withDirection:kRight withSender:[self parent]];
}


-(void) makeTransitionForward:(ccTime)dt
{
    [[SceneManager sharedSceneManager] runSceneWithID:kShopScene withDirection:kLeft withSender:[self parent]];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
        [[UIApplication sharedApplication]  openURL:[NSURL URLWithString:self.selectedURL]];
}

-(UIImage*) makeaShot
{
    [CCDirector sharedDirector].nextDeltaTimeZero = YES;
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    CCLayerColor* whitePage = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 0) width:winSize.width height:winSize.height];
    whitePage.position = ccp(winSize.width/2, winSize.height/2);
    
    CCRenderTexture* rtx = [CCRenderTexture renderTextureWithWidth:winSize.width height:winSize.height];
    [rtx begin];
    [whitePage visit];
    [[[CCDirector sharedDirector] runningScene] visit];
    
    [rtx end];
    
    return [rtx getUIImage];
}

-(void)blurBackground
{
    /*
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    UIImage *image = [self makeaShot];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *beginImage = [CIImage imageWithCGImage:image.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    
    [filter setValue:beginImage forKey: @"inputImage"];
    [filter setValue:[NSNumber numberWithFloat: 5] forKey: @"inputRadius"];
    CIImage *outputImage = [filter valueForKey: @"outputImage"];
    
    
    UIImage *newImage = [UIImage imageWithCIImage:outputImage];
    CGImageRef cgimg =
    [context createCGImage:outputImage fromRect:[outputImage extent]];
    

    
    CCLOG(@"object %@", newImage);
    CCLOG(@"reference %@", cgimg);
    _sprite = [CCSprite spriteWithCGImage:cgimg key:@"key"];
  //  [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    
   
    _sprite.position = ccp(screenSize.width/2, screenSize.height/2);
    
    [self addChild:_sprite z:89 tag:kBlurLayer];
    CGImageRelease(cgimg);
    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"key"];
*/
}

- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ((!isLoading) && (!isWebViewShown))
    {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        CCSprite *selected = [self itemForTouch:touch];
        if (selected != nil)
        {
            isHandled = YES;
            [(CCLayerColor *)[self getChildByTag:67] setOpacity:150];
            
            if ((!isSelected) && (selected != lastSelected) && (!isSwipedDown))
            {
             //   CCLOG(@"Zoom");
                
                [selected setZOrder:99];
                lastSelected = selected;
                lastPos = CGPointMake(selected.position.x, selected.position.y);
                isSelected = YES;
                CCMoveTo *move = [CCMoveTo actionWithDuration:0.25 position:ccp(screenSize.width/2, screenSize.height/2)];
                CCSequence *sequenceZoom = [CCSequence actions:
                                            [CCSpawn actions:
                                             
                                            move,
                                             [CCScaleTo actionWithDuration:0.25 scale:3.7],
                                             nil],
                                          //  [CCScaleTo actionWithDuration:0.25 scale:3.7],
                                            [CCScaleTo actionWithDuration:0.1 scale:3.5],
                //                            [CCCallBlock actionWithBlock:^{
                //    [self blurBackground];
              //  }],
                                            nil];
                [selected runAction:sequenceZoom];
                
               
                
            //    [selected addChild:_btnInfo z:100 tag:80];
            //    [_btnInfo setOpacity:0];
            //    _btnInfo.anchorPoint = ccp(1, 1);
            //    _btnInfo.scale = 0.3;

            //    _btnInfo.position = ccp(selected.contentSize.width, selected.contentSize.height);
            //    CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:0.5];
            //    [_btnInfo runAction:fadeIn];
                
                /*
                [selected addChild:_btnLink z:100 tag:70];
                _btnLink.position = CGPointMake(_btnInfo.position.x, _btnInfo.position.y - 15);
                [_btnLink setOpacity:0];
                _btnLink.anchorPoint = ccp(1,1);
                _btnLink.scale = 0.3;
                */
                
                selected.rotation = 0;

    
                NSMutableString *outputTitle = [NSMutableString stringWithString:@"Title: "];
                if (self.selectedTitle == nil)
                    [self.selectedTitle stringByAppendingString:@""];
                
                CCLabelTTF *title = [CCLabelTTF labelWithString:[outputTitle stringByAppendingString:self.selectedTitle] dimensions:CGSizeMake(selected.contentSize.width * 3.0, selected.contentSize.height * 3.0) hAlignment:kCCTextAlignmentCenter fontName:@"Helvetica" fontSize:22];
                
                outputTitle = nil;
                title.anchorPoint = ccp(0.5, 0.5);
                title.position = ccp(selected.contentSize.width/2, selected.contentSize.height/2 - 40.0);
                title.color = ccGRAY;
                title.scale = 0.25;
              //  [title setContentSize:CGSizeMake(selected.boundingBox.size.width, selected.boundingBox.size.height)];
                [title setOpacity:0];
                [selected addChild:title z:199 tag:109];
                
                /*
                NSMutableString *outputName = [NSMutableString stringWithString:@"Author: "];
                if (self.selectedName == nil)
                    [self.selectedName stringByAppendingString:@""];
                CCLabelTTF *label = [CCLabelTTF labelWithString:[outputName stringByAppendingString:self.selectedName] dimensions:CGSizeMake(selected.contentSize.width * 3.0, selected.contentSize.height * 3.0) hAlignment:kCCTextAlignmentCenter fontName:@"Helvetica" fontSize:24];
                outputName = nil;
                label.anchorPoint = ccp(0.5, 0.5);
                label.position = ccp(selected.contentSize.width/2, selected.contentSize.height/2 - 20);
                label.color = ccWHITE;
                label.scale = 0.25;
                
                [selected addChild:label z:199 tag:108];
                */
                
                
          //      CCLOG(@"label boundingbox %f %f %f %f", label.boundingBox.origin.x, label.boundingBox.origin.y, label.boundingBox.size.width, label.boundingBox.size.height);
                
          //      CCLOG(@"label contentsize %f %f %f %f", label.position.x, label.position.y, label.contentSize.width, label.contentSize.height);
                
                /*
                CCLOG(@"selected position x: %f", selected.position.x);
                CCLOG(@"selected position y: %f", selected.position.y);
                CCLOG(@"selected contentsize width: %f", selected.contentSize.width );
                CCLOG(@"selected contentsize height: %f", selected.contentSize.height );
                
                
                
                
                CCLOG(@"selected boundingbox origin x: %f", selected.boundingBox.origin.x );
                CCLOG(@"selected boundingbox origin y: %f", selected.boundingBox.origin.y );
                
                
                
                CCLOG(@"name label contentsize width: %f", label.contentSize.width );
                CCLOG(@"name label contentsize height: %f", label.contentSize.height );
                CCLOG(@"name label boundingbox width: %f", label.boundingBox.size.width );
                CCLOG(@"name label boundingbox height: %f", label.boundingBox.size.height );
                
                
                CCLOG(@"title contentsize width: %f", title.contentSize.width );
                CCLOG(@"title contentsize height: %f", title.contentSize.height );
                CCLOG(@"title boundingbox width: %f", title.boundingBox.size.width );
                CCLOG(@"title boundingbox height: %f", title.boundingBox.size.height );
                 */
                
            }
            
            else if (isSelected)
            {
                
                // Info button on top right corner
                
                float rectX = (screenSize.width/2 + selected.contentSize.width * selected.scaleX / 3 / 2);
           //     float rectY = (screenSize.height/2 + selected.contentSize.height * selected.scaleY / 2) - 50;
                float rectY = 0;
                float rectW = selected.contentSize.width * selected.scaleX / 3;
                float rectH = 80.0;
                
                /*
                float rectLowerX = (screenSize.width/2 - selected.contentSize.width * selected.scaleX / 2);
                float rectLowerY = (screenSize.height/2 - selected.contentSize.height * selected.scaleY / 2);
                float rectLowerW = selected.contentSize.width * selected.scaleX;
                float rectLowerH = selected.contentSize.height * selected.scaleY / 2;
                
                float rectUpperX = (screenSize.width/2 - selected.contentSize.width * selected.scaleX / 2);
                float rectUpperY = (screenSize.height/2);
                float rectUpperW = selected.contentSize.width * selected.scaleX;
                float rectUpperH = selected.contentSize.height * selected.scaleY / 2;
                */

                
                if (CGRectContainsPoint(CGRectMake(rectX, rectY, rectW, rectH), location))
                {
                  
                 //   isWebViewShown = YES;
                    
                    
                    UIAlertView *flickrAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Leave PaperMoon?", @"flickrAlertView")
                                                                        message:NSLocalizedString(@"You will be opening Mobile Safari for the Flickr page.  Would you like to continue?", @"flickrAlertView")
                                                                       delegate:self
                                                              cancelButtonTitle:NSLocalizedString(@"Cancel", @"flickrAlertView")
                                                              otherButtonTitles:NSLocalizedString(@"Yes", @"flickrAlertView"), nil];
                    [flickrAlertView show];
                    
                    
                 //   [self initWebView:self.selectedURL];
                    
                }

                  else
                  {
                      // Call block to check if photo is facing up or down
                      /*
                      CCCallBlock *checkIsPhotoShown = [CCCallBlock actionWithBlock:^{
                          if (!isPhotoShown)
                          {
                       //       float oldScaleX = selected.scaleX;
                              float oldScaleY = selected.scaleY;
                              // Show photo front
                              
                              CCScaleTo *scalePhotoToOneMore = [CCScaleTo actionWithDuration:0.2 scaleX:0.0 scaleY:oldScaleY * 0.9];
                              CCCallBlock *showPhoto = [CCCallBlock actionWithBlock:^{
                                  [[selected getChildByTag:88] setVisible:YES];
                                  [(CCSprite*)[selected getChildByTag:109] setOpacity:0];
                                  [(CCSprite*)[selected getChildByTag:108] setOpacity:0];
                                  [_btnInfo setDisplayFrame:
                                   [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"btn-info-hd.png"]];
                              }];
                      //        CCScaleTo *scalePhotoBackOneMore = [CCScaleTo actionWithDuration:0.2 scaleX:oldScaleX scaleY:oldScaleY];
                              CCSequence *sequencePhoto = [CCSequence actions:
                                                           
                                                           scalePhotoToOneMore,
                                                           showPhoto,
                                                  //         [CCDelayTime actionWithDuration:0.5],
                                                   //        scalePhotoBackOneMore,
                                                          
                                                           nil];
                              
                              [selected runAction:sequencePhoto];
                              isPhotoShown = YES;
                          }
                      }];
                      */
                      
                    //  CCLOG(@"Shrink");
                      [(CCLayerColor *)[self getChildByTag:67] setOpacity:0];
                    //  [_sprite setVisible:NO];
                    
                   //   [self removeChild:_sprite cleanup:YES];
                   //   CCLOG(@"object %@", [self getChildByTag:kBlurLayer]);
                      
                      //   CCLOG(@"LastPos x y %f %f", lastPos.x, lastPos.y);
                      //   CCLOG(@"Selected %@", selected);
                      CCMoveTo *moveBack = [CCMoveTo actionWithDuration:0.25 position:lastPos];
                      CCSequence *sequenceBack = [CCSequence actions:
                                                //  checkIsPhotoShown,
                                                   
                                                  [CCSpawn actions:
                                                   moveBack,
                                                   [CCScaleTo actionWithDuration:0.25 scale:1.0],
                                                   [CCCallBlock actionWithBlock:^{
                                                      selected.rotation = [[self.arrayRotations objectAtIndex:selected.tag] floatValue];
                                                  }],
                                                   nil],
                                                  [CCScaleBy actionWithDuration:0.1 scale:0.9],
                                                  [CCScaleTo actionWithDuration:0.2 scale:1.0],
                                                  [CCCallBlock actionWithBlock:^{
                
                          [selected setZOrder:5];
                        //  selected.rotation = [[self.arrayRotations objectAtIndex:selected.tag] floatValue];
                          
                      }],
                                                  nil];
                      [selected runAction:sequenceBack];
                      
                      /*
                      [selected setScale:1.0];
                      [selected setZOrder:5];
                      selected.rotation = [[self.arrayRotations objectAtIndex:selected.tag] floatValue];
                      */
                      
                      lastSelected = nil;
                      isSelected = NO;
                      [[self getChildByTag:108] removeFromParentAndCleanup:YES];
                      [[self getChildByTag:109] removeFromParentAndCleanup:YES];
                      [_btnInfo removeFromParentAndCleanup:YES];
                   //   [_btnLink removeFromParentAndCleanup:YES];
                  }
                
            }
        }
        
        else if ((!isWebViewShown) && (!isSwipedDown) && (!isLoading) && (!isSelected) && (CGRectContainsPoint(CGRectMake(screenSize.width -100, 0, 100, 100), location)))
        {
                  CCLOG(@"Reloading");
            isLoading = YES;
            for (id obj in self.arrayThumbnails)
            {
                [obj removeFromParentAndCleanup:YES];
            }
            
            [self.arrayThumbnails removeAllObjects];
            [self.items removeAllObjects];
            [self.arrayRotations removeAllObjects];
            [self.arrayImages removeAllObjects];
            [self.arrayNames removeAllObjects];
            [self.arrayTitles removeAllObjects];
            [self.arrayURLs removeAllObjects];
            [self.arrayOriginalURLs removeAllObjects];
           
            isSelected = NO;
            self.count=0;
            [_btnReload setOpacity:50];
            
            [activityIndicatorView startAnimating];

            [self reLoadThumbnails];
            
        }
    }
    else
        CCLOG(@"Loading, please waiting!");

}


-(void)showProgressBar
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    int lengthOfBar = 160;
    progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.progress = 0.0f;
    [[UIProgressView appearance] setProgressTintColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [[UIProgressView appearance] setTrackTintColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:0.5]];
    [progressView setFrame:CGRectMake(screenSize.width/2 - lengthOfBar/2, screenSize.height/2 + 50, lengthOfBar, 10)];
    [[CCDirector sharedDirector].view addSubview: progressView];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}



-(CCSprite*) createSpriteRectangleWithSize:(CGSize)size
{
    CCSprite *sprite = [CCSprite node];
    GLubyte *buffer = malloc(sizeof(GLubyte)*4);
    for (int i=0;i<4;i++) {buffer[i]=255;}
    CCTexture2D *tex = [[CCTexture2D alloc] initWithData:buffer pixelFormat:kCCTexture2DPixelFormat_RGB5A1 pixelsWide:1 pixelsHigh:1 contentSize:size];
    [sprite setTexture:tex];
    [sprite setTextureRect:CGRectMake(0, 0, size.width, size.height)];
    free(buffer);
    return sprite;
}


-(void)addWhiteFrameWithSize:(CGSize)size
{
    /*
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    self.spriteRectangle = [self createSpriteRectangleWithSize:size];
    _spriteRectangle.color = ccc3(255,255,255);
    _spriteRectangle.anchorPoint = ccp(0.5, 0.5);
    _spriteRectangle.position = ccp(50 + count * 50,screenSize.height/2);
    [self.arrayThumbnails addObject:_spriteRectangle];
 //   [self addChild:_spriteRectangle];
     */
}

-(void)updateProgressView:(float)progress
{
        progressView.progress = progress;
         CCLOG(@"Progress %f", progress);
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}

-(void)downloadThumbnails
{

   // CCLOG(@"self.recent count %d", [self.recent count]);
    [self showProgressBar];


        
        if (([self.recent count] <= 9) && ([self.recent count] > 0))
        {
     //       CCLOG(@"Downloading < 9");
            dispatch_queue_t backgroundQueue = dispatch_queue_create("com.wookieweb.com.papermoonapp", NULL);
            dispatch_async(backgroundQueue, ^(void) {
            self.arrayRandNums = [NSMutableArray arrayWithArray:[self getRandomInts:[self.recent count] from:0 to:([self.recent count])]];
       //         CCLOG(@"arrayRandoms %@", self.arrayRandNums);
                for (int i=0; i<=[self.recent count]-1; i++)
                {
                    NSString *nameString = [[self.recent objectAtIndex:[[self.arrayRandNums objectAtIndex:i] integerValue]] objectForKey:@"ownername"];
                    if (nameString == nil)
                        nameString= @"";
                //    CCLOG(@"nameString %@", nameString);
                    [self.arrayNames addObject:nameString];
                //    CCLOG(@"arrayNames object %@", self.arrayNames);
                    
                    NSString *titleString = [[self.recent objectAtIndex:[[self.arrayRandNums objectAtIndex:i] integerValue]] objectForKey:@"description"];
                    if (titleString == nil)
                        titleString = @"";
                    CCLOG(@"title %@", titleString);
                    [self.arrayTitles addObject:titleString];
                    
                    NSURL *url = [FlickrFetcher urlForPhoto:[self.recent objectAtIndex:[[self.arrayRandNums objectAtIndex:i] integerValue]] format:FlickrPhotoFormatMedium640];
                    
                    if (url)
                    {
             //           CCLOG(@"i %d", [[self.arrayRandNums objectAtIndex:i] integerValue]);
                        
                        [self.arrayOriginalURLs addObject:[url absoluteString]];
                        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                        NSData *imageData = UIImagePNGRepresentation(image);
                        
                        [self.arrayImages addObject:imageData];
                        
                        NSString *urlString = @"http://flickr.com/photo.gne?id=";
                        urlString = [urlString stringByAppendingString:[NSString stringWithString:[[self.recent objectAtIndex:[[self.arrayRandNums objectAtIndex:i] integerValue]] objectForKey:@"id"]]];
                        CCLOG(@"url %@", urlString);
                        [self.arrayURLs addObject:urlString];
                    }
                    else
                    {
                        CCLOG(@"url not available");
                        [self.arrayURLs addObject:@""];
                        [self.arrayOriginalURLs addObject:@""];
                       
                    }
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        if ([[CCDirector sharedDirector] runningScene] == ([FlickrScene scene]))
                        {
                            [self updateProgressView: (float)(i / ([self.recent count]-1))];
                        }
                        else
                                   {
                                       [progressView setHidden:YES];
                                   }
                    });
                }
                
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    NSUserDefaults *defaultImages = [NSUserDefaults standardUserDefaults];
                    [defaultImages setObject:self.arrayImages forKey:@"image"];
                    [defaultImages setObject:self.arrayNames forKey:@"names"];
                    [defaultImages setObject:self.arrayTitles forKey:@"titles"];
                    [defaultImages setObject:self.arrayURLs forKey:@"urls"];
                    [defaultImages setObject:self.arrayOriginalURLs forKey:@"originalurls"];
                    [defaultImages synchronize];
                    CCLOG(@"Images, names, titles and urls saved");
                    [self loadTextureToThumbnails];
                    [self layoutThumbnails];
                });
            });
      //      dispatch_release(backgroundQueue);
        }
        else
        {
          //  CCLOG(@"Downloading > 9");
            dispatch_queue_t backgroundQueue = dispatch_queue_create("com.wookieweb.com.papermoonapp", NULL);
            dispatch_async(backgroundQueue, ^(void) {
            self.arrayRandNums = [NSMutableArray arrayWithArray:[self getRandomInts:9 from:0 to:([self.recent count])]];
            //    CCLOG(@"arrayRandoms %@", self.arrayRandNums);
                for (int i=0; i<=8; i++)
                {
                    NSString *nameString = [[self.recent objectAtIndex:[[self.arrayRandNums objectAtIndex:i] integerValue]] objectForKey:@"ownername"];
                    if (nameString == nil)
                        nameString= @"";
                    CCLOG(@"Owner %@", nameString);
                    CCLOG(@"Flickr ID %@", [[self.recent objectAtIndex:[[self.arrayRandNums objectAtIndex:i] integerValue]] objectForKey:@"owner"]);
                    [self.arrayNames addObject:nameString];
                 //   CCLOG(@"arrayNames object %@", self.arrayNames);
                    
                    NSString *titleString = [[self.recent objectAtIndex:[[self.arrayRandNums objectAtIndex:i] integerValue]] objectForKey:@"title"];
                    if (titleString == nil)
                        titleString = @"";
                    CCLOG(@"title %@", titleString);
                    [self.arrayTitles addObject:titleString];
                    
                    NSURL *url = [FlickrFetcher urlForPhoto:[self.recent objectAtIndex:[[self.arrayRandNums objectAtIndex:i] integerValue]] format:FlickrPhotoFormatMedium640];
                    if (url)
                    {
                 //       CCLOG(@"i %d", [[self.arrayRandNums objectAtIndex:i] integerValue]);
                        [self.arrayOriginalURLs addObject:[url absoluteString]];
                        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                        NSData *imageData = UIImagePNGRepresentation(image);
                        
                        [self.arrayImages addObject:imageData];
                        
                        NSString *urlString = @"http://flickr.com/photo.gne?id=";
                        urlString = [urlString stringByAppendingString:[NSString stringWithString:[[self.recent objectAtIndex:[[self.arrayRandNums objectAtIndex:i] integerValue]] objectForKey:@"id"]]];
                        CCLOG(@"url %@", urlString);
                        [self.arrayURLs addObject:urlString];
                    }
                    else
                    {
                        CCLOG(@"url not available");
                        [self.arrayURLs addObject:@""];
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                  //      CCLOG(@"Parent  %@", [self parent]);
                  //      CCLOG(@"running scene %@", [[CCDirector sharedDirector] runningScene]);
                        if ([[CCDirector sharedDirector] runningScene] == [self parent])
                        {
                            [self updateProgressView: (i / 8.0)];
                        }
                        else
                        {
                            [progressView setHidden:YES];
                            
                        }
                    });
                }
                
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    NSUserDefaults *defaultImages = [NSUserDefaults standardUserDefaults];
                    [defaultImages setObject:self.arrayImages forKey:@"image"];
                    [defaultImages setObject:self.arrayNames forKey:@"names"];
                    [defaultImages setObject:self.arrayTitles forKey:@"titles"];
                    [defaultImages setObject:self.arrayURLs forKey:@"urls"];
                    [defaultImages setObject:self.arrayOriginalURLs forKey:@"originalurls"];
                    [defaultImages synchronize];
                    
                    CCLOG(@"Images, names, titles and urls saved");
                    [self loadTextureToThumbnails];
                    [self layoutThumbnails];
                });
            });
        }
}

-(void)loadTextureToThumbnails
{
   // CCLOG(@"self.arrayImages count %d", [self.arrayImages count]);
    for (int i=0; i<=[self.arrayImages count]-1; i++)
    {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        UIImage *image = [UIImage imageWithData:[self.arrayImages objectAtIndex:i]];
        
        CCTexture2D* tex = [[CCTexture2D alloc] initWithCGImage:image.CGImage resolutionType:kCCResolutioniPhoneRetinaDisplay];
        CCSprite *flickrSprite = [CCSprite node];
        [flickrSprite setTexture: tex];
        CGSize texSize = [tex contentSize];
        [flickrSprite setTextureRect:CGRectMake(0, 0, texSize.width, texSize.height)];
        
        NSMutableString *outputName = [NSMutableString stringWithString:@""];
        if (self.selectedName == nil)
            [self.selectedName stringByAppendingString:@""];
        
     //   CCLabelTTF *label = [CCLabelTTF labelWithString:[outputName stringByAppendingString:[self.arrayNames objectAtIndex:i]] fontName:@"Helvetica" fontSize:8];
        
   //     float adjScale = flickrSprite.contentSize.height / screenSize.height;
        float aspectRatio = flickrSprite.contentSize.width / flickrSprite.contentSize.height;
        CCLOG(@"sprite width %f", flickrSprite.contentSize.width);
        CCLOG(@"sprite height %f", flickrSprite.contentSize.height);
        CCLOG(@"aspect ratio %f", aspectRatio);
        
        NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_ "];
        s = [s invertedSet];
        NSRange r = [[outputName stringByAppendingString:[self.arrayNames objectAtIndex:i]] rangeOfCharacterFromSet:s];
        if (r.location != NSNotFound) {
            NSLog(@"the string contains illegal characters");
            
            CCLabelTTF *label = [CCLabelTTF labelWithString:[outputName stringByAppendingString:[self.arrayNames objectAtIndex:i]] fontName:@"Helvetica" fontSize:8];
            
            outputName = nil;
            label.anchorPoint = ccp(1, 0.5);
            label.position = ccp(flickrSprite.contentSize.width - 10, 10);
            label.tag = kLabel;
            [flickrSprite addChild:label];
            
            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
            CCSprite *btnFlickrIcon = [CCSprite spriteWithSpriteFrameName:@"btn-flickricon-hd.png"];
            btnFlickrIcon.anchorPoint = ccp(0.5, 0.5);
            CGPoint tempPos = label.position;
            btnFlickrIcon.position = CGPointMake(tempPos.x - label.contentSize.width - 10, tempPos.y - 1);
            [flickrSprite addChild:btnFlickrIcon];
    
        }
        else
        {
            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
            if (((flickrSprite.contentSize.width >= 320) && (aspectRatio < 1.40) && (aspectRatio !=1.0)) || (aspectRatio < 1.0))
            {
                CCLOG(@"111111111111");
                CCLabelBMFont *label = [CCLabelBMFont labelWithString:[outputName stringByAppendingString:[self.arrayNames objectAtIndex:i]] fntFile:@"font24.fnt"];
                outputName = nil;
                label.anchorPoint = ccp(1, 0.5);
                label.position = ccp(flickrSprite.contentSize.width - 10, 10);
                label.tag = kLabel;
                [flickrSprite addChild:label];
                
                CCSprite *btnFlickrIcon = [CCSprite spriteWithSpriteFrameName:@"btn-flickricon-hd.png"];
                btnFlickrIcon.anchorPoint = ccp(0.5, 0.5);
                CGPoint tempPos = label.position;
                btnFlickrIcon.position = CGPointMake(tempPos.x - label.contentSize.width - 10, tempPos.y - 1);
                [flickrSprite addChild:btnFlickrIcon];
            }
            else if (aspectRatio == 1.0)
            {
                CCLOG(@"2222222222222");
                CCLabelBMFont *label = [CCLabelBMFont labelWithString:[outputName stringByAppendingString:[self.arrayNames objectAtIndex:i]] fntFile:@"font20.fnt"];
                outputName = nil;
                label.anchorPoint = ccp(1, 0.5);
                label.position = ccp(flickrSprite.contentSize.width - 10, 10);
                label.tag = kLabel;
                [flickrSprite addChild:label];
                
                CCSprite *btnFlickrIcon = [CCSprite spriteWithSpriteFrameName:@"btn-flickricon-hd.png"];
                btnFlickrIcon.anchorPoint = ccp(0.5, 0.5);
                CGPoint tempPos = label.position;
                btnFlickrIcon.position = CGPointMake(tempPos.x - label.contentSize.width - 10, tempPos.y - 1);
                [flickrSprite addChild:btnFlickrIcon];
                
            }
                else
                
            {
                CCLOG(@"33333333333");
                CCLabelBMFont *label = [CCLabelBMFont labelWithString:[outputName stringByAppendingString:[self.arrayNames objectAtIndex:i]] fntFile:@"font14.fnt"];
                outputName = nil;
                label.anchorPoint = ccp(1, 0.5);
                label.position = ccp(flickrSprite.contentSize.width - 10, 10);
                label.tag = kLabel;
                [flickrSprite addChild:label];
                
                CCSprite *btnFlickrIcon = [CCSprite spriteWithSpriteFrameName:@"btn-flickricon-hd.png"];
                btnFlickrIcon.anchorPoint = ccp(0.5, 0.5);
                CGPoint tempPos = label.position;
                btnFlickrIcon.position = CGPointMake(tempPos.x - label.contentSize.width - 10, tempPos.y - 1);
                [flickrSprite addChild:btnFlickrIcon];
                
            }
            
        }
        
        float sAspectRatio = screenSize.width/screenSize.height;
        CGSize imageSize = [flickrSprite contentSize];
        float imageAspectRatio = imageSize.width/imageSize.height;
        float xScale =1;
        float yScale = 1;
        if (sAspectRatio > imageAspectRatio)
        {
            xScale = yScale = screenSize.height/imageSize.height;

        }
        else
        {
            yScale = xScale = screenSize.width / imageSize.width;

        }
        [flickrSprite setScaleX:xScale * 0.24];
        [flickrSprite setScaleY:yScale * 0.24];
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        flickrSprite.anchorPoint = ccp(0.5,0.5);
        CCSprite *spriteRectangle = [self createSpriteRectangleWithSize:CGSizeMake([flickrSprite boundingBox].size.width + 5.0, [flickrSprite boundingBox].size.height + 5.0)];
        spriteRectangle.color = ccc3(255,255,255);
        spriteRectangle.anchorPoint = ccp(0.5, 0.5);
        float randPositionAdjustment = ((double)arc4random() / ARC4RANDOM_MAX) * (ADJ_POS - (-ADJ_POS)) + (-ADJ_POS);
        spriteRectangle.position = ccp(screenSize.width/2 + randPositionAdjustment, screenSize.height/2 + randPositionAdjustment);
        flickrSprite.position = ccp(spriteRectangle.contentSize.width/2, spriteRectangle.contentSize.height/2);
        [spriteRectangle addChild:flickrSprite z:0 tag:kFlickrSprite];
        float oldRotation = ((double)arc4random() / ARC4RANDOM_MAX) * (ADJ_ANGLE - (-ADJ_ANGLE)) + (-ADJ_ANGLE);
        spriteRectangle.rotation = oldRotation;
        [self.arrayRotations addObject:[NSNumber numberWithFloat:oldRotation]];
        [self.arrayThumbnails addObject:spriteRectangle];
        
    //    CCLOG(@"self.arrayThumnails %d", [self.arrayThumbnails count]);
        
        [self addChild:spriteRectangle z:5];
        spriteRectangle.tag = i;
    }
    [self.arrayImages removeAllObjects];
    
}

-(void)layoutThumbnails
{
  // CCLOG(@"self.arrayThumnails %@", self.arrayThumbnails);
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    for (int j=0; j<=2; j++)
    {
        for (int i=0; i<=2; i++)
        {
            if (self.count < [self.arrayThumbnails count])
            {
                CCSprite *thumbnail = [self.arrayThumbnails objectAtIndex:self.count];
                float randPositionAdjustmentX = ((double)arc4random() / ARC4RANDOM_MAX) * (ADJ_POS - (-ADJ_POS)) + (-ADJ_POS);
                float randPositionAdjustmentY = ((double)arc4random() / ARC4RANDOM_MAX) * (ADJ_POS - (-ADJ_POS)) + (-ADJ_POS);
                CCMoveTo *moveTo = [CCMoveTo actionWithDuration:0.5 position:ccp(screenSize.width/3.5 + i * screenSize.width/4.7 + randPositionAdjustmentX, screenSize.height/7.9 + j * 90 + randPositionAdjustmentY)];
                
                CCSequence *sequenceTo = [CCSequence actions:
                                          moveTo,
                                          [CCCallBlock actionWithBlock:^{
                    isLoading = NO;
                }],
                                          [CCScaleBy actionWithDuration:0.1 scale:1.1],
                                          [CCScaleTo actionWithDuration:0.1 scale:1.0],
                                          nil];
                [thumbnail runAction:sequenceTo];
            }
            self.count++;

        }
    }
    [activityIndicatorView stopAnimating];
    [progressView removeFromSuperview];
    [_btnReload setOpacity:255];
   // [self.arrayThumbnails removeAllObjects];
    CCLOG(@"Finished processing");
}

-(void)initThumbnails
{
    CCLOG(@"Initializing");
    isLoading = YES;
    [_btnReload setOpacity:50];
 //   CCLOG(@"isLoading = %d", isLoading);
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(backgroundQueue, ^(void) {
        
        self.recent = [FlickrFetcher paperMoonPhotos];
     //   CCLOG(@"self.recent object %@", self.recent);
        
        if ([self.recent count] != 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self downloadThumbnails];
                CCLOG(@"Finished initializing, recent count %d", [self.recent count]);
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
            CCLOG(@"Download failure :-(");
            [activityIndicatorView stopAnimating];
            isLoading = NO;
            [_btnReload setOpacity:255];
                CGSize screenSize = [[CCDirector sharedDirector] winSize];
                CCLabelTTF *label = [CCLabelTTF labelWithString:@":-(" fontName:@"Helvetica" fontSize:96];
                label.position = ccp(screenSize.width/2, screenSize.height/2);
                label.color = ccWHITE;
                [self addChild:label];
                
                CCFadeOut *fadeOutFace = [CCFadeOut actionWithDuration:20.0];
                [label runAction:fadeOutFace];
                
            });
        }
    });
    // dispatch_release(backgroundQueue);
}
    
-(void)reLoadThumbnails
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    if (!app.internetActive)
    {
        CCLOG(@"Notification Says Unreachable");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"You are not connected to the Internet!", @"AlertView")
                                                            message:NSLocalizedString(@"Please check your connection and try again...", @"AlertView")
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Cancel", @"AlertView")
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }
    [self initThumbnails];
}

-(void)loadThumbnails
{
    NSUserDefaults *defaultImages = [NSUserDefaults standardUserDefaults];
    if(([defaultImages objectForKey:@"image"] == nil) || ([defaultImages objectForKey:@"names"] == nil))
    {
        CCLOG(@"Don't have default image or name yet!");
        [self initThumbnails];
    }
    else
    {
        self.arrayImages = [NSMutableArray arrayWithArray:[defaultImages objectForKey:@"image"]];
        self.arrayNames = [NSMutableArray arrayWithArray:[defaultImages objectForKey:@"names"]];
        self.arrayTitles = [NSMutableArray arrayWithArray:[defaultImages objectForKey:@"titles"]];
        self.arrayURLs = [NSMutableArray arrayWithArray:[defaultImages objectForKey:@"urls"]];
        self.arrayOriginalURLs = [NSMutableArray arrayWithArray:[defaultImages objectForKey:@"originalurls"]];
     //   CCLOG(@"Load texture to thumbnails");
        [self loadTextureToThumbnails];
        [self layoutThumbnails];
    }

   
}

-(NSMutableArray *)getRandomInts:(int)amount from:(int)fromInt to:(int)toInt {
    
    if ((toInt - fromInt) +1 < amount) {
        return nil;
    }
    
    NSMutableArray *uniqueNumbers = [[NSMutableArray alloc] init];
    int r;
    while ([uniqueNumbers count] < amount) {
        
        r = (arc4random() % toInt) + fromInt;
        if (![uniqueNumbers containsObject:[NSNumber numberWithInt:r]]) {
            [uniqueNumbers addObject:[NSNumber numberWithInt:r]];
        }
    }
    return uniqueNumbers;
}

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        /*
        activityIndicatorView = [[UIActivityIndicatorView alloc]
                                                           initWithActivityIndicatorStyle:
                                                           UIActivityIndicatorViewStyleWhiteLarge];
        
        activityIndicatorView.center = ccp(screenSize.width/2, screenSize.height/2);
        [[[CCDirector sharedDirector] view] addSubview: activityIndicatorView];
         [activityIndicatorView startAnimating];
        */
        
        CCLayerColor *colorLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 0)];
        [colorLayer setZOrder:98];
        [self addChild:colorLayer];
        colorLayer.tag = 67;
        
        frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        [frameCache addSpriteFramesWithFile:@"setting-btn.plist"];
        self.btnInfo = [CCSprite spriteWithSpriteFrameName:@"btn-info-hd.png"];
        _btnInfo.anchorPoint = ccp(0.5, 0.5);
        [_btnInfo setColor:ccBLACK];
        
        /*
        self.btnLink = [CCSprite spriteWithSpriteFrameName:@"btn-forward-hd.png"];
        _btnLink.anchorPoint = ccp(0.5, 0.5);
        [_btnLink setColor:ccBLACK];
        */
        
        CCSprite *logoFlickr = [CCSprite spriteWithSpriteFrameName:@"logo-flickr-hd.png"];
        logoFlickr.anchorPoint = ccp(0, 1);
        logoFlickr.position = ccp(20, screenSize.height - 20);
      //  [logoFlickr setOpacity:0.8];
        [self addChild:logoFlickr z:1];
        
        self.btnReload = [CCSprite spriteWithSpriteFrameName:@"btn-reload-hd.png"];
        _btnReload.anchorPoint = ccp(1.0, 0.5);
        _btnReload.position = ccp(screenSize.width - 20, 30);
        [_btnReload setOpacity:50];
        
        [self addChild:_btnReload z:1];
        
        self.isTouchEnabled = YES;
        self.count = 0;
        isLoading = NO;
        isSelected = NO;
        isSwipedDown = NO;
        isPhotoShown = YES;
        isWebViewShown = NO;
        
        self.arrayThumbnails = [[NSMutableArray alloc] init];
        self.arrayRotations = [[NSMutableArray alloc] init];
        self.arrayRandNums = [[NSMutableArray alloc] init];
        self.arrayImages = [[NSMutableArray alloc] init];
        self.arrayNames = [[NSMutableArray alloc] init];
        self.arrayTitles = [[NSMutableArray alloc] init];
        self.arrayURLs = [[NSMutableArray alloc] init];
        self.arrayOriginalURLs = [[NSMutableArray alloc] init];

        self.items = [[NSMutableArray alloc] init];
        self.selectedName = [[NSMutableString alloc] initWithString:@""];
        self.selectedTitle = [[NSMutableString alloc] initWithString:@""];
        self.selectedURL = [[NSMutableString alloc] initWithString:@""];
        self.selectedOriginalURL = [[NSMutableString alloc] initWithString:@""];
        
        
        UISwipeGestureRecognizer *swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
        UISwipeGestureRecognizer *swipeGestureRecognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
        
        
   //     UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        
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
        
        /*
        [self addGestureRecognizer:tapGestureRecognizer];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        tapGestureRecognizer.numberOfTouchesRequired = 1;
        [tapGestureRecognizer release];
        */
        
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGSize screenSize = [[CCDirector sharedDirector] winSize];
            if(result.height == 480)
            {
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
                CCSprite * background = [CCSprite spriteWithFile:@"flickr-background-568h.pvr.ccz"];
                background.anchorPoint = ccp(0.5,0.5);
                background.position = ccp(screenSize.width/2,screenSize.height/2);
                [self addChild:background z:0];
                
                /*
                CCSprite *logoFlickr = [CCSprite spriteWithFile:@"logo-flickr-568h.pvr.ccz"];
                logoFlickr.anchorPoint = ccp(0.5, 0.5);
                logoFlickr.position = ccp(screenSize.width/2, screenSize.height/2);
                [self addChild:logoFlickr z:1];
                 */
            }
            if(result.height == 568)
            {
                [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
                CCSprite * background = [CCSprite spriteWithFile:@"flickr-background-568h.pvr.ccz"];
                background.anchorPoint = ccp(0.5,0.5);
                background.position = ccp(screenSize.width/2,screenSize.height/2);
                [self addChild:background z:0];
                
                /*
                CCSprite *logoFlickr = [CCSprite spriteWithFile:@"logo-flickr-568h.pvr.ccz"];
                logoFlickr.anchorPoint = ccp(0.5, 0.5);
                logoFlickr.position = ccp(screenSize.width/2, screenSize.height/2);
               
                [self addChild:logoFlickr z:1];
                 */
            }
            
        }
        
      //  CCLOG(@"Random Ints %@",[self getRandomInts:9 from:0 to:25]);
    }
   
    return self;
}

-(void) onEnterTransitionDidFinish
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super onEnterTransitionDidFinish];
    
     SettingLayer *aSettingLayer = (SettingLayer*)[[self parent] getChildByTag:2];
     [aSettingLayer.btnFlickr setOpacity:100];
     [aSettingLayer.flickrItem setIsEnabled:NO];
    
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
    
  //   CCLOG(@"Scene %@", [[self parent] getChildByTag:2]);
     
    
    //   CCLOG(@"scene %@", [[CCDirector sharedDirector] runningScene]);
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithActivityIndicatorStyle:
                             UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicatorView.center = ccp(screenSize.width/2, screenSize.height/2);
    [[[CCDirector sharedDirector] view] addSubview: activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    [self loadThumbnails];
    
}

- (void)onEnter
{
	[super onEnter];
}

- (void)onExit
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	[super onExit];
    
    [activityIndicatorView removeFromSuperview];
    [progressView setHidden:YES];
    [progressView removeFromSuperview];
 
}

-(void)dealloc
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
//    [activityIndicatorView removeFromSuperview];
//    [progressView removeFromSuperview];
    [self.items removeAllObjects];
    [self.arrayThumbnails removeAllObjects];
    [self.arrayImages removeAllObjects];
    [self.arrayRandNums removeAllObjects];
    [self.arrayRotations removeAllObjects];
    [self.arrayNames removeAllObjects];
    [self.arrayTitles removeAllObjects];
    [self.arrayURLs removeAllObjects];
    [self.arrayOriginalURLs removeAllObjects];
    self.selectedName = nil;
    self.selectedTitle = nil;
    self.selectedOriginalURL = nil;
    self.selectedURL = nil;
    //   [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
}


#pragma mark - UIWebView delegate

-(void)initWebView:(NSString*)urlString
{
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [frameCache addSpriteFramesWithFile:@"setting-btn.plist"];
    
        self.btnStop = [CCSprite spriteWithSpriteFrameName:@"btn-stop-hd.png"];
        self.btnBack = [CCSprite spriteWithSpriteFrameName:@"btn-back-hd.png"];
        self.btnForward = [CCSprite spriteWithSpriteFrameName:@"btn-forward-hd.png"];
        self.btnRefresh = [CCSprite spriteWithSpriteFrameName:@"btn-refresh-hd.png"];
    self.btnFlickr = [CCSprite spriteWithSpriteFrameName:@"btn-flickr-hd.png"];
    
       self.backItem = [CCMenuItemSprite itemWithNormalSprite:self.btnBack selectedSprite:nil target:self selector:@selector(backButtonTapped:)];
       self.stopItem = [CCMenuItemSprite itemWithNormalSprite:self.btnStop selectedSprite:nil target:self selector:@selector(stopButtonTapped:)];
       self.forwardItem = [CCMenuItemSprite itemWithNormalSprite:self.btnForward selectedSprite:nil target:self selector:@selector(forwardButtonTapped:)];
       self.refreshItem = [CCMenuItemSprite itemWithNormalSprite:self.btnRefresh selectedSprite:nil target:self selector:@selector(refreshButtonTapped:)];
      self.flickrItem = [CCMenuItemSprite itemWithNormalSprite:self.btnFlickr selectedSprite:nil target:self selector:@selector(flickrButtonTapped:)];
    
     self.stopItem.anchorPoint = ccp(1, 0.5);
     [self.stopItem setContentSize:CGSizeMake(50.0, 50.0)];
    
     self.backItem.anchorPoint = ccp(1, 0.5);
     [self.backItem setContentSize:CGSizeMake(50.0, 50.0)];
     
     self.forwardItem.anchorPoint = ccp(1, 0.5);
     [self.forwardItem setContentSize:CGSizeMake(50.0, 50.0)];
     
     self.refreshItem.anchorPoint = ccp(1, 0.5);
     [self.refreshItem setContentSize:CGSizeMake(50.0, 50.0)];
    
    self.flickrItem.anchorPoint= ccp(1,0.5);
    [self.flickrItem setContentSize:CGSizeMake(50.0, 50.0)];
    
    float startPos = 50;
    self.flickrItem.position = ccp(10, -130);
         self.backItem.position = ccp(startPos + 140, -130);
         self.forwardItem.position = ccp(startPos + 190, -130);
         self.stopItem.position = ccp(startPos + 90, -130);
         self.refreshItem.position = ccp(startPos + 90, -130);
    
    
    CCMenu *menu = [CCMenu menuWithItems: self.flickrItem, self.stopItem, self.backItem, self.forwardItem,self.refreshItem, nil];
    
    self.webView = [[UIWebView alloc] init];
    self.webView.scalesPageToFit = YES;
    self.webView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:55.0/255.0 blue:85.0/255.0 alpha:1.0];
 // self.webView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    [self.webView setOpaque:YES];
    self.webView.delegate = self;
    
   // AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30]];
    wrapper = [CCUIViewWrapper wrapperForUIView:self.webView];
    [wrapper setOpacity:0];
    wrapper.contentSize = CGSizeMake(screenSize.width, screenSize.height-44);
    
    
    CCLayerColor *layerColor = [CCLayerColor layerWithColor:ccc4(45.0, 55.0, 85.0, 255.0)];
    layerColor.anchorPoint = ccp(0.5, 0.5);
     layerColor.position = ccp(0 , - screenSize.height);
    [layerColor addChild:menu];
    [layerColor addChild:wrapper z:999 tag:kWrapper];
    [self addChild:layerColor z:998 tag:kLayerColor];

    
    CCSequence *sequenceWebView = [CCSequence actions:
                                   [CCMoveTo actionWithDuration:0.2 position:ccp(0 , 0)],
                                   [CCCallBlock actionWithBlock:^{
          [wrapper runAction:[CCFadeIn actionWithDuration:0.5]];
    }],
                                   nil];
    [layerColor runAction:sequenceWebView];
    
    
    

    
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithActivityIndicatorStyle:
                             UIActivityIndicatorViewStyleGray];
    
    activityIndicatorView.center = ccp(screenSize.width/2, screenSize.height/2);
    [[[CCDirector sharedDirector] view] addSubview: activityIndicatorView];
    [self disableBackButton];
    [self disableForwardButton];
  //  [activityIndicatorView startAnimating];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CCLOG(@"webView did finished loading");

    [activityIndicatorView stopAnimating];
    
    
     [self disableStopButton];
     
     if (!self.webView.canGoBack)
     [self disableBackButton];
     else
     [self enableBackButton];
     
     if (!self.webView.canGoForward)
     [self disableForwardButton];
     else
     [self enableForwardButton];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
       CCLOG(@"webView did start loading");
       [self enableStopButton];
    [activityIndicatorView startAnimating];
}

-(void)cartHaveNoItem
{
    /*
    SettingLayer *aSettingLayer = (SettingLayer*)[[self parent] getChildByTag:2];
    [aSettingLayer removeCartItem];
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    app.cartItem = 0;
    aSettingLayer = nil;
     */
}

-(void)cartHaveItem:(NSString*)item
{
    /*
    SettingLayer *aSettingLayer = (SettingLayer*)[[self parent] getChildByTag:2];
    //  [aSettingLayer.btnShop setColor:ccRED];
    aSettingLayer.cartItem.isEnabled = YES;
    [aSettingLayer.btnCart setOpacity:255];
    [aSettingLayer addCartItem:item];
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    app.cartItem = [item intValue];
    aSettingLayer = nil;
     */
}

-(void)removeLayerFunc
{
    CCSequence *sequenceRemoveLayer = [CCSequence actions:
                                       [CCCallBlock actionWithBlock:^{
        self.webView = nil;
        [activityIndicatorView stopAnimating];
        [[self getChildByTag:kLayerColor] removeFromParentAndCleanup:YES];
        isWebViewShown = NO;
    }],

                                       nil];
    [self runAction:sequenceRemoveLayer];
}

-(void)flickrButtonTapped:(id)sender
{
    
CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSequence *removeLayer = [CCSequence actions:
                               [CCCallBlock actionWithBlock:^{
        [[[self getChildByTag:kLayerColor] getChildByTag:kWrapper] setVisible:NO];
        //       CCLOG(@"object %@", [[self getChildByTag:kLayerColor] getChildByTag:kWrapper] );
    }],
                               [CCMoveBy actionWithDuration:0.2 position:ccp(0.0, - screenSize.height)],
                               [CCCallFunc actionWithTarget:self selector:@selector(removeLayerFunc)],
                               
                               nil];
    [[self getChildByTag:kLayerColor] runAction:removeLayer];

}

-(void)forwardButtonTapped:(id)sender
{
    CCLOG(@"Back button tapped");

    [self goForwardShop];

}
-(void)backButtonTapped:(id)sender
{
    CCLOG(@"Back button tapped");
   
    [self goBackShop];
   
}

- (void)refreshButtonTapped:(id)sender
{
    CCLOG(@"Refresh button tapped");
    [self refreshPage];
}

-(void)stopButtonTapped:(id)sender
{

     CCLOG(@"Stop button tapped");
     [self stopLoading];
     [self stopActivitySpinner];
     
     [self.stopItem setOpacity:0];
     self.stopItem.isEnabled=NO;
     
     [self.refreshItem setOpacity:255];
     self.refreshItem.isEnabled=YES;
 
}

-(void)refreshPage
{
    [self.webView reload];
}

-(void)stopLoading
{
    if (self.webView.loading)
        [self.webView stopLoading];
    else
        [self disableStopButton];
}

-(void)stopActivitySpinner
{
    [activityIndicatorView stopAnimating];
}


-(void)goBackShop
{
    [self.webView goBack];
}

-(void)goForwardShop
{
    [self.webView goForward];
}


-(void)disableForwardButton
{
     [self.btnForward setOpacity:100];
     [self.forwardItem setIsEnabled:NO];
}

-(void)enableForwardButton
{
     [self.btnForward setOpacity:255];
     [self.forwardItem setIsEnabled:YES];
}

-(void)disableBackButton
{
     [self.btnBack setOpacity:100];
     [self.backItem setIsEnabled:NO];
}

-(void)enableBackButton
{
     [self.btnBack setOpacity:255];
     [self.backItem setIsEnabled:YES];
}

-(void)disableStopButton
{
     [self.btnStop setOpacity:0];
     [self.stopItem setIsEnabled:NO];
     [self.btnRefresh setOpacity:255];
     [self.refreshItem setIsEnabled:YES];
}

-(void)enableStopButton
{
     [self.btnStop setOpacity:255];
     [self.stopItem setIsEnabled:YES];
     [self.btnRefresh setOpacity:0];
     [self.refreshItem setIsEnabled:NO];
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
                              moveUp,
                              turnIsSwipeDownToYes,
                              makeSettingLayerInVisible,
                              nil];
    [self runAction:sequenceUp];
}

-(void)handleSwipeUp:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    if (isSwipedDown)
    {
        [self moveSceneUp];
    }
}

-(void)handleSwipeDown:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    if ((!isSwipedDown) && (!isSelected))
    {
        isSwipedDown = YES;
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
                                    nil];
        
        [self runAction:sequenceDown];
    }
}


-(void)handleSwipeLeft:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    if (!isSelected)
    {

     //   [self scheduleOnce:@selector(makeTransitionForward:) delay:0];
    }
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer *)aGestureRecognizer
{
    if (!isSelected)
    {
     //   [self scheduleOnce:@selector(makeTransitionBack:) delay:0];
    }
}

-(CCSprite *) itemForTouch: (UITouch *) touch
{
    if (!isSwipedDown)
    {
        if (isSelected)
        {
            /*
            // Test block to be deleted
            CGPoint touchLocation = [touch locationInView: [touch view]];
            touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
            for( CCSprite* item in [self children] ) {
                CGPoint local = [item convertToNodeSpace:touchLocation];
                CGRect r = CGRectMake( item.position.x - item.contentSize.width*item.anchorPoint.x, item.position.y-
                                      item.contentSize.height*item.anchorPoint.y,
                                      item.contentSize.width, item.contentSize.height);
                r.origin = CGPointZero;
                if( CGRectContainsPoint( r, local ) )
                {
                    CCLOG(@"touched object %@", item);
                    break;
                }
            }
            
            // End of test block
            */
            return lastSelected;
        }
        
        CGPoint touchLocation = [touch locationInView: [touch view]];
        touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
        for( CCSprite* item in self.arrayThumbnails ) {
            CGPoint local = [item convertToNodeSpace:touchLocation];
            CGRect r = CGRectMake( item.position.x - item.contentSize.width*item.anchorPoint.x, item.position.y-
                                  item.contentSize.height*item.anchorPoint.y,
                                  item.contentSize.width, item.contentSize.height);
            r.origin = CGPointZero;
            if( CGRectContainsPoint( r, local ) )
            {
        
                [self.selectedName setString:[self.arrayNames objectAtIndex:[self.arrayThumbnails indexOfObject:item]]];
                [self.selectedTitle setString:[self.arrayTitles objectAtIndex:[self.arrayThumbnails indexOfObject:item]]];
                [self.selectedURL setString:[self.arrayURLs objectAtIndex:[self.arrayThumbnails indexOfObject:item]]];
                [self.selectedOriginalURL setString:[self.arrayOriginalURLs objectAtIndex:[self.arrayThumbnails indexOfObject:item]]];
            //    CCLOG(@"selected item %f", item.contentSize.width);
                return item;
            }
        }
    }
	return nil;
}

/*
-(void)handleTap:(UITapGestureRecognizer *)aGestureRecognizer
{
    
    if ((!isLoading) && (!isSelected) && (!isHandled))
    {
        
        for (id obj in self.arrayThumbnails)
        {
            [obj removeFromParentAndCleanup:YES];
        }
        
        [self.arrayThumbnails removeAllObjects];
        [self.items removeAllObjects];
        isSelected = NO;

        [self loadThumbnails];
    }
     
}
*/





@end
