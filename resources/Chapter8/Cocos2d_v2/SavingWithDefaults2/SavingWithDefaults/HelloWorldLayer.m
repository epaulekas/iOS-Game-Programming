//
//  HelloWorldLayer.m
//  SavingWithDefaults
//
//  Created by Justin's Clone on 8/27/12.
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
	if( (self=[super init]) ) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite* background = [CCSprite spriteWithFile:@"background.png"]; 
        background.position = ccp( size.width / 2,  size.height / 2 );
        [self addChild:background];
        
        defaults = [NSUserDefaults standardUserDefaults]; 
		
        scoreBoardFirstPlace = [defaults integerForKey:@"firstPlace"];
        scoreBoardSecondPlace = [defaults integerForKey:@"secondPlace"];
        scoreBoardThirdPlace = [defaults integerForKey:@"thirdPlace"];
        
        scoreBoardPosition = ccp( 210, 680 );
        
    
        [self createScoreBoard];
        [self schedule:@selector(generateRandomHighScores:) interval:1.0f];
        
	}
	return self;
}

-(void) createScoreBoard {
    
    
    //remove scoreLabelFirst (in case we are recreating the score board), then create a new one
    
    [self removeChild:scoreLabelFirst cleanup:NO];

    scoreLabelFirst = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%i", scoreBoardFirstPlace] fntFile:@"green_arcade.fnt"];
    scoreLabelFirst.position = ccp( scoreBoardPosition.x, scoreBoardPosition.y );
    [self addChild:scoreLabelFirst];
    scoreLabelFirst.anchorPoint = ccp(1.0f, 0.5f);
    
    //remove scoreLabelSecond (in case we are recreating the score board), then create a new one
    
    [self removeChild:scoreLabelSecond cleanup:NO];
    
    scoreLabelSecond= [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%i", scoreBoardSecondPlace] fntFile:@"green_arcade.fnt"];
    scoreLabelSecond.position = ccp( scoreBoardPosition.x, scoreBoardPosition.y - 40 );
    [self addChild:scoreLabelSecond];
    scoreLabelSecond.anchorPoint = ccp(1.0f, 0.5f);
    
    //remove scoreLabelThird (in case we are recreating the score board), then create a new one
    
    [self removeChild:scoreLabelThird cleanup:NO];
    
    scoreLabelThird= [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%i", scoreBoardThirdPlace] fntFile:@"green_arcade.fnt"];
    scoreLabelThird.position = ccp( scoreBoardPosition.x, scoreBoardPosition.y - 85 );
    [self addChild:scoreLabelThird];
    scoreLabelThird.anchorPoint = ccp(1.0f, 0.5f);
    
}

-(void) generateRandomHighScores:(ccTime) delta {
    
    
    newScore = arc4random() % 10000;
    
    if (newScore > scoreBoardFirstPlace ) {
        
        scoreBoardThirdPlace = scoreBoardSecondPlace;
        scoreBoardSecondPlace = scoreBoardFirstPlace;
        scoreBoardFirstPlace = newScore;
        
        CCLOG(@"new first place score");
        
        [self saveNewDefaults];
        [self createScoreBoard] ;
        
    } else if (newScore > scoreBoardSecondPlace ) {
        
        scoreBoardThirdPlace = scoreBoardSecondPlace;
        scoreBoardSecondPlace = newScore;
        
        CCLOG(@"new second place score");
        
        [self saveNewDefaults];
        [self createScoreBoard] ;
        
    } else if (newScore > scoreBoardThirdPlace ) {
        
        scoreBoardThirdPlace = newScore;
        
        CCLOG(@"new third place score");
        
        [self saveNewDefaults];
        [self createScoreBoard] ;
        
        
    } else {
        
         CCLOG(@"no new highscores, random score was: %i", newScore);
    }
    
}

-(void) saveNewDefaults {
    
    [defaults setInteger:scoreBoardFirstPlace forKey:@"firstPlace"];
    [defaults setInteger:scoreBoardSecondPlace forKey:@"secondPlace"];
    [defaults setInteger:scoreBoardThirdPlace forKey:@"thirdPlace"];
    
    
    
    [defaults synchronize];
    
    
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
