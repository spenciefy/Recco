//
//  SYAppDelegate.m
//  Recco
//
//  Created by Spencer Yen on 7/10/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SYAppDelegate.h"
#import "SYData.h"

@implementation SYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0.0, 1.0);
    shadow.shadowColor = [UIColor whiteColor];
   
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
        [[UINavigationBar appearance] setTintColor: [UIColor whiteColor]];
    }
    else
    {
        [[UINavigationBar appearance] setBarTintColor: [UIColor whiteColor]];
    }
    
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setTitleTextAttributes:
     @{NSForegroundColorAttributeName: [UIColor colorWithRed:231.0/255.0 green:76.0/255.0 blue:20.0/255.0 alpha:1.0],
       NSShadowAttributeName:shadow,
       NSFontAttributeName:[UIFont fontWithName:@"HanSolo" size:24]
       }
     forState:UIControlStateNormal];
    

    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:231.0/255.0 green:76.0/255.0 blue:60.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"HanSolo" size:37.0], NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:4 forBarMetrics:UIBarMetricsDefault];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
//    SYData *syData = [SYData sharedManager];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:syData.likedMovies];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:data forKey:@"likedMovies"];
//    NSLog(@"EWTQRQETETTTQEQEQEREQQEQEQEQQEEQ");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
//    SYData *syData = [SYData sharedManager];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:syData.likedMovies];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:data forKey:@"likedMovies"];
//    NSLog(@"EWTQRQETETTTQEQEQEREQQEQEQEQQEEQ");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
//    SYData *syData = [SYData sharedManager];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:syData.likedMovies];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:data forKey:@"likedMovies"];
//    NSLog(@"EWTQRQETETTTQEQEQEREQQEQEQEQQEEQ");
}

@end
