//
//  GameSounds.m
//  GameStructure
//
//  Created by Justin's Clone on 10/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameSounds.h"


@implementation GameSounds

@synthesize isAudioMuted; 

static GameSounds *sharedSounds = nil;


+(GameSounds*) sharedSounds {
    
    if (sharedSounds == nil) {
        sharedSounds = [[GameSounds alloc] init];
    }
    return sharedSounds;
    
}

-(id) init
{
    
    if ((self = [super init] ))
    {
        sharedSounds = self;
        
        
    }
    return self;
    
}

-(void) playSoundFX:(NSString*)fileToPlay {
    
    if ( isAudioMuted == NO ) {
        
        [[SimpleAudioEngine sharedEngine] playEffect:fileToPlay];
        
    }
    
}
-(void) playBackgroundMusic:(NSString*)fileToPlay {
    
    if ( isAudioMuted == NO ) {
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:fileToPlay];
    }

}



@end
