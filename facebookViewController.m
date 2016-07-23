//
//  facebookViewController.m
//  SV
//
//  Created by patrik on 2/3/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import "facebookViewController.h"

@interface facebookViewController ()

@end

@implementation facebookViewController

-(IBAction)facebook:(id)sender{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *fbSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [fbSheetOBJ setInitialText:@""];
        
      //  [fbSheetOBJ addURL: [NSURL URLWithString:@"http://www.slobodnyvysielac.com"]];
        
     // keby som chcel dat www adresu
        
        [fbSheetOBJ addImage:[UIImage imageNamed:@"nove logo120 sv 4.png"]];
        
        [self presentViewController:fbSheetOBJ animated:YES completion:nil];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
