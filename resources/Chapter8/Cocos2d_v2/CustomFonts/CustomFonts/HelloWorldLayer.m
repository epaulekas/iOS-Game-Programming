//
//  HelloWorldLayer.m
//  CustomFonts
//
//  Created by Justin's Clone on 8/24/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
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
		
        
		
        //the font used below has been modified from the Armor Piercing font available at Blambot.com
        
		scoreLabel = [CCLabelBMFont labelWithString:@"0000" fntFile:@"nuclear_horizon.fnt"];
        scoreLabel.position = ccp( 100, 500);
        [self addChild:scoreLabel];
        scoreLabel.anchorPoint = ccp(-1.0f, 0.5f); //anchors at left edge
        
        CCLabelTTF *desc = [CCLabelTTF labelWithString:@"anchored left"fontName:@"Marker Felt" fontSize:22];
        [self addChild:desc];
        desc.position = ccp( 400, 450);
        
        
        
        //////////  //////////  //////////  //////////
        
        scoreLabel2 = [CCLabelBMFont labelWithString:@"0000" fntFile:@"nuclear_horizon.fnt"];
        scoreLabel2.position = ccp( 400, 300);
        [self addChild:scoreLabel2];
        scoreLabel2.anchorPoint = ccp(.5f, 0.5f); //anchors in middle
        
        CCLabelTTF *desc2 = [CCLabelTTF labelWithString:@"anchored middle"fontName:@"Marker Felt" fontSize:22];
        [self addChild:desc2];
        desc2.position = ccp( 400, 250);
        
          //////////  //////////  //////////  //////////
        
        scoreLabel3 = [CCLabelBMFont labelWithString:@"0000" fntFile:@"nuclear_horizon.fnt"];
        scoreLabel3.position = ccp( 500, 100);
        [self addChild:scoreLabel3];
        scoreLabel3.anchorPoint = ccp(1.0f, 0.5f); //anchors at right edge
        
        CCLabelTTF *desc3 = [CCLabelTTF labelWithString:@"anchored right"fontName:@"Marker Felt" fontSize:22];
        [self addChild:desc3];
         desc3.position = ccp( 400, 50);
        
        
        [self schedule:@selector(updateLabel:) interval:1/60];
        
	}
	return self;
}

-(void) updateLabel:(ccTime)delta {
    
    score = score + 101;
    
    NSString* scoreString = [NSString stringWithFormat:@"%i", score];
    [scoreLabel setString: scoreString];
    
    [scoreLabel2 setString: scoreString];
    
    [scoreLabel3 setString: scoreString];
    
    
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
