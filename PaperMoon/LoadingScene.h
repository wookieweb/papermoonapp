//
//  LoadingScene.h
//  PaperMoon
//
//  Created by Andy Woo on 2/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"


@interface LoadingScene : CCScene {
    SceneTypes targetScene_;
}
+(id) sceneWithTargetScene:(SceneTypes)targetScene;
-(id) initWithTargetScene:(SceneTypes)targetScene;
@end
