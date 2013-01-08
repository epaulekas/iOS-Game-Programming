//
//  HelloWorldLayer.m
//  Particles2
//
//  Created by Justin Dike on 6/20/12.
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
		
        self.isTouchEnabled = YES;
        
        CCLOG(@"adding fire");
        
        
        CCParticleSystem* system = [CCParticleRain node];
        [self addChild:system ];
        //system.position = ccp(500, 400 );
        
        
        CCParticleSystem* system2 = [CCParticleSnow node];
        [self addChild:system2 ];
        //system2.position = ccp(800, 200 );
        
        
            
	}
	return self;
}


-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    
    [self getChildByTag:12345].position = location;
    
}


-(void) addFire {
    
        
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
