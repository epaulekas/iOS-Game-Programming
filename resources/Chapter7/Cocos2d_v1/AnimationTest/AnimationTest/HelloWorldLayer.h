//
//  HelloWorldLayer.h
//  AnimationTest
//
//  Created by Justin Dike on 5/24/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CSAnimation.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    
    CSAnimation* smoke;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
