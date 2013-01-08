//
//  HelloWorldLayer.m
//  VirtualJoystick2
//
//  Created by Justin Dike on 6/12/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
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
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
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
        [self addChild:ship z:0];
        ship.position = ccp( screenWidth/2 , screenHeight/2 );
        
        [self addRotationGestures];
        
        
        
        // [self performSelector:@selector(removeRotationGestures) withObject:nil afterDelay:3.0f];

	}
	return self;
}


-(void) addRotationGestures {
    
    rotationGR = [[ UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [ [[CCDirector sharedDirector] view ]  addGestureRecognizer:rotationGR];  
    //cocos2d v1 used openGLView instead of just "view"
    [rotationGR release];
    
}

-(void) removeRotationGestures {
    
    CCLOG(@"rotation off");
    
    [ [[CCDirector sharedDirector] view ] removeGestureRecognizer:rotationGR]; 
    //cocos2d v1 used openGLView instead of just "view"

    
    
    
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
    
    
    ship.rotation = rotationInDegrees; //or use the method rotateShipByDegree:
	
    if ( recognizer.state == UIGestureRecognizerStateEnded ) {
        
        CCLOG(@"ended gesture");
        degreeOffset = rotationInDegrees;
    }
    
    
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

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
