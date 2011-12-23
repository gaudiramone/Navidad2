//
//  AppDelegate.h
//  Navidad2
//
//  Created by Gaudencio Garcinuño on 23/12/11.
//  Copyright Gaudencio Garcinuño Muñoz 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window_;
	RootViewController	*viewController_;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) RootViewController *viewController;

@end
