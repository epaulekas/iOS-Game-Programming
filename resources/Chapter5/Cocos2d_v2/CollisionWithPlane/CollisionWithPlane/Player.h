//
//  Player.h
//  CollisionWithPlane
//
//  Created by Justin's Clone on 10/4/12.
//  Copyright 2012 Justin's Clone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCNode {
    
    CCSprite* sprite;
    
}

@property (readonly, nonatomic ) CCSprite* sprite;


+(id) create;



@end