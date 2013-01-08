//
//  HealthMeter.m
//  GameStructure
//
//  Created by Justin's Clone on 10/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HealthMeter.h"


@implementation HealthMeter


+(id) createWithPercentage:(float)percent  {
    
    return [[[self alloc] initWithPercentage:(float)percent  ] autorelease];
    
}


-(id)  initWithPercentage:(float)percent  {
    
    if ((self = [super init]))
    {
        
       
    
        CCSprite* backing = [CCSprite spriteWithFile:@"health_meter_base.png"];
        [self addChild:backing z:0];
        
        scaleMeter = [CCSprite spriteWithFile:@"health_meter_green.png"];
        [self addChild:scaleMeter z:1];
        
        
        CCSprite* overlay = [CCSprite spriteWithFile:@"health_meter_overlay.png"];
        [self addChild:overlay z:2];
        
        scaleMeter.scaleX = percent;
        scaleMeter.position = ccp(  (-1 * scaleMeter.contentSize.width / 2 )  + ( percent * ( scaleMeter.contentSize.width / 2))  , scaleMeter.position.y  );
        
    }
    return self;
    
}

-(void) adjustPercentage:(float)percent {
    
    
    if ( percent >= 0) {
        
        if (percent < .2){
            
            scaleMeter.color = ccRED;
        }
    
        scaleMeter.scaleX = percent;
        scaleMeter.position = ccp(  (-1 * scaleMeter.contentSize.width / 2 )  + ( percent * ( scaleMeter.contentSize.width / 2))  , scaleMeter.position.y  );
        
    
    }
}


-(void) dealloc {
    
    
    [super dealloc];
}


@end
