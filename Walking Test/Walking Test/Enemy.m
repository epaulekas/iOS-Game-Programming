//
//  Enemy.m
//  Walking Test
//
//  Created by Ezra Paulekas on 1/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"


@implementation Enemy

+(id) create {
    // allocate an autorelease instance of self into memory
    return [[[ self alloc ] init ] autorelease ];
}

+(id) createAtPosition: (CGPoint) thePoint    {
    return [[[self alloc] initiAtPosition:thePoint] autorelease];
}

-(id) init   {
    if(self = [super init]) {
        enemySprite = [CCSprite spriteWithFile:@"enemy_still.png"];
        [self addChild:enemySprite];
    }
    return self;
}

-(id) initiAtPosition:(CGPoint) thePoint  {
    if(self = [super init]) {
        self.position = thePoint;
        enemySprite = [CCSprite spriteWithFile:@"enemy_still.png"];
        [self addChild:enemySprite];
    }
    return self;
}

-(void) setBaseImage:(NSString *)baseImageName  {
    baseImageName = baseImage;
}

-(void) walkAround  {
    CCLOG(@"walk around");
}

-(void)setSpeedToLow    {
    CCLOG(@"low speed");
}

-(void) tintRedToShowFuriousAnger    {
    CCLOG(@"sunburned Hulk mode");
}

-(void) dealloc {
    [super dealloc];
}

@end
