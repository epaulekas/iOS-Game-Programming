//
//  HelloWorldLayer.h
//  CustomFonts
//
//  Created by Justin's Clone on 8/24/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CCLabelBMFont* scoreLabel;
    CCLabelBMFont* scoreLabel2;
    CCLabelBMFont* scoreLabel3;
    int score;

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
