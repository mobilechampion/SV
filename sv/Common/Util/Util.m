//
//  Util.m
//  SV
//
//  Created by BaoAnh on 2/23/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import "Util.h"
#import "AudioPlayer.h"
#import "VideoPlayer.h"

static Util *_util;

@implementation Util

+ (id)sharedInstant{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _util = [[Util alloc]init];
    });
    return _util;
}

-(NSString *)getDisplayTimeFromSecond:(float)numberOfSeconds
{
    int seconds = (int)numberOfSeconds % 60;
    int minutes = (int)(numberOfSeconds / 60) % 60;
    int hours = numberOfSeconds / 3600;
    
    if (hours) {
        return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    }else{
        return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    }
}

- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 7);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (NSString *)thumbNameFromVideoName:(NSString *)videoName{
    if (!thumbNames) {
        thumbNames = [[NSMutableArray alloc]initWithObjects:
                      @"andragogika",
                      @"ariadnina nit",
                      @"audi alteram partem",
                      @"cesta vzostupu",
                      @"cudo",
                      @"cui bono",
                      @"informacna vojna",
                      @"madar",
                      @"na panske",
                      @"nalejme si cisteho vina",
                      @"nenasilny antiterorista",
                      @"naj z tyzdna",
                      @"o slobode v slobodnom radiu",
                      @"okno do duse",
                      @"opony",
                      @"piatok 13",
                      @"regiony",
                      @"rodna cesta",
                      @"spiritualny kapital",
                      @"v prvej linii",
                      @"dobra hudba",
                      @"historia na dlani",
                      @"kopky snov",
                      @"magyar adas",
                      @"bez cenzury",
                      @"universal"
                      , nil];
    }
    for (NSString *thumbName in thumbNames) {
        if ([videoName rangeOfString:@"magyar adas"].length > 0) {
            int a = 0;
            a = 1;
        }
        if ([videoName rangeOfString:thumbName].location == 0 &&
            [videoName rangeOfString:thumbName].length > 0) {
            return thumbName;
        }
    }
    return @"universal";
}

- (void)setStopTimeAudio:(NSNumber *)time{
    [[NSUserDefaults standardUserDefaults]setObject:time forKey:KEY_STOP_TIME_AUDIO];
    [timer invalidate];
    timer = nil;
    if ([time floatValue] > 0.0) {
        NSLog(@"start timer with %f seconds", [time floatValue]);
        timer = [NSTimer scheduledTimerWithTimeInterval:[time floatValue] target:self selector:@selector(stopStreaming:) userInfo:nil repeats:NO];
    }
}
- (void)stopStreaming:(NSTimer *)_timer{
    NSLog(@"stopStreaming");
    [AUDIO_PLAYER stop];
    [VIDEO_PLAYER pauseVideo];
}
- (NSNumber *)getStopTimeAudio{
    return [[NSUserDefaults standardUserDefaults]objectForKey:KEY_STOP_TIME_AUDIO];
}

@end
