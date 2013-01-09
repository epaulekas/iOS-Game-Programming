//
//  Enemy.m
//  Walking Test
//
//  Created by Ezra Paulekas on 1/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"


@implementation Enemy

+(id)create {
    // allocate an autorelease instance of self into memory
    return [[[ self alloc ] init ] autorelease ];
}

-(id)init   {
    if(self = [super init]) {
        CCLOG(@"An instance of this enemy was created (instantiated)");
    }
    return self;
}

@end
