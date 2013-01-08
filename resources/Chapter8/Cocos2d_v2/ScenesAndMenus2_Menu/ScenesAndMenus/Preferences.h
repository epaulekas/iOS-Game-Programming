//
//  Preferences.h
//  ScenesAndMenus
//
//  Created by Justin Dike on 7/24/12.
//  Copyright 2012 cartoonsmart.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Preferences : CCLayer {
    
    CCMenu *menu;
    
    CCMenuItem *muteItem;
    CCMenuItem *musicItem;
    CCMenuItem *arcadeItem;
    CCMenuItem *barItem;
    
    CGPoint menuPosition; 
    
}
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
