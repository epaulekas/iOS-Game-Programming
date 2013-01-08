//
//  HelloWorldLayer.m
//  TopDownEnemy
//
//  Created by Justin Dike on 6/12/12.
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


-(id) init {
    
	if( (self=[super init])) {
        
        self.isTouchEnabled = YES;
        
        
        
        CGSize size = [ [CCDirector sharedDirector] winSize ];
        
        square = [CCSprite spriteWithFile:@"circle.png"];
        [self addChild:square];
        square.position = ccp( size.width/ 2, size.height / 2 );
        
        for (int i= 0 ; i < 30 ; i++ ) {
            
            int randomX = arc4random() % (int)size.width;
            int randomY = arc4random() % (int)size.height;
            
            Enemy* theEnemy;
            
            if (i < 15){
                theEnemy = [Enemy createWithLocation:ccp(randomX, randomY) andBaseImage:@"enemy" ];
                [self addChild:theEnemy z:100 ];
            } else {
                
                theEnemy  = [Enemy createWithLocation:ccp(randomX, randomY) andBaseImage:@"wingthing" ]; 
                [self addChild:theEnemy z:-100 ];
            }
            
            
        }
        
        [self schedule:@selector(iterateThroughChildren3:) interval:1.0f/60.0f];
    }
	return self;
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    CCLOG(@"touched HELLOWORLD");
    
}



// TEST COLLISION USING A POINT AND SPRITE

-(void) iterateThroughChildren1:(ccTime) delta {
    
    
    
    for(CCNode *someChild in self.children)
    {
        
        
        if([someChild isKindOfClass:[Enemy class]])
        { 
            
            Enemy* someEnemy = (Enemy*) someChild;
            
            
            if ( [self testCollisionUsingPoint:someEnemy.position andSprite:square] ) {
                
                someEnemy.enemySprite.color = ccRED;
                
            } else {
                
                [someEnemy.enemySprite setColor:ccc3(255, 255, 255)];
            }
            
            
            
        }
        
        
    }
    
    
}


// TEST COLLISION USING TWO RECTS (the Enemy class has a method for returning it's rect ) 

-(void) iterateThroughChildren2:(ccTime) delta {
    
    for(Enemy *someEnemy in self.children)
    {
        
        if([someEnemy isKindOfClass:[Enemy class]])
        { 
            
            CGRect enemyRect = [someEnemy getRect]; 
            
            
            if (CGRectIntersectsRect(square.boundingBox, enemyRect )) {
                
                someEnemy.enemySprite.color = ccRED;
            } else {
                
                [someEnemy.enemySprite setColor:ccc3(255, 255, 255)];
            }
            
        }
        
    } //ends for loop
    
}

// TEST COLLISION USING CIRCULAR AREAS 

-(void) iterateThroughChildren3:(ccTime) delta {
    
    for(Enemy *someEnemy in self.children)
    {
        
        if([someEnemy isKindOfClass:[Enemy class]])
        { 
            
            
            if ( [self collisionWithPoint:someEnemy.position  andRadius: someEnemy.enemySprite.contentSize.width / 2 andPoint: square.position  andRadius: square.contentSize.width / 2]  ) {
                
                someEnemy.enemySprite.color = ccBLUE;
            } else {
                
                [someEnemy.enemySprite setColor:ccc3(255, 255, 255)];
            }
            
        }
        
    } //ends for loop
    
}






-(BOOL) collisionWithPoint:(CGPoint)center1  andRadius:(float)radius1  andPoint:(CGPoint) center2  andRadius:(float) radius2
{
    float a = center2.x - center1.x;
    float b = center2.y - center1.y;
    float c = radius1 + radius2;
    float distanceSqrd = (a * a) + (b * b);
    
    if (distanceSqrd < (c * c) ) {
        return YES;
    } else {
        return NO;
    }
    
    
}



-(bool) testCollisionUsingPoint: (CGPoint) thePoint andSprite:(CCSprite*) theSprite {
    
    if ( thePoint.x > (theSprite.position.x - theSprite.contentSize.width /2 ) && 
        thePoint.x < (theSprite.position.x + theSprite.contentSize.width /2 ) &&
        thePoint.y > (theSprite.position.y - theSprite.contentSize.height /2 ) &&  
        thePoint.y < (theSprite.position.y + theSprite.contentSize.height /2 )) {
        
        return YES; 
        
    } else {
        
        return NO;
        
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

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
