//
//  AppDelegate.h
//  Actions_RepeatingBackground
//
//  Created by Justin Dike on 6/12/12.
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
