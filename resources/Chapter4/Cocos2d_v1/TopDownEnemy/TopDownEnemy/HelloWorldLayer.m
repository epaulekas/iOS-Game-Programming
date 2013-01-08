//
//  HelloWorldLayer.m
//  TopDownEnemy
//
//  Created by Justin Dike on 4/11/12.
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


-(id) init {
    
	if( (self=[super init])) {
        
        CGSize size = [ [CCDirector sharedDirector] winSize ];
       
        for (int i= 0 ; i < 20 ; i++ ) {
        
            int randomX = arc4random() % (int)size.width;
            int randomY = arc4random() % (int)size.height;
            
            Enemy* theEnemy;
            
            if (i < 10){
                theEnemy = [Enemy createWithLocation:ccp(randomX, randomY) andBaseImage:@"enemy" ];
            } else {
                
                theEnemy  = [Enemy createWithLocation:ccp(randomX, randomY) andBaseImage:@"wingthing" ]; 
            }
            
            [self addChild:theEnemy ];
        
        }
        
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
