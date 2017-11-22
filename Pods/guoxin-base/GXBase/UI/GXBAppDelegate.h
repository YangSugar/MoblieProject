//
//  GXBAppDelegate.h
//  GXBaseExample
//
//  Created by Vision on 2017/4/13.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface GXBAppDelegate : UIResponder <
    UIApplicationDelegate
>

@property (strong, nonatomic) UIWindow *window;

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler;

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler;

@end
