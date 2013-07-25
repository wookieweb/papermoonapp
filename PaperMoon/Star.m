//
//  Star.m
//  PaperMoon
//
//  Created by Andy Woo on 30/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Star.h"


@implementation Star

- (void) draw
{
    ccDrawColor4F(1.0f, 1.0f, 1.0f, 1.0f);
    glLineWidth(3);
    CGPoint center = ccp(0.f, 0.f);
    CGFloat radius = 1.0f;
    CGFloat angle = 0.f;
    NSInteger segments = 10;
    BOOL drawLineToCenter = YES;
    
    ccDrawCircle(center, radius, angle, segments, drawLineToCenter);
}

@end
