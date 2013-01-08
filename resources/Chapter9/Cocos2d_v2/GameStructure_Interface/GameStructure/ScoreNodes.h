//
//  ScoreNodes.h
//  GameStructure
//
//  Created by Justin's Clone on 9/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ScoreNodes : CCLayer {
 
    int moveSpeed;
    
}

+(id) createWithSpeed:(int)speed ;

@end
