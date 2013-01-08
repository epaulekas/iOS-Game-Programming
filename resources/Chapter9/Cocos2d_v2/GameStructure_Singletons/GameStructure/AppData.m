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
        
        
        //use plist file...
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        
        numberOfLives = [[plistData objectForKey:@"LivesAtGameStart"] integerValue];
        currentLivesLeft = numberOfLives;
              
    }
    
    return self;
}


-(bool) isGamePaused {
    
    return gamePaused;
    
}
-(int) returnLevel {
    
    return currentLevel;
    
}
-(void) advanceLevel {
    
    
    levelsPassed = currentLevel;
    [defaults setInteger:levelsPassed forKey:@"levelsPassed"];
    currentLevel ++;
    
    [defaults synchronize]; //optional, but saving a new level passed is probably worth force-saving the defaults
    
}
-(int) returnLives {
    
    return currentLivesLeft;
    
}
-(void) subtractLife {
    
    currentLivesLeft = currentLivesLeft -1;
    if (currentLivesLeft == 0) {
        
        [self resetGame];
    }
    
}
-(void) resetGame {
    
    currentLivesLeft = numberOfLives;
    currentLevel = levelsPassed + 1; //if you're going to just reset the same level, then this really isn't necessary
     
}

@end
