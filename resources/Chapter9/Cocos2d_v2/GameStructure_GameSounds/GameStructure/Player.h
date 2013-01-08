//
//  Player.h
//  GameStructure
//
//  Created by Justin's Clone on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCNode {
    

    CCSprite* playerSprite;
    CCRepeatForever *flying;
    
    
    CCSpriteFrame* bruisedPose;
    CCSpriteFrame* defaultPose;
    
    
    bool isAnimated;
    NSString* animationBaseName;
    int framesToAnimate;
    
    int gravity;
    
    bool isBruised;
    
}

@property (nonatomic, retain) CCRepeatForever *flying;

+(id) createWithDictionary:(NSDictionary*)theDictionary;

-(void) showBruisedState;

@end
