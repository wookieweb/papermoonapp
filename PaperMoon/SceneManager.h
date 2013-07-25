//
//  SceneManager.h
//  PaperMoon
//
//  Created by Andy Woo on 27/12/12.
//
//

#import <Foundation/Foundation.h>
#import "Constants.h"


@interface SceneManager : NSObject
{
    SceneTypes currentScene;
}

@property (readwrite) BOOL isMusicOn;

+(SceneManager *)sharedSceneManager;
-(void)runSceneWithID:(SceneTypes)sceneID withDirection:(Direction)aDirection withSender:(id)sender;
-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen;
-(void)playMusic;
-(void)stopMusic;
-(BOOL)isPlayingMusic;

@end
