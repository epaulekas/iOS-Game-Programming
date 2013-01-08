//
//  HelloWorldLayer.m
//  AnimationTest
//
//  Created by Justin Dike on 5/24/12.
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
		
        
		smoke = [CSAnimation animateWithBaseName:@"gunsmoke" andFrames:53];
        [self addChild:smoke];
        smoke.position = ccp( 1024/2, 768/2 );
        
        smoke.doesTheAnimationLoop = YES;
        smoke.framesBeginAt = 1;
        smoke.useLeadingZeros = YES;
        smoke.leadingZeros = 3;
        
        [smoke showFirstFrameAndAnimate];
        
        
        [self performSelector:@selector(test) withObject:nil afterDelay:3.0];
        
        
        CSAnimation* walker = [CSAnimation animateWithBaseName:@"walking" andFrames:9];
        [self addChild:walker];
        walker.position = ccp( 1024/2, 768/2 );
        
        walker.doesTheAnimationLoop = YES;
        walker.framesBeginAt = 1;
        walker.frameRate = 60;
        [walker showFirstFrameAndAnimate];
        
        CCJumpBy* jump = [CCJumpBy actionWithDuration:1.0 position:ccp(0,0) height:100 jumps:2];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:jump];
        [walker runAction:repeat];
        
        
	}
	return self;
}

-(void) test {
    
    
    [smoke pause];
    [self performSelector:@selector(test2) withObject:nil afterDelay:3.0];
}

-(void) test2 {
 
    [smoke resume];
    
    
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
