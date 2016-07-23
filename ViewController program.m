//
//  ViewController program.m
//  SV
//
//  Created by patrik on 1/22/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import "ViewController program.h"

@interface ViewController_program ()

@end

@implementation ViewController_program

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)info:(id)sender{
    
    UIAlertView *info1 = [[UIAlertView alloc]initWithTitle:@"Upozornenie !!!" message:@"Pre obnovenie programu stlacit refresh!" delegate:self cancelButtonTitle:@"Zatvorit" otherButtonTitles: nil];
    [info1 show];
    
}

-(IBAction)program:(id)sender{
    [self loadWebPage];
}

 


- (void) loadWebPage{
    NSString *stream = @"http://slobodnyvysielac.sk/program";
    NSURL *url = [NSURL URLWithString:stream];
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
    [program loadRequest:urlrequest];
    
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void) startIndicatorView{
    indicatorView.hidden = NO;
    [indicatorView startAnimating];
}
- (void) stopIndicatorView{
    indicatorView.hidden = YES;
    [indicatorView stopAnimating];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self startIndicatorView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self stopIndicatorView];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self stopIndicatorView];
}

@end
