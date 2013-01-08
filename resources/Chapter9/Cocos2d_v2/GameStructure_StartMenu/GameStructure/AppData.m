//
//  AppData.m
//  GameStructure
//
//  Created by Justin's Clone on 9/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AppData.h"


@implementation AppData




static AppData *sharedData = nil;

+(AppData*) sharedData {
    
    if (sharedData == nil) {
        sharedData = [[AppData alloc] init] ;
        
    }
    return  sharedData;
    
}


-(id) init
{
	if( (self=[super init])) {
        
        sharedData = self;
        
        defaults = [NSUserDefaults standardUserDefaults]; 
        
        levelsPassed = [defaults integerForKey:@"levelsPassed"];
        
        currentLevel = levelsPassed + 1;
        //if 0, then currentLevel will be 1
        //if the first level is passed, then currentLevel will be 2
        
        
        gameStatus = kGameNotInProgress; 
        
        
        //use plist file...
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        
        numberOfLives = [[plistData objectForKey:@"LivesAtGameStart"] integerValue];
        currentLivesLeft = numberOfLives;
        
        NSMutableArray* levelArray = [NSMutableArray arrayWithArray:[plistData objectForKey:@"Levels"]];
        totalLevelsInGame = [levelArray count];
        
        CCLOG(@"total levels in game is %i", totalLevelsInGame);
   
    }
    
    return self;
}



-(int) returnLevel {
    
    return currentLevel;
    
}



-(void) advanceLevel {
    
    
    levelsPassed = currentLevel;
    [defaults setInteger:levelsPassed forKey:@"levelsPassed"];
    currentLevel ++;
    [defaults synchronize]; //optional, but saving a new level passed is probably worth force-saving the defaults
    
    if (currentLevel > totalLevelsInGame){
        
        [self resetGame];
    }

}
-(int) returnLives {
    
    return currentLivesLeft;
    
}
-(void) subtractLife {
    
    currentLivesLeft = currentLivesLeft -1;
    
    /*
    
    if (currentLivesLeft == 0) {
        
        [self resetGame];
    }
     */
    
}
-(void) resetGame {
    
    currentLivesLeft = numberOfLives;
    // currentLevel = levelsPassed + 1; //or send people back to the last level passed
    currentLevel = 1;   //or send people back to level 1
    totalScore = 0; 
     
}

-(void) addToTotalScore:(int)theScore {
    
    totalScore = totalScore + theScore;
    
}

-(int) returnTotalScore {
    
    return totalScore;
}

-(void) changeLevelTo:(int)desiredLevel {
    
    currentLevel = desiredLevel;
    
}

-(bool) canYouGoToThisLevel:(int) desiredLevel {
    
    
    if ( (levelsPassed +1) >= desiredLevel ) {
        
        return  YES;
    }
    else {
        
        
        return  NO;
        
    }
    
}


-(void) setGameStatus:(int)status {
    
    gameStatus = status;
    
}
-(int) returnGameStatus {
    
    return gameStatus;
}



-(void) disableSound {
    
    soundMuted = YES;
    
}
-(void) enableSound{
    
    soundMuted = NO;
    
}
-(bool) isSoundMuted{
    
    return  soundMuted;
}




@end
