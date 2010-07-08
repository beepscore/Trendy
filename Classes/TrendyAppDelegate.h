//
//  TrendyAppDelegate.h
//  Trendy
//
//  Created by Steve Baker on 2/25/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrendyViewController;

@interface TrendyAppDelegate : NSObject <UIApplicationDelegate> {
    // Xcode automatically adds instance variables to back properties
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TrendyViewController *viewController;

@end

