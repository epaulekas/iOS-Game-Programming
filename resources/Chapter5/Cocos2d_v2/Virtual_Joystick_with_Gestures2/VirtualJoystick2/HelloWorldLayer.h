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
    
    /* GESTURES */
    
    //swipes...
    
    UISwipeGestureRecognizer *swipeUpGR;
    UISwipeGestureRecognizer *swipeDownGR;
    UISwipeGestureRecognizer *swipeLeftGR;
    UISwipeGestureRecognizer *swipeRightGR;
    
    //taps
    
    UITapGestureRecognizer *tapGR;
    
    //rotation
    UIRotationGestureRecognizer *rotationGR;
    
	//long press down
	UILongPressGestureRecognizer *longPressGR;
    
    //pan
	UIPanGestureRecognizer *panGR;
	
    //pinch
	UIPinchGestureRecognizer *pinchGR;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
