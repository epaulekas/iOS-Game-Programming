//
//  HelloWorldLayer.h
//  Walking Test
//
//  Created by Ezra Paulekas on 1/7/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


//#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer //<GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    int animationCounter;
    int walkDirection;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
