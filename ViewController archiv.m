//
//  ViewController archiv.m
//  SV
//
//  Created by patrik on 2/6/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import "ViewController archiv.h"
#import "VideoPlayer.h"
#import "ArchiveListVC.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "TestVC.h"

@interface ViewController_archiv ()

@end

@implementation ViewController_archiv

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupInterface];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (APPDELEGATE.videoSelected) {
        btnPlay.enabled = YES;
    }else{
        btnPlay.enabled = NO;
    }
    lbName.text = APPDELEGATE.videoSelected.name;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initData{
    VideoPlayer *videoPlayer = VIDEO_PLAYER;
    videoPlayer.delegate = self;
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
    
    volumeViewSlider.frame = CGRectMake(20, btnPlay.frame.origin.y + btnPlay.frame.size.height + 30, self.view.frame.size.width - 40, -20);
    [self.view addSubview:volumeViewSlider];
    
    [volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    lbCurrTime.text = @"00:00";
    lbTotalTime.text = @"00:00";
    sliderCurrTime.value = 0.0;
    [self customizeSliderCurrTime];
}
- (void)customizeSliderCurrTime{
    UIImage* sliderBarMinImage = [[UTIL imageFromColor:RGB(0,0,0)] stretchableImageWithLeftCapWidth:8.0 topCapHeight:0.0];
    UIImage* sliderBarImage = [[UTIL imageFromColor:RGB(255, 255, 255)] stretchableImageWithLeftCapWidth:8.0 topCapHeight:0.0];
//    UIImage* sliderThumbImage= [[UIImage imageNamed:@"slider_other_thumb1.png"] stretchableImageWithLeftCapWidth:8.0 topCapHeight:0.0];
    
    [sliderCurrTime setMinimumTrackImage:sliderBarMinImage forState:UIControlStateNormal];
    [sliderCurrTime setMaximumTrackImage:sliderBarImage forState:UIControlStateNormal];
//    [sliderCurrTime setThumbImage:sliderThumbImage forState:UIControlStateNormal];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)information:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Upozornenie: " message:@"Archiv sa obnovuje automaticky ked je relacia pridana na YouTube. Ked tam nie je, nenajdete ju ani tu!!!" delegate:self cancelButtonTitle:@"Zatvorit!" otherButtonTitles:  nil];
    [alert show];
    
}

- (IBAction)sliderCurrTimeChangeValue:(id)sender {
    float seekSecond = sliderCurrTime.value;
    [VIDEO_PLAYER seekToSecond:seekSecond];
}

- (IBAction)showEmail:(id)sender {
    
    NSString *emailTittle = @"SV APP";
    NSString *messageBody = @"Zdravim vsetkych jablckarov. Ak mate nejake napady ohladne app, alebo co by ste tu chceli mat ci naopak, co vam vadi, kludne piste. ;-)";
    NSArray *toRecipents = [NSArray arrayWithObjects:@"patosk2000@yahoo.com",nil];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init ];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTittle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    [self presentViewController:mc animated:YES completion:NULL];
    
    
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
            case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
            case MFMailComposeResultSent:
                  NSLog(@"Mail sent");
                  break;
                  case MFMailComposeResultFailed:
                  NSLog(@"Mail sent failuere: %@",[error localizedDescription]);
                  break;
            
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:Nil];
}



- (IBAction)btnArchiveTap:(id)sender {
    if (!navArchiveVC) {
        navArchiveVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NavArchiveListVCIdentifier"];
    }
    [self presentViewController:navArchiveVC animated:YES completion:nil];
}
- (IBAction)btnPlayTap:(id)sender{
    if (btnPlay.tag == ktag_play) {
        [self setStatePlay:NO];
        [VIDEO_PLAYER setUrl:[NSURL URLWithString:APPDELEGATE.videoSelected.urlStream]];
        [VIDEO_PLAYER playVideo];
    }else {
        [self setStatePlay:YES];
        [VIDEO_PLAYER pauseVideo];
    }
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

#pragma mark - VideoPlayerDelegate
- (void) videoPlayer:(VideoPlayer *)videoPlayer playBackFinish:(NSNotification *) notification{
    [self setStatePlay:YES];
}
- (void) videoPlayer:(VideoPlayer *)videoPlayer totalDuration:(float) totalDuration{
    NSLog(@"totalTime: %f", totalDuration);
    lbTotalTime.text = [UTIL getDisplayTimeFromSecond:totalDuration];
    sliderCurrTime.maximumValue = totalDuration;
}
- (void) videoPlayer:(VideoPlayer *)videoPlayer currentDuration:(float) currDuration{
    NSLog(@"currTime: %f", currDuration);
    lbCurrTime.text = [UTIL getDisplayTimeFromSecond:currDuration];
    sliderCurrTime.value = currDuration;
}



@end
