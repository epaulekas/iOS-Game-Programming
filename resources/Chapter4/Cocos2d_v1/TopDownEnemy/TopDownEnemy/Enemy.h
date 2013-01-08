//
//  Enemy.h
//  TopDownEnemy
//
//  Created by Justin Dike on 4/13/12.
//  Copyright 2012 cartoonsmart.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"

@interface Enemy : CCNode {
    
    CCSprite* enemySprite;
    NSString *baseImage;
    
    int screenWidth;
    int screenHeight;
    
    int walkCounter;
    int amountToMoveThisInterval;
    int directionToMove;
    int speed;
    float delay;

}

+(id) createWithLocation:(CGPoint)thePoint andBaseImage:(NSString*)theBaseImage;

-(void) walkNorth;
-(void) setSpeedToLow;
-(void) tintRedToShowFuriousAnger;

@end
