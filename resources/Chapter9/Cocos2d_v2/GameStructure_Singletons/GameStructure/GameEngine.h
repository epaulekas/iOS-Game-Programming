//
//  GameEngine.h
//  GameStructure
//
//  Created by Justin's Clone on 9/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "AppData.h"

@interface GameEngine : CCLayer {
    
    int lives;
    int level;
    
}

+(CCScene *) scene;

@end
