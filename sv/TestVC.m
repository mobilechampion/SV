//
//  TestVC.m
//  SV
//
//  Created by BaoAnh on 3/4/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import "TestVC.h"
#import "collecController.h"
#import "cellmm.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnBackTap:(id)sender{
    
  //  [self.view removeFromSuperview];
   // [self removeFromParentViewController];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
