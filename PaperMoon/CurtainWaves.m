//
//  CurtainWaves.m
//  PaperMoon
//
//  Created by Andy Woo on 17/4/13.
//
//

#import "CurtainWaves.h"

@implementation CurtainWaves



-(void)update:(ccTime)time
{
	int i, j;
    
	for( i = 0; i < (gridSize_.x+1); i++ )
	{
		for( j = 0; j < (gridSize_.y+1); j++ )
		{
			ccVertex3F	v = [self originalVertex:ccg(i,j)];
            
			if ( vertical ) {
				v.x = ((v.x + (sinf(time*(CGFloat)M_PI*waves*2 + v.y * .01f) * amplitude * amplitudeRate * (1 - v.y/320))));
         //   CCLOG (@"v.y / 320 = %f", v.y/320);
         //       CCLOG(@"Amplitude: %f", amplitude);
         //       CCLOG(@"Amplitude Rate: %f", amplitudeRate);
         //       CCLOG (@"v.x = %f", v.x);
            }
			if ( horizontal )
				v.y = (v.y + (sinf(time*(CGFloat)M_PI*waves*2 + v.x * .01f) * amplitude * amplitudeRate));
            
			[self setVertex:ccg(i,j) vertex:v];
		}
	}
}

@end
