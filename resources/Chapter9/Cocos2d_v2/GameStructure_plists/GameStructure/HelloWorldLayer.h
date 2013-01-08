//
//  HelloWorldLayer.h
//  GameStructure
//
//  Created by Justin's Clone on 8/29/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    
    int LevelsPerSection;
    bool SoundEnabled;
    NSString* Difficulty;
    
    CCLabelBMFont* scoreLabelFirst;
    CCLabelBMFont* scoreLabelSecond;
    CCLabelBMFont* scoreLabelThird;
    
    CGPoint scoreBoardPosition;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
