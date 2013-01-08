//
//  HelloWorldLayer.h
//  SpriteSheets2
//
//  Created by Justin Dike on 6/12/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//




// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer 
{
    int screenWidth;
    int screenHeight;
    
    CGPoint startingPosition;
    
    CCSprite *zombie;
    CCSprite *shadow;
    
    CCSequence* walkRight;
    CCSequence* walkLeft;
    CCSequence* kick;
    CCSequence* jump;
    CCSequence* punch;
    
    CCParticleSystem* attackSystem;
    
    bool moveInProgress; 
    
    CCSpriteFrame* defaultPose; 
    
    UITapGestureRecognizer *tapToPunch;
    UITapGestureRecognizer *tapToKick;
    
    UISwipeGestureRecognizer *swipeUp;
    UISwipeGestureRecognizer *swipeLeft;
    UISwipeGestureRecognizer *swipeRight;

    
}

@property (nonatomic, retain)  CCSequence* walkRight;
@property (nonatomic, retain)  CCSequence* walkLeft;
@property (nonatomic, retain)  CCSequence* kick;
@property (nonatomic, retain)  CCSequence* jump;
@property (nonatomic, retain)  CCSequence* punch;


// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
