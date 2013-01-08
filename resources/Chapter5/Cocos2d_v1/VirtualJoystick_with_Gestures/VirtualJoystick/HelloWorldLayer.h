//
//  HelloWorldLayer.h
//  VirtualJoystick
//
//  Created by Justin Dike on 5/1/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer 
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
