//
//  AudioPlayer.m
//  SV
//
//  Created by BaoAnh on 2/17/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import "AudioPlayer.h"
#import "VideoPlayer.h"

static AudioPlayer *_audioPlayer;

@implementation AudioPlayer

+ (id)sharedInstant{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _audioPlayer = [[AudioPlayer alloc]init];
    });
    return _audioPlayer;
}

- (void)playAudioAtLink:(NSString *)link{
    [VIDEO_PLAYER pauseVideo];
    if (link && link.length > 0 && [NSURL URLWithString:link]) {
        [self removePlayBackNotification];
        audioLink = link;
        NSURL *url = [NSURL URLWithString:link];
        
        player = [[MPMoviePlayerController alloc]initWithContentURL:url];
        player.movieSourceType = MPMovieSourceTypeStreaming;
        [player prepareToPlay];
        [player play];
        _isPlaying = YES;
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        
        [self addPlayBackNotification];
    }
}
//beging new method

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
                [self playAudioAtLink:audioLink];
                [self setAutoResume:NO];
            }
            break;
        default:
            break;
    }
}
- (BOOL)getAutoResume{
    return autoResume;
}
- (void)setAutoResume:(BOOL)_autoResume{
    autoResume = _autoResume;
}

//end method


-(void)stop{
    [self moviePlayBackDidFinish:nil];
}

- (void)addPlayBackNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
}
- (void)removePlayBackNotification{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

- (void)moviePlayBackDidFinish:(NSNotification *) notification{
    [_delegate audioPlayer:self playBackFinish:notification];
    [self removePlayBackNotification];
    player.initialPlaybackTime = -1;
    [player stop];
    player = nil;
    _isPlaying = NO;
}


//-(void)playselectedsong{
//    
////    songPlayer = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"http://www.slobodnyvysielac.sk/redata/other/play.php?file=informacna%20vojna%20-%202015-02-10%20hudo.mp3"]];
//    songPlayer = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"http://www.abstractpath.com/files/audiosamples/sample.mp3"]];
////    [[NSNotificationCenter defaultCenter] addObserver:self
////                                             selector:@selector(playerItemDidReachEnd:)
////                                                 name:AVPlayerItemDidPlayToEndTimeNotification
////                                               object:songPlayer.currentItem];
//    [songPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
//}

//@"http://www.abstractpath.com/files/audiosamples/sample.mp3"

-(void)play:(NSString *)link{
    songPlayer = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:link]];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:songPlayer.currentItem];
    [songPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == songPlayer && [keyPath isEqualToString:@"status"]) {
        if (songPlayer.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
        } else if (songPlayer.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            [songPlayer play];
            _isPlaying = YES;
        } else if (songPlayer.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
        }
    }
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
}

@end
