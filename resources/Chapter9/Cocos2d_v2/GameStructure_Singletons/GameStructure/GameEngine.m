//
//  GameEngine.m
//  GameStructure
//
//  Created by Justin's Clone on 9/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameEngine.h"


@implementation GameEngine


// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameEngine *layer = [GameEngine node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(id) init
{
	if( (self=[super init])) {
        
        lives = [[AppData sharedData] returnLives];
        level = [[AppData sharedData] returnLevel];
        
        CCLOG( @"The lives left is: %i , and the level is %i", lives, level);
        
        [[AppData sharedData] advanceLevel];
             
    }
    
    return self;
}


@end
