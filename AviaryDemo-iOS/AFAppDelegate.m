//
//  AFAppDelegate.m
//  AviaryDemo-iOS
//
//  Created by Michael Vitrano on 1/23/13.
//  Copyright (c) 2013 Aviary. All rights reserved.
//

#import "AFAppDelegate.h"

#import "Common.h"
#import "AFSDKDemoViewController.h"

@implementation AFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];

    UIViewController * viewController;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        viewController = [[AFSDKDemoViewController alloc] initWithNibName:@"AFSDKDemoViewController_iPhone" bundle:nil];
    }else{
        viewController = [[AFSDKDemoViewController alloc] initWithNibName:@"AFSDKDemoViewController_iPad" bundle:nil];
    }
    
    //NSLog(@"%f",self.window.frame.size.height);
    //viewController.view.frame = self.window.frame;
    
    // Google Analytics ver3.08
	[GAI sharedInstance].trackUncaughtExceptions = YES;
	[GAI sharedInstance].dispatchInterval = 20;
	//[[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
	[[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelNone];
    
    //////////////////////////////////////////////
	// Initialize tracker.
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-39928115-2"];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if (![ud boolForKey:@"DOWN_LOAD"]) {
        [tracker set:kGAIScreenName value:@"Download"];
        [tracker send:[[GAIDictionaryBuilder createAppView] build]];
        [ud setBool:YES forKey:@"DOWN_LOAD"];
    }
    //////////////////////////////////////////////
	
    
    // Banner
    [ImobileSdkAds registerWithPublisherID:PUBLISHER_ID
                                   MediaID:MEDIA_ID
                                    SpotID:SPOT_ID];
    [ImobileSdkAds startBySpotID:SPOT_ID];
    
    // Wall
    [ImobileSdkAds registerWithPublisherID:PUBLISHER_ID_WALL
                                   MediaID:MEDIA_ID_WALL
                                    SpotID:SPOT_ID_WALL];
    [ImobileSdkAds startBySpotID:SPOT_ID_WALL];
    
    // インタースティシャル
    [ImobileSdkAds registerWithPublisherID:PUBLISHER_ID_INT
                                   MediaID:MEDIA_ID_INT
                                    SpotID:SPOT_ID_INT];
    [ImobileSdkAds startBySpotID:SPOT_ID_INT];
    
    // アイコン
    [ImobileSdkAds registerWithPublisherID:PUBLISHER_ID_INT
                                   MediaID:MEDIA_ID_INT
                                    SpotID:SPOT_ID_ICON];
    [ImobileSdkAds startBySpotID:SPOT_ID_ICON];

    //
    
    [self setViewController:viewController];
    [[self window] setRootViewController:[self viewController]];
    [[self window] makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // Save Data
    //NSNotification *info = [NSNotification notificationWithName:@"SAVE" object:self];
    //[[NSNotificationCenter defaultCenter] postNotification:info];
    
    [Data saveUserData];
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
}

@end
