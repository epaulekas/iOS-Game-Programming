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
        length = 50;
        
        CCSprite *joyStickBase = [ CCSprite spriteWithFile:@"joystick_base.png"];
        [self addChild:joyStickBase z:0];
        joyStickBase.position =centerOfJoyStick;
        
        joyStickBall = [ CCSprite spriteWithFile:@"joystick_ball.png"];
        [self addChild:joyStickBall z:1];
        joyStickBall.position =centerOfJoyStick;
        
        ship = [ CCSprite spriteWithFile:@"triangle_ship.png"];
        [self addChild:ship z:0 tag:922];
        ship.position = ccp( screenWidth/2 , screenHeight/2 );
        
        [self addSwipeGestures];
        [self addPanGesture];
        [self addTapGesture];
        [self addRotationGestures];
        [self addPressGesture];
        [self addPinchGesture]; //using both the pinch gesture and rotation often gets wonky
        
        
        
       
       
              
	}
	return self;
}


#pragma mark Add Swipes and Handlers

-(void) addSwipeGestures {
    
    swipeUpGR =[[ UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
    swipeUpGR.numberOfTouchesRequired = 1;
	swipeUpGR.direction = UISwipeGestureRecognizerDirectionUp; 
	[[[CCDirector sharedDirector]openGLView]  addGestureRecognizer:swipeUpGR];
	[swipeUpGR release];

    
    
    swipeDownGR =[[ UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
    swipeDownGR.numberOfTouchesRequired = 1;
	swipeDownGR.direction = UISwipeGestureRecognizerDirectionDown; 
	[[[CCDirector sharedDirector]openGLView]  addGestureRecognizer:swipeDownGR];
	[swipeDownGR release];
    
    
    swipeLeftGR =[[ UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    swipeLeftGR.numberOfTouchesRequired = 1;
	swipeLeftGR.direction = UISwipeGestureRecognizerDirectionLeft; 
	[[[CCDirector sharedDirector]openGLView]  addGestureRecognizer:swipeLeftGR];
	[swipeLeftGR release];

    
    
    swipeRightGR =[[ UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    swipeRightGR.numberOfTouchesRequired = 1;
	swipeRightGR.direction = UISwipeGestureRecognizerDirectionRight; 
	[[[CCDirector sharedDirector]openGLView]  addGestureRecognizer:swipeRightGR];
	[swipeRightGR release];
    
}

-(void) handleSwipeUp:(UISwipeGestureRecognizer *)recognizer  { 
	
	CCLOG(@"Swiped Up");
    joyStickBall.position = ccp( centerOfJoyStick.x , centerOfJoyStick.y + 40);
}
-(void) handleSwipeDown:(UISwipeGestureRecognizer *)recognizer  { 
	
	CCLOG(@"Swiped Down");
    joyStickBall.position = ccp( centerOfJoyStick.x , centerOfJoyStick.y - 40);
}
-(void) handleSwipeLeft:(UISwipeGestureRecognizer *)recognizer  { 
	
	CCLOG(@"Swiped Left");
    joyStickBall.position = ccp( centerOfJoyStick.x - 40, centerOfJoyStick.y);
}
-(void) handleSwipeRight:(UISwipeGestureRecognizer *)recognizer  { 
	
	CCLOG(@"Swiped Right");
    joyStickBall.position = ccp( centerOfJoyStick.x + 40 , centerOfJoyStick.y);
}

#pragma mark Add Pan Gesture and Handler

-(void) addPanGesture {
    
    panGR  = [[ UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
	panGR.minimumNumberOfTouches = 2;
	panGR.maximumNumberOfTouches = 6;
	[ [[CCDirector sharedDirector]openGLView] addGestureRecognizer:panGR];
	[panGR release];
    
}
-(void) handlePan:(UIPanGestureRecognizer *)recognizer  { 
    
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
	
    CCLOG(@"Panning with 2 fingers occurring. Speed on x is: %i and y is: %i", (int)velocity.x , (int)velocity.y);
    
	if (abs(velocity.x) < 50){
        CCLOG(@"moving slowly");
        
    }
    
}

#pragma mark Add Tap Gesture and Handler

-(void) addTapGesture {
    
    tapGR = [[ UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGR.numberOfTapsRequired = 3;
    tapGR.numberOfTouchesRequired = 1;
    [ [[CCDirector sharedDirector]openGLView]  addGestureRecognizer:tapGR];
    [tapGR release];

}

-(void) handleTap:(UITapGestureRecognizer *)recognizer  { 
	

    CGPoint location = [recognizer locationInView:recognizer.view];
    location = [[CCDirector sharedDirector] convertToGL:location];
    CCLOG(@"3 taps detected at x: %f and y: %f", location.x , location.y );
}



#pragma mark Add Press Gesture and Handler 

-(void) addPressGesture {
    
    longPressGR = [[ UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
	longPressGR.minimumPressDuration = 3.0;
	[ [[CCDirector sharedDirector]openGLView] addGestureRecognizer:longPressGR];
	[longPressGR release];
    
}
-(void) handleLongPress:(UILongPressGestureRecognizer *)recognizer  { 
	
	CGPoint location = [recognizer locationInView:recognizer.view];
    location = [[CCDirector sharedDirector] convertToGL:location];
    CCLOG(@"long press detected at x: %f and y: %f", location.x , location.y );
    
    if ( CGRectContainsPoint(joyStickBall.boundingBox, location) ){
        
        CCLOG(@"long press inside of joystick" );
    }

}

#pragma mark Add Pinch Gesture and Handler 

-(void) addPinchGesture {
    
    pinchGR = [[ UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [ [[CCDirector sharedDirector] openGLView] addGestureRecognizer:pinchGR];
	[pinchGR release];
    
}
-(void) handlePinch:(UIPinchGestureRecognizer *)recognizer  { 
	
    
    
	CCLOG(@"Pinch %f",  recognizer.scale);
    
    joyStickBall.position = ccp( centerOfJoyStick.x - (cos( recognizer.scale ) * 75) , centerOfJoyStick.y + (sin( recognizer.scale ) * 20) );
   
}

#pragma mark Add Rotation Gesture,  Handler and remove method

-(void) addRotationGestures {
    
    rotationGR = [[ UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [ [[CCDirector sharedDirector] openGLView]  addGestureRecognizer:rotationGR];
    [rotationGR release];
    
}


-(void) handleRotation:(UIRotationGestureRecognizer *)recognizer  { 
	

    if ( recognizer.state == UIGestureRecognizerStateBegan ) {
        
        CCLOG(@"begin rotation");
    }
    
     CCLOG(@"rotation is %f", CC_RADIANS_TO_DEGREES(recognizer.rotation) );
    
   
    int rotationInDegrees = CC_RADIANS_TO_DEGREES(recognizer.rotation);
    rotationInDegrees = rotationInDegrees + degreeOffset;
    
   
   joyStickBall.position = ccp( centerOfJoyStick.x - (cos( CC_DEGREES_TO_RADIANS( rotationInDegrees ) ) * length) , centerOfJoyStick.y + (sin( CC_DEGREES_TO_RADIANS( rotationInDegrees ) ) * length) );
    
    //using the line below, the joystick ball would always begin in the same place...
    // joyStickBall.position = ccp( centerOfJoyStick.x - (cos( recognizer.rotation ) * length) , centerOfJoyStick.y + (sin( recognizer.rotation ) * length) );
    
    [self rotateShipByDegree:rotationInDegrees];
    
	
    if ( recognizer.state == UIGestureRecognizerStateEnded ) {
        
        CCLOG(@"ended gesture");
        degreeOffset = rotationInDegrees;
    }
    

}


-(void) removeRotationGestures {
    
    CCLOG(@"rotation off");
    
    [ [[CCDirector sharedDirector]openGLView] removeGestureRecognizer:rotationGR];
    
    
}




-(void) rotateShipByDegree:(int)theDegree {
    
    ship.rotation = theDegree;
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
