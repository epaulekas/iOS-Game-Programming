//
//  AppData.h
//  GameStructure
//
//  Created by Justin's Clone on 9/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"

@interface AppData : CCNode {
    
    NSUserDefaults* defaults;
    
    int levelsPassed;
	int currentLevel;
	int numberOfLives;
	int currentLivesLeft;
	
    int totalScore;
    int totalLevelsInGame;
    
    int gameStatus;
    bool soundMuted; 

}



+(AppData*) sharedData;






-(int) returnLevel ;
-(void) advanceLevel ;

-(int) returnLives ;
-(void) subtractLife ;

-(void) resetGame ;

-(int) returnTotalScore;
-(void) addToTotalScore:(int)theScore;

-(void) setGameStatus:(int)status;
-(int) returnGameStatus;

-(bool) canYouGoToThisLevel:(int) desiredLevel;
-(void) changeLevelTo:(int)desiredLevel;

-(void) disableSound;
-(void) enableSound;
-(bool) isSoundMuted;




@end
