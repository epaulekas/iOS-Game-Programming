//
//  HelloWorldLayer.h
//  WhiteDots2
//
//  Created by Justin Dike on 6/18/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "Constants.h"

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    
    
    
    CGPoint startingPosition;
    int dotCount;
    int maxDots;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
