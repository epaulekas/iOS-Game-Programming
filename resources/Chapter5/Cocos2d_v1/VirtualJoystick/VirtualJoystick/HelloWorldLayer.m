//
//  HelloWorldLayer.m
//  VirtualJoystick
//
//  Created by Justin Dike on 5/1/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        CGSize size = [ [CCDirector sharedDirector] winSize ];
        screenWidth = size.width;
        screenHeight = size.height;
		
		self.isTouchEnabled = YES;
        centerOfJoyStick = ccp( screenWidth/ 2, 128);
        
        CCSprite *joyStickBase = [ CCSprite spriteWithFile:@"joystick_base.png"];
        [self addChild:joyStickBase z:0];
        joyStickBase.position =centerOfJoyStick;
        
        joyStickBall = [ CCSprite spriteWithFile:@"joystick_ball.png"];
        [self addChild:joyStickBall z:1];
        joyStickBall.position =centerOfJoyStick;
        
	}
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    initialTouchX = location.x;
    initialTouchY = location.y;
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];

    int xSwipe;
    int ySwipe;
    
    xSwipe = abs( location.x - initialTouchX);
    ySwipe = abs( location.y - initialTouchY);
    
    if ( xSwipe > ySwipe) {  //x direction was the greater swipe
        if (location.x > initialTouchX) {
            [self rightHandler];
        } else {
            [self leftHandler];
        }
    } else { //y direction was the greater swipe
        if ( location.y > initialTouchY) {
            [self upHandler];
        } else {
            [self downHandler];
        }
    }
}
-(void)rightHandler{
    CCLOG(@"Right Swipe");
    joyStickBall.position = ccp( centerOfJoyStick.x + 40 , centerOfJoyStick.y);
}
-(void)leftHandler{
    CCLOG(@"Left Swipe");
    joyStickBall.position = ccp( centerOfJoyStick.x - 40, centerOfJoyStick.y);
}
-(void)upHandler{
    CCLOG(@"Up Swipe");
    joyStickBall.position = ccp( centerOfJoyStick.x , centerOfJoyStick.y + 40);
}
-(void)downHandler{
    CCLOG(@"Down Swipe");
    joyStickBall.position = ccp( centerOfJoyStick.x , centerOfJoyStick.y - 40);
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
