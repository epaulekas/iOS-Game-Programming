//
//  HelloWorldLayer.h
//  DressUp
//
//  Created by Justin Dike on 4/27/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Constants.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    int screenWidth;
    int screenHeight;
    CCSprite* girl1;
    CCSprite* girl2;
    CCSprite* item1;
    CCSprite* item2;
    CCSprite* currentItem;
    bool currentItemWasPositioned;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
