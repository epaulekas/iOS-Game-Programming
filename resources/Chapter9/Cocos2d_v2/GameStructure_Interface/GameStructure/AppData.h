//
//  AppData.h
//  GameStructure
//
//  Created by Justin's Clone on 9/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AppData : CCNode {
    
    NSUserDefaults* defaults;
    
    int levelsPassed;
	int currentLevel;
	int numberOfLives;
	int currentLivesLeft;
	bool gamePaused;
    
    int totalScore;
    
    int totalLevelsInGame;

}



+(AppData*) sharedData;

-(bool) isGamePaused ;
-(int) returnLevel ;
-(void) advanceLevel ;
-(int) returnLives ;
-(void) subtractLife ;
-(void) resetGame ;
-(int) returnTotalScore;
-(void) addToTotalScore:(int)theScore;

@end
