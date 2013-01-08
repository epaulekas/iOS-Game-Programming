//
//  Enemy.m
//  TopDownEnemy
//
//  Created by Justin Dike on 4/13/12.
//  Copyright 2012 cartoonsmart.com. All rights reserved.
//

#import "Enemy.h"


@implementation Enemy


@synthesize  canBeDamaged, enemySprite;

+(id) createWithLocation:(CGPoint)thePoint andBaseImage:(NSString*)theBaseImage {
    
   
        return [[[self alloc] initWithLocation:thePoint andBaseImage:theBaseImage ] autorelease];
        
    
}


-(id) initWithLocation:(CGPoint)thePoint andBaseImage:(NSString*)theBaseImage{
    
    if ((self = [super init]))
    {
        
       
        
        baseImage = theBaseImage;
        self.position = thePoint; 
        
        speed = 4;
        CGSize size = [ [CCDirector sharedDirector] winSize ];
        screenWidth = size.width;
        screenHeight = size.height;
        
        
        enemySprite = [CCSprite spriteWithFile: [NSString stringWithFormat:@"%@_still.png", baseImage ]];  //default pose
        
        
        [self addChild:enemySprite];
        
        
        
        
        
        [self performSelector:@selector(startMovement)]; // get this party started...
        
        CCLOG(@"enemy created");    
          
    }
    return self;
    
}



-(void) startMovement {
    
    
    
    
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
                enemySprite.rotation = 90; //facing left
                self.position = ccp( self.position.x - speed, self.position.y ); //move left
                break;
            case directionRight:
                enemySprite.rotation = -90; //facing right
                self.position = ccp( self.position.x + speed, self.position.y ); //move right
                break;
            case directionUp:
                enemySprite.rotation = 180; //facing up
                self.position = ccp( self.position.x, self.position.y + speed ); //move up
                break;
            case directionDown:
                enemySprite.rotation = 0; //facing down
                self.position = ccp( self.position.x, self.position.y - speed ); //move down
                break;
        }
        
        // show different frames (textures)
        
        if (walkCounter % 2){  //odd number..
            
            [enemySprite setTexture:[ [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@_walk1.png", baseImage]] texture] ];
            
        } else {
            
            [enemySprite setTexture:[ [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@_walk2.png", baseImage]] texture] ];
        }
        
        
    } else {  // else if moving is done or the enemy went out of bounds...
        
        [self unschedule:_cmd]; //stop schedule
        
        [enemySprite setTexture:[ [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@_still.png", baseImage]] texture] ]; //set back to still pose
        
        [self performSelector:@selector(startMovement) withObject:nil afterDelay:delay ]; //restart using the delay var
        
    }
    
    
}

-(CGRect) getRect
{
    
    return CGRectMake( self.position.x - (enemySprite.contentSize.width /2) ,
                       self.position.y - (enemySprite.contentSize.height /2),
                       enemySprite.contentSize.width, 
                       enemySprite.contentSize.height );
}



-(BOOL) isEnemyWithinBounds {
    
    if ( self.position.x > screenWidth ){ //is enemy's x value greater than screenWidth
        
        delay = 0.5;
        self.position = ccp( screenWidth, self.position.y  );
        return NO ; 
        
    } else if (self.position.x < 0) { //is enemy's x value less than 0
        
        delay = 0.5;
        self.position = ccp( 0 , self.position.y  );
        return NO ; 
        
    }else if (self.position.y < 0) { //is enemy's y value less than 0
        
        delay = 0.5;
        self.position = ccp( self.position.x , 0 );
        return NO ; 
        
    }else if (self.position.y > screenHeight) { //is enemy's y value greater than screenHeight
        
        delay = 0.5;
        self.position = ccp( self.position.x , screenHeight );
        return NO ; 
        
    }else {  //if still within bounds then return YES
        
        return YES; 
        
    }
    
}

-(void) tellMe {
    
    CCLOG(@"canBeDamaged is %i", canBeDamaged);
}


-(void) walkAround{
    CCLOG(@"walk around");
    
}
-(void) setSpeedToLow{
    CCLOG(@"low speed");
    
}
-(void) tintRedToShowFuriousAnger{
    CCLOG(@"sunburned Hulk mode");
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
