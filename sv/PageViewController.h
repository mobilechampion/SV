//
//  PageViewController.h
//  Timesheet
//
//  Created by BaoAnh on 2/16/15.
//  Copyright (c) 2015 lion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController archiv.h"
#import "ViewController.h"
#import "ViewController program.h"

@interface PageViewController : UIPageViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>{
    NSInteger pageSize;
    ViewController_archiv *archivCV;
    ViewController *homeVC;
    ViewController_program *programVC;
    
    UIPageControl *pageControl;
    NSInteger currIndex;
}

@end
