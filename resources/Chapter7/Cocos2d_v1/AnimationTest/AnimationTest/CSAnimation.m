//
//  CSAnimation.m
//  AnimationTest
//
//  Created by Justin Dike on 5/24/12.
//  Copyright 2012 cartoonsmart.com. All rights reserved.
//

#import "CSAnimation.h"


@implementation CSAnimation

@synthesize doesTheAnimationLoop, useRandomFrameToLoop, currentFrame, framesBeginAt, useLeadingZeros, leadingZeros, frameRate;


+(id) animateWithBaseName:(NSString*)name andFrames:(int)num {
    
    return [[[self alloc] initWithBaseName:(NSString*)name andFrames:(int)num  ] autorelease];
     
}


-(id) initWithBaseName:(NSString*)name andFrames:(int)num {
    
    if ((self = [super init]))
    {
    
        baseName = name; 
        framesToAnimate = num;
        framesBeginAt = 0;
        currentFrame = 0;
        leadingZeros = 3;
        frameRate = 60;
        stringOfZeros = @"";
        
    }
    return self;
}

-(void) showFirstFrame {
    
    currentFrame = framesBeginAt;
    
    if (useLeadingZeros == NO) {
        sprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@%i.png", baseName, currentFrame]];
    } else {
        
        sprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@%@%i.png", baseName, [self returnZeros],  currentFrame]];
              
    }
    
    [self addChild:sprite];
    
}
-(void) showFirstFrameAndAnimate {
    
    [self showFirstFrame];
    [self animate];
}

-(void) animate {
    
    NSAssert( sprite != nil, @"Not showing first frame");
    [self schedule:@selector(runAnimation:) interval:1.0f / frameRate ];
    
}


-(void) animateFrom:(int)startFrame  {
    
    currentFrame = startFrame -1;
    
    NSAssert( sprite != nil, @"Not showing first frame");
    [self schedule:@selector(runAnimation:) interval:1.0f / frameRate ];
    
}

-(void) runAnimation:(ccTime) delta {
    

    
    currentFrame ++; //adds 1 to currentFrame
    if (currentFrame <= framesToAnimate) {
        
        if (useLeadingZeros == NO) {
        
            [sprite setTexture:[[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@%i.png", baseName, currentFrame]] texture] ]; 
            
        } else {
            
            [sprite setTexture:[[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@%@%i.png", baseName, [self returnZeros], currentFrame]] texture] ]; 
                       
        }
        
        
    }  else {
        
        if ( doesTheAnimationLoop == YES && useRandomFrameToLoop == NO) {
            
            currentFrame = framesBeginAt -1;
            
        } else if ( doesTheAnimationLoop == YES && useRandomFrameToLoop == YES) {
            
            // currentFrame = arc4random() % 10; // you'd get a range of 0 to 9
            
            currentFrame = arc4random() % framesToAnimate; // you'd get a range of 0 to whatever framesToAnimate is
            
        } else {
            
            [self unschedule:_cmd];
            [self removeChild:sprite cleanup:NO];
            [self removeFromParentAndCleanup:NO];
            
           
        }
        
    }
    
}

-(void) pause {
    [self unschedule:@selector(runAnimation:)];
    
}
-(void) resume  {
    [self animate];
    
}

-(NSString*) returnZeros {
    
    if ( leadingZeros == 3 ) {
        
        if ( currentFrame <= 9 ){
            
            stringOfZeros = @"000";
            
        } else if ( currentFrame <= 99 ){
            
            stringOfZeros = @"00";
            
            
        } else {
            
            stringOfZeros = @"0";
        }
        
        
    } 
    else if ( leadingZeros == 2 ) {
        
        if ( currentFrame <= 9 ){
            
            stringOfZeros = @"00";
            
        } else if ( currentFrame <= 99 ){
            
            stringOfZeros = @"0";
            
        } else {
            
            stringOfZeros = @"";
        }
        
        
    }
    else if ( leadingZeros == 1 ) {
        
        if ( currentFrame <= 9 ){
            
            stringOfZeros = @"0";
            
        } else {
            
            stringOfZeros = @"";
        }
        
        
    }
    
    return stringOfZeros; 
    
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    CCLOG(@"self removed");
    
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}


@end
