//
//  HelloWorldLayer.m
//  Actions_RepeatingBackground
//
//  Created by Justin Dike on 6/12/12.
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
        
		
        
        
        CCSprite* background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp( screenWidth / 2 , screenHeight /2);
        [self addChild:background z:-5];
        
        
        
        CCSprite* clouds = [CCSprite spriteWithFile:@"clouds.png" rect:CGRectMake(0, 0, screenWidth* 2, screenHeight )];
        ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};   // to use GL_REPEAT your image size must be a power of two... ( 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048 )
        [clouds.texture setTexParameters:&params];
        clouds.position = ccp( screenWidth , screenHeight /2);
        [self addChild:clouds z:-1]; 
        
        
        CCMoveBy* move = [CCMoveBy actionWithDuration:20.0 position:ccp( screenWidth * -1, 0)];
        CCPlace* place  = [CCPlace actionWithPosition:ccp( screenWidth , screenHeight /2) ];
        CCSequence* cloudSeqence = [CCSequence actions: move, place, nil];
        CCRepeatForever* repeatSequence = [CCRepeatForever actionWithAction:cloudSeqence];
        [clouds runAction:repeatSequence];
        
        
        
        
        CCSprite* clouds2 = [CCSprite spriteWithFile:@"clouds2.png" rect:CGRectMake(0, 0, screenWidth* 2, screenHeight )];
        
        ccTexParams params2 = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT}; // to use GL_REPEAT your image size must be a power of two... ( 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048 )
        [clouds2.texture setTexParameters:&params2];
        clouds2.position = ccp( screenWidth  , screenHeight /2);
        [self addChild:clouds2 z:-3]; 
        
        
        CCMoveBy* move2 = [CCMoveBy actionWithDuration:40.0 position:ccp( screenWidth * -1, 0)];
        CCPlace* place2  = [CCPlace actionWithPosition:ccp(  screenWidth  , screenHeight /2) ];
        CCSequence* cloudSeqence2 = [CCSequence actions: move2, place2, nil];
        CCRepeatForever* repeatSequence2 = [CCRepeatForever actionWithAction:cloudSeqence2];
        [clouds2 runAction:repeatSequence2];
        
        
	}
	return self;
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
