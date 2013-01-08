//
//  Enemy.h
//  GameStructure
//
//  Created by Justin's Clone on 9/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Enemy : CCNode {
    
     CCSprite* enemySprite;
     int speed;
    
}

@property (readonly, nonatomic ) CCSprite* enemySprite;

+(id) createWithDictionary:(NSDictionary*)theDictionary;

@end
