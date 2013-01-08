//
//  HelloWorldLayer.m
//  Whatever
//
//  Created by Justin Dike on 3/29/12.
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
        
        
        maxDots = 90;
        
        CGSize size = [ [CCDirector sharedDirector] winSize ];
       startingPosition = ccp( 0 , size.height / 2 ); 
        
        [self startAddingDots];
        
	}
	return self;
}


-(void) startAddingDots {
    
    dotCount = 0;
    [self schedule:@selector(addDots:) interval:1.0f / 10.0f ];
}



-(void) addDots:(ccTime) delta {
    
    dotCount ++;
    
    CCSprite* whiteDot = [CCSprite spriteWithFile:@"circle.png"];
    [self addChild:whiteDot z:0 tag:kDotTag + dotCount];
    
    whiteDot.position = ccp( 10 + [self getChildByTag:kDotTag + (dotCount - 1)].position.x , startingPosition.y);
    
    if (dotCount % 2){  //odd number..
        whiteDot.scale = .5;
    }
    
    if (dotCount == maxDots) {
        
        [self unschedule:_cmd];
        [self startRemovingDots];
    }
    
}

-(void) startRemovingDots {
    
    dotCount = 0;
    [self schedule:@selector(removeDots:) interval:1.0f / 10.0f ];
    
}

-(void) removeDots:(ccTime) delta {
    
    dotCount ++;
    
    [self removeChildByTag:kDotTag + dotCount cleanup:NO];    
    
    
    if (dotCount == maxDots) {
        
        [self unschedule:_cmd];
        [self startAddingDots];
    }
    
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
