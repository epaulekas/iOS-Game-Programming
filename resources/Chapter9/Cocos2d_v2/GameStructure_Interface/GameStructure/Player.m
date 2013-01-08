//
//  Player.m
//  GameStructure
//
//  Created by Justin's Clone on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player
@synthesize flying;

+(id) createWithDictionary:(NSDictionary*)theDictionary {
    
    
    return [[[self alloc] initWithDictionary:(NSDictionary*)theDictionary ] autorelease];
    
    
}


-(id) initWithDictionary:(NSDictionary*)theDictionary {
    
    if ((self = [super init]))
    {
        
        self.position = CGPointFromString( [theDictionary objectForKey:@"PlayerLocation"] );
        
        
        NSString* spriteSheetName = [theDictionary objectForKey:@"SpriteSheetName"];
        NSString* plistName = [NSString stringWithFormat:@"%@.plist", spriteSheetName ];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: plistName ];
        
    
        
        NSString* bruisedImage = [theDictionary objectForKey:@"BruisedImage"];
        bruisedPose = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:bruisedImage];
        
        NSString* defaultImage = [theDictionary objectForKey:@"BaseImage"];
        defaultPose = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:defaultImage];
        
        
        playerSprite = [CCSprite spriteWithSpriteFrame:defaultPose];
        [self addChild:playerSprite];
        
        gravity = [[theDictionary objectForKey:@"Gravity"] integerValue];
        
        isAnimated = [[theDictionary objectForKey:@"IsAnimated"] boolValue];
        
        if ( isAnimated == YES ) {
            
            animationBaseName = [theDictionary objectForKey:@"AnimationBaseName"];
            framesToAnimate =  [[theDictionary objectForKey:@"FramesToAnimate"] integerValue];
    
            [self setUpAnimation]; 
        }
        
        [self schedule:@selector(movePlayerDown:)interval:1.0f/60.0f ];
        
    }
    return self;
    
}

-(void) setUpAnimation {
    
    
    NSMutableArray *flyingFrames = [NSMutableArray arrayWithCapacity:framesToAnimate];
    for(int i = 1; i <= framesToAnimate; ++i) {
        
        NSString* file = [NSString stringWithFormat:@"%@%i.png", animationBaseName, i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file];
        [flyingFrames addObject:frame];
    }
    
    
    CCAnimation* flyingAnimation = [CCAnimation animationWithSpriteFrames:flyingFrames delay:1.0/15.0 ];
    CCAnimate* animate = [CCAnimate actionWithAnimation:flyingAnimation];
    self.flying = [CCRepeatForever actionWithAction:animate];
    [playerSprite runAction:flying];

    
}


-(void) movePlayerDown:(ccTime) delta {
    
    self.position = ccp(self.position.x, self.position.y - gravity  );
    
   
}



-(void) showBruisedState {
    
    if ( isBruised == NO) {
        
        isBruised = YES;
    
        if ( isAnimated == YES ) {
        
            [playerSprite stopAction:flying];
        
        }
    
        [playerSprite setDisplayFrame:bruisedPose];
   
        [self performSelector:@selector(showNormalState) withObject:nil afterDelay:0.5f ];
        
    }

}
-(void) showNormalState {
    
    if ( isAnimated == YES  ) {
        
        [playerSprite runAction:flying];
       
        
    } else {
        
         [playerSprite setDisplayFrame:defaultPose];
   
    }
    
    isBruised = NO;
    
    
}



-(void) dealloc {
    
    self.flying = nil;
    
    [super dealloc];
}

@end
