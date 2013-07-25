//
//  Constants.h
//  PaperMoon
//
//  Created by Andy Woo on 27/12/12.
//
//

#ifndef PaperMoon_Constants_h
#define PaperMoon_Constants_h

#define kSCENE2WAVESPEED  0.07f
// #define kBackground 0
// #define kTree 1
// #define kOthers 2
// #define kTallGreen 3

typedef enum
{
    kMainMenuScene = 0,
    kScene1 = 1,
    kScene2 = 2,
    kScene3 = 3,
    kScene4 = 4,
    kScene5 = 5,
    kScene6 = 6,
    kScene7 = 7,
    kScene8 = 8,
    kOptionsScene = 10,
    kCreditsScene = 11,
    kStoryScene = 12,
    kShopScene = 13,
    kFlickrScene = 14
} SceneTypes;

typedef enum
{
    kLinkTypeArtistSite,
    kLinkTypeProducerSite,
    kLinkTypeAnimationSite
} LinkTypes;

typedef enum
{
    kLeft,
    kRight
} Direction;

typedef enum
{
    kLayerTagGoomaRepeat = 0,
    kLayerTagScene6Layer = 1,
    kLayerTagBackground = 2,
    kLayerTagObjects = 3,
    kLayerTagGooma1st = 4,
    kLayerTagWindowOpen = 5,
    kLayerTagWindowClose = 6,
    kLayerTagWindowClose2nd = 7,
    kLayerTagGoomaYelling = 8,
    kLayerTagScene7Layer = 9,
    kLayerTagScene8Layer = 10,
} LayerTag;

typedef enum
{
    kOpen = 0,
    kClose = 1,
} ActionTypes;

typedef enum
{
    stateOpen = 0,
    stateClosed = 1,
} WindowStates;

#endif


