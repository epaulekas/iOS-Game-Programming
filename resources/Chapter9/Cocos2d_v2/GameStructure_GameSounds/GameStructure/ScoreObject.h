//
//  ScoreObject.h
//  GameStructure
//
//  Created by Justin's Clone on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ScoreObject : CCNode {
    
    CCSprite* objectSprite;
    int pointValue;
    
}

@property (readonly, nonatomic ) CCSprite* objectSprite;
@property (readonly, nonatomic ) int pointValue;

+(id) createWithDictionary:(NSDictionary*)theDictionary;


@end
