//
//  ScoreNodes.m
//  GameStructure
//
//  Created by Justin's Clone on 9/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreNodes.h"


@implementation ScoreNodes


+(id) createWithSpeed:(int)speed  {
    
    return [[[self alloc] initWithSpeed:(int)speed  ] autorelease];
    
}


-(id)  initWithSpeed:(int)speed  {
    
    if ((self = [super init]))
    {
        
        moveSpeed = speed;
        
        [self schedule:@selector(move:)interval:1.0f/60.0f ];
       
        
    }
    return self;
    
}

-(void) move:(ccTime) delta {
    
    self.position = ccp(self.position.x - moveSpeed, self.position.y  );
    
    
    
}

-(void) dealloc {
    
    CCLOG(@"removing score group");
    
    [super dealloc];
}


@end
