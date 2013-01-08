//
//  HelloWorldLayer.m
//  DressUp2
//
//  Created by Justin Dike on 6/14/12.
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
        
        CGSize size = [ [CCDirector sharedDirector] winSize ]; 
        screenWidth = size.width;
        screenHeight = size.height;
		CCSprite* background = [CCSprite spriteWithFile:@"dressup_bg.png"];
        [self addChild:background];
        background.position = ccp( screenWidth/2, screenHeight/2 );
        
        girl1 = [CCSprite spriteWithFile:@"girl1.png"];
        [self addChild:girl1];
        girl1.position = ccp( 390, 390 );
        
        girl2 = [CCSprite spriteWithFile:@"girl2.png"];
        [self addChild:girl2];
        girl2.position = ccp( 685, 400 );
        
        item1 = [CCSprite spriteWithFile:@"item1.png"];
        [self addChild:item1 z:1 tag:tagItem1];
        item1.position = ccp( 100, 650 );
        
        item2 = [CCSprite spriteWithFile:@"item2.png"];
        [self addChild:item2 z:1 tag:tagItem2];
        item2.position = ccp( 100, 500 );
        
        currentItemWasPositioned = YES;

	}
	return self;
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CCLOG(@"began");
    
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    
    for(CCSprite *item in self.children) {
        
        switch ( item.tag ) {
            case tagItem1:
                if ( [self testCollisionUsingPoint:location andSprite:item] && currentItemWasPositioned == YES ) {
                    CCSprite* sticker1 = [CCSprite spriteWithFile:@"item1_sticker.png"];
                    [self addChild:sticker1 ];
                    sticker1.position = ccp( screenWidth/2, screenHeight/2  );
                    
                    currentItem = sticker1;
                    currentItemWasPositioned = NO;
                    
                }
                
                break;
            case tagItem2:
                if ( [self testCollisionUsingPoint:location andSprite:item] && currentItemWasPositioned == YES ) {
                    CCSprite* sticker2 = [CCSprite spriteWithFile:@"item2_sticker.png"];
                    [self addChild:sticker2 ];
                    sticker2.position = ccp( screenWidth/2, screenHeight/2  );
                    
                    currentItem = sticker2;
                    currentItemWasPositioned = NO;
                }
                
                break;
                
        }
        
    }
    
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CCLOG(@"moving");
    
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if ( [self testCollisionUsingPoint:location andSprite:currentItem ] ) {
        
        currentItem.position = location;
        currentItem.color = ccYELLOW;
        
    } 
    
}



-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CCLOG(@"ended");
    
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    
    if ( [self testCollisionUsingPoint:location andSprite:currentItem ] ) {
        
        if ( CGRectIntersectsRect(currentItem.boundingBox, girl1.boundingBox) ){
            [currentItem setColor:ccc3(255, 255, 255)];
            currentItemWasPositioned = YES;
            CCLOG(@"current item on girl1");
        } else if ( CGRectIntersectsRect(currentItem.boundingBox, girl2.boundingBox) ){
            [currentItem setColor:ccc3(255, 255, 255)];
            currentItemWasPositioned = YES;
            CCLOG(@"current item on girl2");
        } else {
            
            currentItem.color = ccRED;
            currentItemWasPositioned = NO;
            CCLOG(@"current item floating in space");
            
        }
        
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
