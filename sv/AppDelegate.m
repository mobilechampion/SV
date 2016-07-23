//
//  AppDelegate.m
//  SV
//
//  Created by patrik on 1/21/15.
//  Copyright (c) 2015 patrik. All rights reserved.
// fixed incoming calls

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "VideoPlayer.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configPageControl];
    [VIDEO_PLAYER allowPlayback];
    return YES;
}

- (void)setVideoSelected:(Video *)videoSelected{
    _videoSelected = videoSelected;
}
- (void)configPageControl{
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    
    NSLog(@"applicationWillResignActive");
//    if ([VIDEO_PLAYER isPlaying]) {
//        [VIDEO_PLAYER setAutoResume:YES];
//    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
    [VIDEO_PLAYER enableTracks:NO];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
    [VIDEO_PLAYER enableTracks:YES];
//    if ([VIDEO_PLAYER getAutoResume]) {
//        [VIDEO_PLAYER playVideo];
//        [VIDEO_PLAYER setAutoResume:NO];
//    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"applicationWillTerminate");
}

@end
