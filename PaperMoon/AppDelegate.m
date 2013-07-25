//
//  AppDelegate.m
//  PaperMoon
//
//  Created by Andy Woo on 25/12/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "cocos2d.h"
#import "AppDelegate.h"
#import "IntroLayer.h"
// #import "SimpleAudioEngine.h"
// #import <Crashlytics/Crashlytics.h>
#import "TestFlight.h"
#import "PayPal.h"
#import "ShopSceneLayer.h"



@implementation AppController

@synthesize window=window_, navController=navController_, director=director_, isSwipeDown = isSwipeDown_, cartItem = cartItem_, internetActive = internetActive_, hostActive = hostActive_;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.cartItem = 0;
    self.isLoadCart = NO;

//    [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
    
#ifdef TESTING
    
//     Disable deprecated-declarations warning.
//     See http://clang.llvm.org/docs/UsersManual.html#diagnostics_pragmas
     
//     Basic workflow:
     
//     1. push current warnings onto stack
//     2. ignore warning we know will get thrown
//     3. do dodgy thing that causes warning
//     4. pop warnings - go back to what we had before we started fiddling with them
     
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
#pragma clang diagnostic pop
#endif
    
    [TestFlight takeOff:@"3f0bb57e-eb72-4c77-b79a-15e567299829"];
    
     
    
    // Initialize Simple Audio Engine
 //   [SimpleAudioEngine sharedEngine];
    
	// Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];


	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGBA8	//kEAGLColorFormatRGBA8 EAGLColorFormatRGB565
								   depthFormat:GL_DEPTH_COMPONENT24_OES  //GL_DEPTH_COMPONENT24_OES 0
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];

	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];

	director_.wantsFullScreenLayout = YES;

	// Display FSP and SPF
	[director_ setDisplayStats:NO];

	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];

	// attach the openglView to the director
	[director_ setView:glView];

	// for rotation and other messages
	[director_ setDelegate:self];
    
    

	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
//	[director_ setProjection:kCCDirectorProjection3D];

	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");

	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];

	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"

	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];

	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
	[director_ pushScene: [IntroLayer scene]]; 

	
	// Create a Navigation Controller with the Director
	navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;
	
	// set the Navigation Controller as the root view controller
//	[window_ addSubview:navController_.view];	// Generates flicker.
	[window_ setRootViewController:navController_];
	
	// make main window visible
	[window_ makeKeyAndVisible];
    
 //   [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"backgroundMusic.wav" loop:YES];
  

//    [Crashlytics startWithAPIKey:@"d83ffb923f76fbc54a6b0c29be840bb4688f4d6e"];
    
 
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
        internetReachable = [Reachability reachabilityForInternetConnection];
        internetReachable.reachableOnWWAN = YES;
        [internetReachable startNotifier];
        hostReachable = [Reachability reachabilityWithHostname:@"shop.crazylabel.com"];
        hostReachable.reachableOnWWAN = YES;
        [hostReachable startNotifier];
 
    
	return YES;
}


- (void)checkNetworkStatus:(NSNotification *)notice {
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus) {
        case NotReachable:
            self.internetActive = NO;
            CCLOG(@"Internet not Reachable");
            break;
        case ReachableViaWiFi:
            self.internetActive = YES;
            break;
        case ReachableViaWWAN:
            self.internetActive = YES;
            break;
    }
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus) {
        case NotReachable:
            self.hostActive = NO;
            CCLOG(@"Host not Reachable");
            break;
        case ReachableViaWiFi:
            self.hostActive = YES;
            break;
        case ReachableViaWWAN:
            self.hostActive = YES;
            break;
    }
}

// Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);

}




// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
	  [director_ stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
            [director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

@end

