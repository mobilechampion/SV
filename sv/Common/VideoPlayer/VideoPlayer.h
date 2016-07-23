//
//  VideoPlayer.h
//  SV
//
//  Created by BaoAnh on 2/20/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "RMYouTubeExtractor.h"
#import "Video.h"

#define VIDEO_PLAYER        [VideoPlayer sharedInstant]

@class VideoPlayer;
@protocol VideoPlayerDelegate <NSObject>

- (void) videoPlayer:(VideoPlayer *)videoPlayer playBackFinish:(NSNotification *) notification;
- (void) videoPlayer:(VideoPlayer *)videoPlayer totalDuration:(float) totalDuration;
- (void) videoPlayer:(VideoPlayer *)videoPlayer currentDuration:(float) currDuration;

@end

@interface VideoPlayer : NSObject<AVAudioSessionDelegate>{
    AVPlayer *player;
    AVPlayerItem *playerItem;
    NSArray *videoArray;
    NSURL *videoUrl;
    NSTimer *timer;
    NSMutableArray *listVideosPlayed;
    BOOL autoResume;
}

@property (nonatomic)BOOL isPlaying;
@property (nonatomic, strong) id <VideoPlayerDelegate> delegate;

+ (id)sharedInstant;
- (void)allowPlayback;
- (void)setUrl:(NSURL *)url;
- (void)playVideo;
- (void)seekToSecond:(float)seekSecond;
- (void)pauseVideo;
- (void)enableTracks:(BOOL)isEnable;
- (BOOL)getAutoResume;
- (void)setAutoResume:(BOOL)_autoResume;

@end
