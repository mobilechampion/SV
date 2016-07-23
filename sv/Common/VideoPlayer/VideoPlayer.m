//
//  VideoPlayer.m
//  SV
//
//  Created by BaoAnh on 2/20/15.
//  Copyright (c) 2015 patrik. All rights reserved.
// fixed

#import "VideoPlayer.h"
#import "AudioPlayer.h"

static VideoPlayer *_videoPlayer;

@implementation VideoPlayer

+ (id)sharedInstant{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _videoPlayer = [[VideoPlayer alloc]init];
    });
    return _videoPlayer;
}
- (void)allowPlayback{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    NSError *setCategoryError = nil;
    BOOL success = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];

    if (!success) { /* handle the error condition */}
    
    NSError *activationError = nil;
    success = [audioSession setActive:YES error:&activationError];
    if (!success) { /* handle the error condition */ }
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector:    @selector(handleInterruption:)
                                                 name:        AVAudioSessionInterruptionNotification
                                               object:      [AVAudioSession sharedInstance]];
}
- (void)setUrl:(NSURL *)url{
    if (url && url.absoluteString.length > 0 && ![url.absoluteString isEqualToString:videoUrl.absoluteString]) {
        videoUrl = url;
        videoArray = [[NSArray alloc]init];
        if (player) {
            [self removeObserverForPlayer];
        }
        player = nil;
    }
}
- (void)playVideo{
    _isPlaying = YES;
    [AUDIO_PLAYER stop];
    if (videoArray.count == 0) {
        [self extractVideo:videoUrl];
    }else{
        [self play];
    }
}

- (void)seekToSecond:(float)seekSecond{
    [player seekToTime:CMTimeMake(seekSecond, 1)];
}
- (void)play{
    if (videoArray.count > 0) {
        if (!player) {
            playerItem = [[AVPlayerItem alloc]initWithURL:[self getLowestQuality]];
            player = [[AVPlayer alloc]initWithPlayerItem:playerItem];
            [self addObserverForPlayer];
        }else{
            [self startPlay];
        }
    }
}
- (void)startPlay{
    [player play];
    [self startTimer];
}
- (void)addObserverForPlayer{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:player.currentItem];
    [player addObserver:self forKeyPath:@"status" options:0 context:nil];
    
}
- (void)handleInterruption:(NSNotification *)notification{
    NSDictionary *interuptionDict = notification.userInfo;
    // get the AVAudioSessionInterruptionTypeKey enum from the dictionary
    NSInteger interuptionType = [[interuptionDict     valueForKey:AVAudioSessionInterruptionTypeKey] integerValue];
    NSNumber* seccondReason = [[notification userInfo] objectForKey:@"AVAudioSessionInterruptionOptionKey"] ;
    // decide what to do based on interruption type here...
    switch (interuptionType) {
        case AVAudioSessionInterruptionTypeBegan:
            NSLog(@"Interruption started");
            if ([self isPlaying]) {
                [self setAutoResume:YES];
            }
            break;
            
        case AVAudioSessionInterruptionTypeEnded:
            NSLog(@"Interruption ended");
            break;
            
    }
    switch ([seccondReason integerValue]) {
        case AVAudioSessionInterruptionOptionShouldResume:
            NSLog(@"Resume Audio");
            if ([self getAutoResume]) {
                [self playVideo];
                [self setAutoResume:NO];
            }
            break;
        default:
            break;
    }
}




//

- (void)removeObserverForPlayer{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:player.currentItem];
    [player removeObserver:self forKeyPath:@"status" context:nil];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == player && [keyPath isEqualToString:@"status"]) {
        if (player.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
        } else if (player.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            [_delegate videoPlayer:self totalDuration:CMTimeGetSeconds([player.currentItem.asset duration])];
            [self startPlay];
        } else if (player.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
        }
    }
}
- (void) startTimer{
    [self stopTimer];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
}
- (void) stopTimer{
    [timer invalidate];
    timer = nil;
}
- (void) updateTime:(NSTimer *)timer{
    [_delegate videoPlayer:self currentDuration:CMTimeGetSeconds(player.currentTime)];
}
- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
}
- (NSURL *)getLowestQuality{
    for (NSDictionary *dict in videoArray) {
        NSNumber *quality = dict[@"quality"];
        if ([quality longValue] == RMYouTubeExtractorVideoQualitySmall240) {
            return dict[@"url"];
        }
    }
    for (NSDictionary *dict in videoArray) {
        NSNumber *quality = dict[@"quality"];
        if ([quality longValue] == RMYouTubeExtractorVideoQualityMedium360) {
            return dict[@"url"];
        }
    }
    for (NSDictionary *dict in videoArray) {
        NSNumber *quality = dict[@"quality"];
        if ([quality longValue] == RMYouTubeExtractorVideoQualityHD720) {
            return dict[@"url"];
        }
    }
    return nil;
}
- (void)extractVideo:(NSURL*)url{
    [[RMYouTubeExtractor sharedInstance] extractVideoForIdentifier:[self getYoutubeKey:url]
                                                        completion:^(NSDictionary *videoDictionary, NSError *error) {
                                                            if (!error) {
                                                                NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[[videoDictionary allKeys] count]];
                                                                for (NSString *key in videoDictionary) {
                                                                    if (videoDictionary[key] != [NSNull null]) {
                                                                        [mutableArray addObject:@{ @"quality" : key, @"url" : videoDictionary[key] }];
                                                                    }
                                                                }
                                                                videoArray = [mutableArray copy];
                                                                [self play];
                                                            } else {
                                                                NSLog(@"Extract error:%@", [error localizedFailureReason]);
                                                                [_delegate videoPlayer:self playBackFinish:nil];
                                                            }
                                                        }];
}
- (NSString *)getYoutubeKey:(NSURL *)url{
    NSString *videoKey = @"";
    if (url && url.absoluteString.length > 0 && [url.absoluteString rangeOfString:@"?v="].length > 0) {
        videoKey = [[url.absoluteString componentsSeparatedByString:@"?v="]lastObject];
    }
    return videoKey;
}
- (void)pauseVideo{
    _isPlaying = NO;
    [player pause];
    [_delegate videoPlayer:self playBackFinish:nil];
    [self stopTimer];
}
- (void)enableTracks:(BOOL)isEnable{
    NSArray *tracks = [playerItem tracks];
    for (AVPlayerItemTrack *playerItemTrack in tracks)
    {
        // find video tracks
        if ([playerItemTrack.assetTrack hasMediaCharacteristic:AVMediaCharacteristicVisual])
        {
            playerItemTrack.enabled = isEnable; // disable the track
        }
    }
}

- (BOOL)getAutoResume{
    return autoResume;
}
- (void)setAutoResume:(BOOL)_autoResume{
    autoResume = _autoResume;
}
@end
