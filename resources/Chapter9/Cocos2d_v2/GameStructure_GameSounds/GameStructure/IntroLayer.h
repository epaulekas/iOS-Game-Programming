//
//  IntroLayer.h
//  GameStructure
//
//  Created by Justin's Clone on 8/29/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface IntroLayer : CCLayer
{
    
    bool startGameWithMenu;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end