//
//  HelloWorldLayer.h
//  TopDownEnemy
//
//  Created by Justin Dike on 4/11/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Constants.h"


// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    
    CCSprite* enemy;
    int screenWidth;
    int screenHeight;
    
    int walkCounter;
    int amountToMoveThisInterval;
    int directionToMove;
    int speed;
    float delay;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
