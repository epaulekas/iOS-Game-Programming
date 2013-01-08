//
//  Platform.m
//  CollisionWithPlane
//
//  Created by Justin's Clone on 10/4/12.
//  Copyright 2012 Justin's Clone. All rights reserved.
//

#import "Platform.h"


@implementation Platform

@synthesize sprite;

+(id) create {
    
    
    return [[[self alloc] init ] autorelease];
    
    
}

-(id) init {
    
    if ((self = [super init]))
    {
        sprite = [CCSprite  spriteWithFile:@"blocks.png"];
        [self addChild:sprite];
                
    }
    return self;
    
}



-(void) dealloc {
    
    [super dealloc];
}






@end
