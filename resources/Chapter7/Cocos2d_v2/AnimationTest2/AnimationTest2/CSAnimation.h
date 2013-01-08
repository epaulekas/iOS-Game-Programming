//
//  CSAnimation.h
//  AnimationTest2
//
//  Created by Justin Dike on 6/12/12.
//  Copyright 2012 cartoonsmart.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CSAnimation : CCSprite {
    
    NSString *baseName;
    NSString *stringOfZeros;
    int framesToAnimate;
    CCSprite *sprite;
    
    int frameRate;
    int framesBeginAt;
    int currentFrame;
    int leadingZeros;
    bool doesTheAnimationLoop;
    bool useRandomFrameToLoop;
    bool useLeadingZeros;
    
}

@property (nonatomic, readwrite) bool doesTheAnimationLoop;
@property (nonatomic, readwrite) bool useRandomFrameToLoop;
@property (nonatomic, readwrite) bool useLeadingZeros;
@property (nonatomic, readwrite) int framesBeginAt;
@property (nonatomic, readwrite) int currentFrame;
@property (nonatomic, readwrite) int leadingZeros;
@property (nonatomic, readwrite) int frameRate;

+(id) animateWithBaseName:(NSString*)name andFrames:(int)num; 
-(void) showFirstFrame;
-(void) showFirstFrameAndAnimate;
-(void) animate;
-(void) animateFrom:(int)startFrame;
-(void) pause;
-(void) resume; 

@end
