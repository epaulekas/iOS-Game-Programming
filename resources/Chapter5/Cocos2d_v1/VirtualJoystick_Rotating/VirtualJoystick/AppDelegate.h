//
//  AppDelegate.h
//  VirtualJoystick
//
//  Created by Justin Dike on 5/1/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
