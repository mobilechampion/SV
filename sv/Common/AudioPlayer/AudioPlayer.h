//
//  AudioPlayer.h
//  SV
//
//  Created by BaoAnh on 2/17/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#define AUDIO_PLAYER    [AudioPlayer sharedInstant]

@class AudioPlayer;

@protocol AudioPlayerDelegate <NSObject>

- (void) audioPlayer:(AudioPlayer *)audioPlayer playBackFinish:(NSNotification *) notification;

@end

@interface AudioPlayer : NSObject{
    MPMoviePlayerController *player;
    AVPlayer *songPlayer;
    BOOL autoResume;
    NSString *audioLink;
}

@property (nonatomic)BOOL isPlaying;
@property (nonatomic, strong) id <AudioPlayerDelegate> delegate;

+ (id) sharedInstant;
- (void)playAudioAtLink:(NSString *)link;
- (void)stop;
- (BOOL)getAutoResume;
- (void)setAutoResume:(BOOL)_autoResume;

@end
