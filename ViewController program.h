//
//  ViewController program.h
//  SV
//
//  Created by patrik on 1/22/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController_program : UIViewController<UIWebViewDelegate>{
    IBOutlet UIWebView *program;
    IBOutlet UIActivityIndicatorView *indicatorView;
}
-(IBAction)info:(id)sender;

@property (nonatomic) NSInteger pageIndex;

@end
