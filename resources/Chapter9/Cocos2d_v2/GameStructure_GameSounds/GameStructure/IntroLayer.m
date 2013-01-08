//
//  IntroLayer.m
//  GameStructure
//
//  Created by Justin's Clone on 8/29/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "HelloWorldLayer.h"

#import "GameEngine.h"
#import "GameMenu.h"
#import "AppData.h"

#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(void) onEnter
{
	[super onEnter];
    
	CGSize size = [[CCDirector sharedDirector] winSize];
	CCSprite *background = [CCSprite spriteWithFile:@"IntroLayer.png"];
	background.position = ccp(size.width/2, size.height/2);
	[self addChild: background];
	
	[self scheduleOnce:@selector(makeTransition:) delay:2];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    
    startGameWithMenu = [[plistData objectForKey:@"GameOpensWithMenu"] boolValue];
}

-(void) makeTransition:(ccTime)dt
{
    
    if (startGameWithMenu == YES) {
    
        //[[AppData sharedData] setGameStatus:kGameNotInProgress];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[GameMenu scene] withColor:ccWHITE]];
        
    } else {
        
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[GameEngine scene] withColor:ccWHITE]];
    }
}
@end
