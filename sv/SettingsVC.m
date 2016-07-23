//
//  SettingsVC.m
//  sv
//
//  Created by BaoAnh on 4/23/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import "SettingsVC.h"
//#define SECOND_IN_HOUR  3600

@interface SettingsVC ()

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    NSNumber *time = [UTIL getStopTimeAudio];
    [self unSelectAll];
    if (!time || [time intValue] == 0) {
        [btn0 setSelected:YES];
    }else{
        int iTime = [time intValue];
        if (iTime == 1800 ) {
            [btn1 setSelected:YES];
        }else if (iTime == 2700 ) {
            [btn2 setSelected:YES];
        }else if (iTime == 3600 ){
            [btn3 setSelected:YES];
        }else if (iTime == 4800 ){
            [btn4 setSelected:YES];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupInterface{
    btn0.tag = ktag_btn0;
    btn1.tag = ktag_btn1;
    btn2.tag = ktag_btn2;
    btn3.tag = ktag_btn3;
    btn4.tag = ktag_btn4;
      
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)btnTap:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [self unSelectAll];
    switch (btn.tag) {
        case ktag_btn0:{
            [btn0 setSelected:YES];
            break;
        }
        case ktag_btn1:{
            [btn1 setSelected:YES];
            break;
        }
        case ktag_btn2:{
            [btn2 setSelected:YES];
            break;
        }
        case ktag_btn3:{
            [btn3 setSelected:YES];
            break;
        }
        case ktag_btn4:{
            [btn4 setSelected:YES];
            break;
        }
    }
}

- (IBAction)btnCancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnDoneTap:(id)sender {
    [self saveSelectedTime];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)saveSelectedTime{
    int time = 0;
    if (btn0.isSelected) {
        time = 0;
    }else if (btn1.isSelected){
        time = 1800;
    }else if (btn2.isSelected){
        time = 2700;
    }else if (btn3.isSelected){
        time = 3600;
    }else if (btn4.isSelected){
        time = 4800;
    }
    [UTIL setStopTimeAudio:[NSNumber numberWithInt:time ]];
}
- (void)unSelectAll{
    [btn0 setSelected:NO];
    [btn1 setSelected:NO];
    [btn2 setSelected:NO];
    [btn3 setSelected:NO];
    [btn4 setSelected:NO];
}
@end
