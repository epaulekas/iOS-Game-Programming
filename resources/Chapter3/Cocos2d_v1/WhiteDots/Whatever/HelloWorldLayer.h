//
//  HelloWorldLayer.h
//  Whatever
//
//  Created by Justin Dike on 3/29/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Constants.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    

    
    CGPoint startingPosition;
    int dotCount;
    int maxDots;

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;



@end
