//
//  Enemy.m
//  GameStructure
//
//  Created by Justin's Clone on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"


@implementation Enemy

@synthesize enemySprite;

+(id) createWithDictionary:(NSDictionary*)theDictionary {
    
    
    return [[[self alloc] initWithDictionary:(NSDictionary*)theDictionary ] autorelease];
    
    
}


-(id) initWithDictionary:(NSDictionary*)theDictionary {
    
    if ((self = [super init]))
    {
        
       
        enemySprite = [CCSprite spriteWithFile: [theDictionary objectForKey:@"BaseImage"]];
        [self addChild:enemySprite];
        
        
        enemySprite.flipY = [[theDictionary objectForKey:@"FlipY"] boolValue];
        enemySprite.flipX = [[theDictionary objectForKey:@"FlipX"] boolValue];
            
              
        speed = [[theDictionary objectForKey:@"EnemySpeed"] integerValue];
        
        [self schedule:@selector(moveEnemy:)interval:1.0f/60.0f ];

    }
    return self;
    
}

-(void) moveEnemy:(ccTime) delta {
    
    self.position = ccp(self.position.x - speed, self.position.y  );
    
    
    if ( self.position.x < -100) {
        
        [self unschedule:_cmd];
        [self removeFromParentAndCleanup:YES];
    }
}

-(void) dealloc {
    
    CCLOG(@"removing enemy");
    
    [super dealloc];
}


@end
