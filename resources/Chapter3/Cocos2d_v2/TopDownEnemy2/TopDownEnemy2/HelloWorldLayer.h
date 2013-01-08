//
//  HelloWorldLayer.h
//  TopDownEnemy2
//
//  Created by Justin Dike on 6/18/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//

#import "Constants.h"
#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
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
