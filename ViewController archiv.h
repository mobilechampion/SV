//
//  ViewController archiv.h
//  SV
//
//  Created by patrik on 2/6/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Video.h"
#import "VideoPlayer.h"
#import "MarqueeLabel.h"
#import "Util.h"
#import <MessageUI/MessageUI.h>


@interface ViewController_archiv : UIViewController<VideoPlayerDelegate,MFMailComposeViewControllerDelegate>{
    __weak IBOutlet UIButton *btnPlay;
    __weak IBOutlet MarqueeLabel *lbName;
    __weak IBOutlet UIView *viewCurrTime;
    __weak IBOutlet UILabel *lbCurrTime;
    __weak IBOutlet UILabel *lbTotalTime;
    __weak IBOutlet UISlider *sliderCurrTime;
    UINavigationController *navArchiveVC;
}

@property (nonatomic) NSInteger pageIndex;
- (IBAction)btnPlayTap:(id)sender;
- (IBAction)btnArchiveTap:(id)sender;
- (IBAction)information:(id)sender;
- (IBAction)sliderCurrTimeChangeValue:(id)sender;

- (IBAction)showEmail:(id)sender;
 

@end
