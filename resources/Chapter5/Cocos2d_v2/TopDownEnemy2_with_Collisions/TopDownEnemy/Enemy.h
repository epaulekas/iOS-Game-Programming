//
//  Enemy.h
//  TopDownEnemy
//
//  Created by Justin Dike on 6/12/12.
//  Copyright 2012 cartoonsmart.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"

@interface Enemy : CCNode  {
    
    CCSprite* enemySprite;
    NSString *baseImage;
    
    int screenWidth;
    int screenHeight;
    
    int walkCounter;
    int amountToMoveThisInterval;
    int directionToMove;
    int speed;
    float delay;
    
    bool canBeDamaged;
    
}

@property ( nonatomic ) bool canBeDamaged;
@property (readonly, nonatomic ) CCSprite* enemySprite;


+(id) createWithLocation:(CGPoint)thePoint andBaseImage:(NSString*)theBaseImage;

-(void) walkAround;
-(void) setSpeedToLow;
-(void) tintRedToShowFuriousAnger;
-(CGRect) getRect;


-(void) tellMe;

@end
