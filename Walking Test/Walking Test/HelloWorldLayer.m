//
//  HelloWorldLayer.m
//  Walking Test
//
//  Created by Ezra Paulekas on 1/7/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "Constants.h"
#import "Enemy.h"


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
//        [self initCharacter];
        
        Enemy *theEnemy = [Enemy create];
	}
	return self;
}

- (void) initCharacter  {
    // reset animation phase
    animationCounter = 0;
    
    // size for the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    // add character to screen
    CCSprite* character = [CCSprite spriteWithFile:@"enemy_still.png"];
    [self addChild:character z:kZDepth tag:kTag];
    
    character.position = ccp(size.width/2, size.height/2);
    //    [self schedule:@selector(updateWalk) interval:1.0/60.0 repeat:60 delay:5.0f];
    [self newWalk];
}

- (void) newWalk    {
    [self newCharacterImage:@"enemy_still.png"];

//    [character setTexture:[[CCSprite spriteWithFile:@"enemy_walk1.png"] texture]];
    [self scheduleOnce:@selector(startWalk:) delay:kPauseTime];
}

- (void) startWalk:(ccTime) delta   {
    animationCounter = 0;
    [self newCharacterDirection];
    [self schedule:@selector(updateWalk:) interval:1.0f/60.0f];
}

- (void) updateWalk:(ccTime) delta {
    bool newDir = NO;
    int startDir = walkDirection;
    
    CCSprite* character = (CCSprite*)[self getChildByTag:kTag];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    if(++animationCounter > kWalkTime*60)  {
        [self unschedule:_cmd];
        [self newWalk];
    }
    else if(animationCounter % kAnimationTime == 0) {
        if(animationCounter % (kAnimationTime * 2) == 0) {
            [self newCharacterImage:@"enemy_walk1.png"];
            //[character setTexture:[[CCSprite spriteWithFile:@"enemy_walk1.png"] texture]];
        }
        else    {
            [self newCharacterImage:@"enemy_walk2.png"];
            //[character setTexture:[[CCSprite spriteWithFile:@"enemy_walk2.png"] texture]];
        }
    }
    
    switch (walkDirection) {
        case kRightDirection:
            character.position = ccp(character.position.x + kWalkSpeed, character.position.y);
            break;
        case kUpDirection:
            character.position = ccp(character.position.x, character.position.y + kWalkSpeed);
            break;
        case kLeftDirection:
            character.position = ccp(character.position.x - kWalkSpeed, character.position.y);
            break;
        case kDownDirection:
            character.position = ccp(character.position.x, character.position.y - kWalkSpeed);
            break;
            
        default:
            break;
    }

    if(character.position.x < 0)   {
        character.position = ccp(0, character.position.y);
        newDir = YES;
    }
    else if(character.position.x > size.width)   {
        character.position = ccp(size.width, character.position.y);
        newDir = YES;
    }
    else if(character.position.y < 0)   {
        character.position = ccp(character.position.x, 0);
        newDir = YES;
    }
    else if(character.position.y > size.height)   {
        character.position = ccp(character.position.x, size.height);
        newDir = YES;
    }
    
    if(newDir)  {
        while(startDir == walkDirection)    {
            [self newCharacterDirection];
        }
    }
    
}

- (void) newCharacterImage:(NSString *)fileName    {
    CCSprite* character = (CCSprite*)[self getChildByTag:kTag];
    [character setTexture:[[CCSprite spriteWithFile:fileName] texture]];
}

- (void) newCharacterDirection  {
    CCSprite* character = (CCSprite*)[self getChildByTag:kTag];
    
    walkDirection = arc4random() % 4;
    character.rotation = walkDirection * -90;

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
