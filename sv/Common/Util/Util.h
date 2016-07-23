//
//  Util.h
//  SV
//
//  Created by BaoAnh on 2/23/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UTIL        [Util sharedInstant]
#define KEY_STOP_TIME_AUDIO     @"KEY_STOP_TIME_AUDIO"
#define RGB(r, g, b) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0]


@interface Util : NSObject{
    NSMutableArray *thumbNames;
    NSTimer *timer;
}

+ (id) sharedInstant;
- (NSString *)getDisplayTimeFromSecond:(float)second;
- (UIImage *)imageFromColor:(UIColor *)color;
- (NSString *)thumbNameFromVideoName:(NSString *)videoName;

- (void)setStopTimeAudio:(NSNumber *)time;
- (NSNumber *)getStopTimeAudio;

@end
