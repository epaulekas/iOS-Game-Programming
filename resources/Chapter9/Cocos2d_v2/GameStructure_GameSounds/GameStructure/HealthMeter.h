//
//  HealthMeter.h
//  GameStructure
//
//  Created by Justin's Clone on 10/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HealthMeter : CCNode {
    
  
    
    CCSprite* scaleMeter; 
    
}

+(id) createWithPercentage:(float)percent ;
-(void) adjustPercentage:(float)percent ;

@end
