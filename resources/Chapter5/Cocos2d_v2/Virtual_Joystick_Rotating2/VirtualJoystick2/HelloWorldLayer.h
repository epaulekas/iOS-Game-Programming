//
//  HelloWorldLayer.h
//  VirtualJoystick2
//
//  Created by Justin Dike on 6/12/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    
    int initialTouchX;
    int initialTouchY;
    
    CGPoint centerOfJoyStick;
    int screenWidth;
    int screenHeight;
    CCSprite* joyStickBall;
    
    int length;
    
    
    int degreeOffset;
    CCSprite* ship;    
    
    
    UIRotationGestureRecognizer *rotationGR;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
