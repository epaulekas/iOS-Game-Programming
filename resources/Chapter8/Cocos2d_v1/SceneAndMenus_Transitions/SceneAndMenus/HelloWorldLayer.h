//
//  HelloWorldLayer.h
//  SceneAndMenus
//
//  Created by Justin Dike on 7/25/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Preferences.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
}

+ (int)count;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
