//
//  Enemy.h
//  Walking Test
//
//  Created by Ezra Paulekas on 1/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Enemy : CCNode {
    CCSprite* enemySprite;
    NSString* baseImage;
    NSString* stillImage;
}

+(id) create;
+(id) createAtPosition: (CGPoint) thePoint;
-(id) initiAtPosition: (CGPoint) thePoint;
-(void) walkAround;
-(void) setSpeedToLow;
-(void) tintRedToShowFuriousAnger;

@end
