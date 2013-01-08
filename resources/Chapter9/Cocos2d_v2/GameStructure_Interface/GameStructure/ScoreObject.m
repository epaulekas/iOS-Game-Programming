//
//  ScoreObject.m
//  GameStructure
//
//  Created by Justin's Clone on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreObject.h"


@implementation ScoreObject

@synthesize objectSprite, pointValue;

+(id) createWithDictionary:(NSDictionary*)theDictionary {
    
    
    return [[[self alloc] initWithDictionary:(NSDictionary*)theDictionary ] autorelease];
    
    
}


-(id) initWithDictionary:(NSDictionary*)theDictionary {
    
    if ((self = [super init]))
    {
        
        objectSprite = [CCSprite spriteWithFile: [theDictionary objectForKey:@"BaseImage"]];
        [self addChild:objectSprite];
        
        objectSprite.flipY = [[theDictionary objectForKey:@"FlipY"] boolValue];
        objectSprite.flipX = [[theDictionary objectForKey:@"FlipX"] boolValue];
        
        pointValue = [[theDictionary objectForKey:@"Points"] integerValue ];
        
    }
    return self;
    
}

-(void) dealloc {
    
    CCLOG(@"removing score object");
    
    [super dealloc];
}


@end
