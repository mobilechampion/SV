//
//  ViewController.m
//  SV
//
//  Created by patrik on 1/21/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//  original

#import "ViewController.h"
#import "VideoPlayer.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupInterface];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    lbName.text = APPDELEGATE.videoSelected.name;
    if ([VIDEO_PLAYER isPlaying]) {
        lbName.hidden = NO;
    }else{
        lbName.hidden = YES;
    }
}
- (void) initData{
    AudioPlayer *audioPlayer = AUDIO_PLAYER;
    audioPlayer.delegate = self;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //Ask for Rating
    
    BOOL neverRate = [prefs boolForKey:@"neverRate"];
    
    NSInteger launchCount = 1;
    //Get the number of launches
    launchCount = [prefs integerForKey:@"launchCount"];
    launchCount++;
    
    [[NSUserDefaults standardUserDefaults] setInteger:launchCount forKey:@"launchCount"];
    
    if (!neverRate)
    {
        if ( (launchCount == 2) || (launchCount == 4) || (launchCount == 6) || (launchCount == 10) )
        {
            [self rateApp];
        }
    }
    [prefs synchronize];
}

- (void) setupInterface{
    [self setStatePlay:YES];
    
    MPVolumeView* volumeView = [[MPVolumeView alloc] init];
    UISlider* volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeViewSlider = (UISlider*)view;
            break;
        }
    }
    
    volumeViewSlider.frame = CGRectMake(20, btnPlay.frame.origin.y + btnPlay.frame.size.height - 30, self.view.frame.size.width - 40, 100);
    [self.view addSubview:volumeViewSlider];
    
    [volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    [volumeViewSlider addTarget:self action:@selector(sliderVolumeValueChange:) forControlEvents:UIControlEventValueChanged];
    
    
    //iadd banner botton screen
    //  adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0.0, 600.0, 320.0, 50.0)];
    //   adBanner.delegate = self;
    //  [self.view addSubview:adBanner];
}

/*
-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    return YES;
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    if (adBanner.bannerLoaded) {
        NSLog(@"banner loaded");
        CGRect contentFrame =self.view.bounds;
        CGRect bannerFrame = adBanner.frame;
        contentFrame.size.height -= adBanner.frame.size.height;
        bannerFrame.origin.y = contentFrame.size.height;
        adBanner.frame = bannerFrame;
    }
    
    
}

-(void) bannerview:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    //koniec add buttton bunner
}

*/
- (void)rateApp {
    BOOL neverRate = [[NSUserDefaults standardUserDefaults] boolForKey:@"neverRate"];
    
    if (neverRate != YES) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hodnotenie"
                                                        message:@"Ak sa ti tato app paci, ohodnot ju."
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Hned teraz", @"Neskor", @"Nikdy", nil];
        alert.delegate = self;
        [alert show];
        
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"neverRate"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=961345579"]]];
    }
    
    else if (buttonIndex == 1) {
        
    }
    
    else if (buttonIndex == 2) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"neverRate"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onDonate:(id)sender
{
    NSString* paypal = @"norbert@slobodnyvysielac.sk";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.paypal.com/cgi-bin/webscr?business=%@&cmd=_donations&item_name=Donation&currency_code=EUR", paypal]]];
}
- (void)setStatePlay:(BOOL)isPlay{
    if (isPlay) {
        btnPlay.tag = ktag_play;
        [btnPlay setImage:[UIImage imageNamed:@"play_btn"] forState:UIControlStateNormal];
    }else{
        btnPlay.tag = ktag_pause;
        [btnPlay setImage:[UIImage imageNamed:@"pause_btn"] forState:UIControlStateNormal];
    }
}
-(IBAction)play:(id)sender{
    if (btnPlay.tag == ktag_play) {
        [self setStatePlay:NO];
        [AUDIO_PLAYER playAudioAtLink:@"http://stream.slobodnyvysielac.sk:8000/stream.m3u"];
    }else {
        [self setStatePlay:YES];
        [AUDIO_PLAYER stop];
    }
}

- (IBAction)btnSettingsTap:(id)sender {
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"NavSettingsVCIdentifier"];
    [self presentViewController:nav animated:YES completion:nil];
}



- (void)sliderVolumeValueChange:(id)sender {
    
}

#pragma mark - AudioPlayerDelegate
- (void) audioPlayer:(AudioPlayer *)audioPlayer playBackFinish:(NSNotification *) notification{
    if (notification) {
        NSLog(@"%@", notification);
    }
    [self setStatePlay:YES];
}

@end
