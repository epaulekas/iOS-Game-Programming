//
//  HelloWorldLayer.m
//  CollisionWithPlane
//
//  Created by Justin's Clone on 10/2/12.
//  Copyright Justin's Clone 2012. All rights reserved.
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
	if( (self=[super init]) ) {
            
        CGSize size = [ [CCDirector sharedDirector] winSize ];
        screenWidth = size.width;
        screenHeight = size.height;
        

		player = [Player create];
        [self addChild:player];
        player.position = ccp( 450, screenHeight );
        
        
        Platform *platform1 = [Platform create];
        [self addChild:platform1];
        platform1.position = ccp( 500, 400 );
        
        Platform *platform2 = [Platform create];
        [self addChild:platform2];
        platform2.position = ccp( 650, 300 );
        
        Platform *platform3 = [Platform create];
        [self addChild:platform3];
        platform3.position = ccp( 800, 340 );
        
        Platform *platform4 = [Platform create];
        [self addChild:platform4];
        platform4.position = ccp( 950, 380 );
        

        
        Platform *platform5 = [Platform create];
        [self addChild:platform5];
        platform5.position = ccp( 90, 300 );
        
        Platform *platform6 = [Platform create];
        [self addChild:platform6];
        platform6.position = ccp( 300, 330 );
        
        
        
        Platform *platform7 = [Platform create];
        [self addChild:platform7];
        platform7.position = ccp( 850, 150 );
        
        Platform *platform8 = [Platform create];
        [self addChild:platform8];
        platform8.position = ccp( 970, 190 );
        
        
        originalSpeed = 2;
        playerSpeed = originalSpeed;
        
        originalGravity = 8;
        playerGravity = originalGravity;

        [self scheduleUpdate];
        
        [self schedule:@selector(jumpPlayer:) interval:4.0f];
	}
	return self;
}


-(void) jumpPlayer:(ccTime)delta {
    
    
    
    CCJumpBy* jump = [CCJumpBy actionWithDuration:1.0f position:ccp(100,0 ) height:200 jumps:1];
   
    [player runAction:jump];
        
   
    
}



-(void) update:(ccTime)delta {
    
    
    if ( player.position.x > screenWidth || player.position.y < 0 ) {
        
       int randomX = arc4random() % (screenWidth /4) ;
        
        player.position = ccp (randomX, screenHeight);
        
    }
    
    
    player.position = ccp( player.position.x + playerSpeed, player.position.y - playerGravity );
    

    
    for (Platform* platform in self.children) {
        
        if ( [ platform isKindOfClass:[Platform class]]) {
            

            CGRect platformRect = CGRectMake( platform.position.x - (platform.sprite.contentSize.width / 2) ,
                                          platform.position.y - (platform.sprite.contentSize.height /2 ),
                                          platform.sprite.contentSize.width,
                                          platform.sprite.contentSize.height);
            
            CGRect playerRect = [self returnPlayerRect];
            
            if ( CGRectIntersectsRect ( platformRect, playerRect ) ) {
                
                if ( platform.position.y > player.position.y - (player.sprite.contentSize.height /2 ) ) {
                    
                    playerSpeed = 0;
                    player.position = ccp(player.position.x - originalSpeed, player.position.y ); //bump back
                    
                     playerRect = [self returnPlayerRect];
                    
                }
                if ( CGRectIntersectsRect ( platformRect, playerRect ) ) {  //if still intersecting
               
                        playerGravity = 0;
            
                        while  ( CGRectIntersectsRect ( platformRect, playerRect ) )
                        {
                            player.position = ccp(player.position.x , player.position.y + 1 );
                            playerRect = [self returnPlayerRect];
                        }
                }
                
            }
            else {
                playerGravity = originalGravity;
                playerSpeed = originalSpeed;
               
            }
            
        }
    }
    
}


- (CGRect) returnPlayerRect {
    
    CGRect playerRect = CGRectMake( player.position.x - (player.sprite.contentSize.width / 2) ,
                                   player.position.y - (player.sprite.contentSize.height /2 ),
                                   player.sprite.contentSize.width,
                                   player.sprite.contentSize.height);
    
    return playerRect;
    
    
}

/*
// this is the code without adjusting the playerSpeed, so the player will walk up platforms

-(void) update:(ccTime)delta {
    
    
    if ( player.position.x > screenWidth || player.position.y < 0 ) {
        
        //int randomX = arc4random() % (screenWidth /4) ;
        
        player.position = ccp (480, screenHeight);
        
    }
    
    
    player.position = ccp( player.position.x + playerSpeed, player.position.y - playerGravity );
    
    
    
    for (Platform* platform in self.children) {
        
        if ( [ platform isKindOfClass:[Platform class]]) {
            
            
            CGRect platformRect = CGRectMake( platform.position.x - (platform.sprite.contentSize.width / 2) ,
                                             platform.position.y - (platform.sprite.contentSize.height /2 ),
                                             platform.sprite.contentSize.width,
                                             platform.sprite.contentSize.height);
            
            CGRect playerRect = [self returnPlayerRect];
            
            if ( CGRectIntersectsRect ( platformRect, playerRect ) ) {
                
                playerGravity = 0;
                    
                    while  ( CGRectIntersectsRect ( platformRect, playerRect ) )
                    {
                        player.position = ccp(player.position.x , player.position.y + 1 );
                        
                        
                        playerRect = [self returnPlayerRect];
                        
                    }
              
                
            }
            else {
                playerGravity = originalGravity;
                playerSpeed = originalSpeed;
                
            }
            
        }
    }
    
}
 */



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	
	[super dealloc];
}


@end
