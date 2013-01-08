//
//  HelloWorldLayer.h
//  SpriteSheets
//
//  Created by Justin Dike on 5/31/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    
    CCSprite *zombie;
    CCRepeatForever *walk; //the action we can start and stop whenever
    
}


@property (nonatomic, retain) CCRepeatForever *walk;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;



@end
