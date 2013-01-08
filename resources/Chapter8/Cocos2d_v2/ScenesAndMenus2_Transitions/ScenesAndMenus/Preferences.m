//
//  Preferences.m
//  ScenesAndMenus
//
//  Created by Justin Dike on 7/24/12.
//  Copyright 2012 cartoonsmart.com. All rights reserved.
//

#import "Preferences.h"


@implementation Preferences

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Preferences *layer = [Preferences node];
	
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
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *background = [CCSprite spriteWithFile:@"Preferences.png"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild: background];
        
        self.isTouchEnabled = YES;
        
	}
	return self;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if ( location.x > 950 && location.y > 700) {
        
        [[CCDirector sharedDirector] popScene];
        
    }
    
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    
    CCLOG(@"removing preferences instance");
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

        
@end
