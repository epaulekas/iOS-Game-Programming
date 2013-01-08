//
//  Player.m
//  CollisionWithPlane
//
//  Created by Justin's Clone on 10/4/12.
//  Copyright 2012 Justin's Clone. All rights reserved.
//

#import "Player.h"


@implementation Player

@synthesize sprite;


+(id) create {
    
    
    return [[[self alloc] init ] autorelease];
    
    
}

-(id) init {
    
    if ((self = [super init]))
    {
        
        sprite = [CCSprite  spriteWithFile:@"farmer.png"];
        [self addChild:sprite];
        
    }
    return self;
    
}


-(void) dealloc {
    
    [super dealloc];
}


@end
