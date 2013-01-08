//
//  GameSounds.h
//  GameStructure
//
//  Created by Justin's Clone on 10/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface GameSounds : CCNode {
    
    bool isAudioMuted;
    
}

@property (readwrite, nonatomic) bool isAudioMuted;


+(GameSounds*) sharedSounds;

-(void) playSoundFX:(NSString*)fileToPlay;
-(void) playBackgroundMusic:(NSString*)fileToPlay;

@end
