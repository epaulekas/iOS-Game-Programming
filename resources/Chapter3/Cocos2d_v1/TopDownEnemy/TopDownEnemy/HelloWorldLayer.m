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
        
		speed = 2; //feel free to increase this to make the enemy go faster
        CGSize size = [ [CCDirector sharedDirector] winSize ];
        screenWidth = size.width;
        screenHeight = size.height;
        
        enemy = [CCSprite spriteWithFile:@"enemy_still.png"]; //default pose
        [self addChild:enemy];
        enemy.position = ccp(  screenWidth / 2  , screenHeight / 2 ); //place in center of screen
        
        [self performSelector:@selector(startEnemyMovement)]; // get this party started...
        
    }
	return self;
}

-(void) startEnemyMovement {
    
    walkCounter = 0; //always reset to 0 before moving
    
    delay = 2.0; //2 second delay unless the enemy bumps into the wall
    
    amountToMoveThisInterval = (arc4random( ) % 100) + 20; //(random range is 0 to 99) PLUS 20 
    
    directionToMove = arc4random( ) % 4; //random range is 0 to 3, directionToMove is later used in the switch statement
    
    [self schedule:@selector( moveEnemy: ) interval:1.0f / 30.0f]; //runs every 1/30th of a second 
    
}

-(void) moveEnemy: (ccTime) delta {
    
    walkCounter ++; 
    
    //if walkCounter is less than the amountToMoveThisInterval AND the returned value from the method is YES, then the enemy walks...
    
    if ( walkCounter < amountToMoveThisInterval && [self isEnemyWithinBounds] == YES  ) { 
        
        //handle the actual positioning...
        
        switch (directionToMove) {
            case directionLeft:
                enemy.rotation = 90; //facing left
                enemy.position = ccp( enemy.position.x - speed, enemy.position.y ); //move left
                break;
            case directionRight:
                enemy.rotation = -90; //facing right
                enemy.position = ccp( enemy.position.x + speed, enemy.position.y ); //move right
                break;
            case directionUp:
                enemy.rotation = 180; //facing up
                enemy.position = ccp( enemy.position.x, enemy.position.y + speed ); //move up
                break;
            case directionDown:
                enemy.rotation = 0; //facing down
                enemy.position = ccp( enemy.position.x, enemy.position.y - speed ); //move down
                break;
        }
        
        // show different frames (textures)
        
        if (walkCounter % 2){  //odd number..
            
            [enemy setTexture:[ [CCSprite spriteWithFile:@"enemy_walk1.png"] texture] ];
            
        } else {
            
            [enemy setTexture:[ [CCSprite spriteWithFile:@"enemy_walk2.png"] texture] ];
        }
        
        
    } else {  // else if moving is done or the enemy went out of bounds...
        
        [self unschedule:_cmd]; //stop schedule
        
        [enemy setTexture:[ [CCSprite spriteWithFile:@"enemy_still.png"] texture] ]; //set back to still pose
        
        [self performSelector:@selector(startEnemyMovement) withObject:nil afterDelay:delay ]; //restart using the delay var
        
    }
    
    
}

-(BOOL) isEnemyWithinBounds {
    
    if ( enemy.position.x > screenWidth ){ //is enemy's x value greater than screenWidth
        
        delay = 0.5;
        enemy.position = ccp( screenWidth, enemy.position.y  );
        return NO ; 
        
    } else if (enemy.position.x < 0) { //is enemy's x value less than 0
        
        delay = 0.5;
        enemy.position = ccp( 0 , enemy.position.y  );
        return NO ; 
        
    }else if (enemy.position.y < 0) { //is enemy's y value less than 0
        
        delay = 0.5;
        enemy.position = ccp( enemy.position.x , 0 );
        return NO ; 
        
    }else if (enemy.position.y > screenHeight) { //is enemy's y value greater than screenHeight
        
        delay = 0.5;
        enemy.position = ccp( enemy.position.x , screenHeight );
        return NO ; 
        
    }else {  //if still within bounds then return YES
        
        return YES; 
        
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
