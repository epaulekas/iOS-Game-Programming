//
//  Player.m
//  TopDownEnemy
//
//  Created by Justin Dike on 4/13/12.
//  Copyright 2012 cartoonsmart.com. All rights reserved.
//

#import "Player.h"


@implementation Player

+(id) node {
    
    return [[[self alloc] init] autorelease];
}

-(id) init{
    
    if ((self = [super init]))
    {
        CCLOG(@"init");                
    }
    return self;
    
}

@end
