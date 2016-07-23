//
//  AppDelegate.h
//  SV
//
//  Created by patrik on 1/21/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Video.h"

#define APPDELEGATE     ((AppDelegate *)[[UIApplication sharedApplication]delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) Video *videoSelected;


@end

