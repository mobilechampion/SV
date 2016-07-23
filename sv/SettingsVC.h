//
//  SettingsVC.h
//  sv
//
//  Created by BaoAnh on 4/23/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"

enum{
    ktag_btn0,
    ktag_btn1,
    ktag_btn2,
    ktag_btn3,
    ktag_btn4
};

@interface SettingsVC : UIViewController{
    __weak IBOutlet UIButton *btn0;
    __weak IBOutlet UIButton *btn1;
    __weak IBOutlet UIButton *btn2;
    __weak IBOutlet UIButton *btn3;
    __weak IBOutlet UIButton *btn4;
}
- (IBAction)btnTap:(id)sender;
- (IBAction)btnCancelTap:(id)sender;
- (IBAction)btnDoneTap:(id)sender;

@end
