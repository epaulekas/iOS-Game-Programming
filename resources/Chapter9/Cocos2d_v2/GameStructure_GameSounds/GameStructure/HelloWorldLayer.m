//
//  HelloWorldLayer.m
//  GameStructure
//
//  Created by Justin's Clone on 8/29/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "AppData.h"

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
        
        
     
        
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        
        
        LevelsPerSection = [[plistData objectForKey:@"LevelsPerSection"] integerValue]; 
        SoundEnabled =  [[plistData objectForKey:@"SoundEnabled"] boolValue];
        Difficulty = [plistData objectForKey:@"Difficulty"];
        
        CCLOG(@"Levels per section is: %i", LevelsPerSection);
        
        if ( SoundEnabled == YES) {
            CCLOG(@"sound is on");
            
        }
         
         CCLOG(@"The Difficulty is: %@", Difficulty);
        
        
        
      
        
     
        
        NSMutableArray* levelArray = [NSMutableArray arrayWithArray:[plistData objectForKey:@"Levels"]];
        NSDictionary *levelDict = [NSDictionary dictionaryWithDictionary:[ levelArray objectAtIndex:currentLevel - 1  ]];
        
        CCLOG(@"Level %i: BackgroundArt File is: %@ ", currentLevel,  [levelDict objectForKey:@"BackgroundArt"]);
        CCLOG(@"Level %i: Sound File is: %@ ", currentLevel,  [levelDict objectForKey:@"Music"]);
        CCLOG(@"Level %i: Gravity is: %i ", currentLevel,  [[levelDict objectForKey:@"Gravity"] integerValue]  );
        
        
        
        
        
        ///SCORES array....
        
        
        NSMutableArray* theScores = [NSMutableArray arrayWithArray:[plistData objectForKey:@"HighScores"]];
        
        CCLOG(@"First Place: %@ ",  [theScores objectAtIndex:0] );
        CCLOG(@"Second Place: %@ ",  [theScores objectAtIndex:1] );
        CCLOG(@"Third Place: %@ ",  [theScores objectAtIndex:2] );
        
        
         ///display the scores....
        
        scoreBoardPosition = ccp( 230, 680 );

        scoreLabelFirst = [CCLabelBMFont labelWithString:[theScores objectAtIndex:0] fntFile:@"green_arcade.fnt"];
        scoreLabelFirst.position = ccp( scoreBoardPosition.x, scoreBoardPosition.y );
        [self addChild:scoreLabelFirst];
        scoreLabelFirst.anchorPoint = ccp(1.0f, 0.5f);
        
        scoreLabelSecond= [CCLabelBMFont labelWithString:[theScores objectAtIndex:1] fntFile:@"green_arcade.fnt"];
        scoreLabelSecond.position = ccp( scoreBoardPosition.x, scoreBoardPosition.y - 40 );
        [self addChild:scoreLabelSecond];
        scoreLabelSecond.anchorPoint = ccp(1.0f, 0.5f);
        
        scoreLabelThird= [CCLabelBMFont labelWithString:[theScores objectAtIndex:2] fntFile:@"green_arcade.fnt"];
        scoreLabelThird.position = ccp( scoreBoardPosition.x, scoreBoardPosition.y - 85 );
        [self addChild:scoreLabelThird];
        scoreLabelThird.anchorPoint = ccp(1.0f, 0.5f);
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite* background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp( size.width / 2,  size.height / 2 );
        [self addChild:background z:-1];
        
      

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
