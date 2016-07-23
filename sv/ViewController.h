//
//  ViewController.h
//  SV
//
//  Created by patrik on 1/21/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <iAd/iAd.h>
#import "AudioPlayer.h"
#import <Social/Social.h>
#import "MarqueeLabel.h"

enum{
    ktag_play = 1,
    ktag_pause = 2
};

@class FSAudioStream;

@interface ViewController : UIViewController <ADBannerViewDelegate, AudioPlayerDelegate> {
    __weak IBOutlet UIButton *btnPlay;
    ADBannerView *adBanner;
    MPMoviePlayerController *player;
    __weak IBOutlet MarqueeLabel *lbName;
}

@property (nonatomic) NSInteger pageIndex;
@property (nonatomic, strong) UISlider *volumeSlider;

- (IBAction)play:(id)sender;
- (IBAction)btnSettingsTap:(id)sender;


 
@end

