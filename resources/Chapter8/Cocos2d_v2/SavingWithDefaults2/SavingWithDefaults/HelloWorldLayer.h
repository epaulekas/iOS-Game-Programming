//
//  HelloWorldLayer.h
//  SavingWithDefaults
//
//  Created by Justin's Clone on 8/27/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    
    NSUserDefaults* defaults;
    
    int scoreBoardFirstPlace;
    int scoreBoardSecondPlace;
    int scoreBoardThirdPlace;
    
    CCLabelBMFont* scoreLabelFirst;
    CCLabelBMFont* scoreLabelSecond;
    CCLabelBMFont* scoreLabelThird;
    
    CGPoint scoreBoardPosition;
    
    int newScore;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
