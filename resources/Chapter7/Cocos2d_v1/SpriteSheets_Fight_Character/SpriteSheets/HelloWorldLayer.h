//
//  HelloWorldLayer.h
//  SpriteSheets
//
//  Created by Justin Dike on 5/31/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    
    int screenWidth;
    int screenHeight;
    
    CCSprite *zombie;
    CCSprite *shadow;
    CCSequence *walkRight; 
    CCSequence *walkLeft; 
    CCSequence* kick;
    CCSequence* punch;
    CCSequence* jump;
    
    UITapGestureRecognizer *tapToPunch;
    UITapGestureRecognizer *tapToKick;
    
    UISwipeGestureRecognizer *swipeUp;
    UISwipeGestureRecognizer *swipeLeft;
    UISwipeGestureRecognizer *swipeRight;
    
    bool moveInProgress;
    
    CCSpriteFrame* defaultPose;
    
}


@property (nonatomic, retain) CCSequence *walkRight;
@property (nonatomic, retain) CCSequence *walkLeft;
@property (nonatomic, retain) CCSequence* kick;
@property (nonatomic, retain) CCSequence* punch;
@property (nonatomic, retain) CCSequence* jump;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;



@end
