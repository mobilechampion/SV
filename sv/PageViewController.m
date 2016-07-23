//
//  PageViewController.m
//  Timesheet
//
//  Created by BaoAnh on 2/16/15.
//  Copyright (c) 2015 lion. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) initData{
    pageSize = 3;
}

- (void) setupInterface{
    ViewController *startingViewController = (ViewController *)[self viewControllerAtIndex:1];
    NSArray *viewControllers = @[startingViewController];
    self.dataSource = self;
    self.delegate = self;
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    float width = 60;
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - width/2, self.view.frame.size.height - 40, width, 30)];
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 1;
    [self.view addSubview:pageControl];
    [self.view bringSubviewToFront: pageControl];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if ((pageSize == 0) || (index >= pageSize)) {
        return nil;
    }
    
    UIViewController *vc;
    
    switch (index) {
        case 0:{
            if (!archivCV) {
                archivCV = (ViewController_archiv *)[self.storyboard instantiateViewControllerWithIdentifier:@"ArchiveIdentifier"];
                ((ViewController_archiv *)archivCV).pageIndex = index;
            }
            vc = archivCV;
            
            break;
        }
        case 1:{
            if(!homeVC){
                homeVC = (ViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeIdentifier"];
                ((ViewController *)homeVC).pageIndex = index;
            }
            vc = homeVC;
            
            break;
        }
        case 2:{
            if (!programVC) {
                programVC = (ViewController_program *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProgramIdentifier"];
                ((ViewController_program *)programVC).pageIndex = index;
            }
            vc = programVC;
            
            break;
        }
    }
    return vc;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self getPageIndexFromVC:viewController];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self getPageIndexFromVC:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == pageSize) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)getPageIndexFromVC:(UIViewController *)viewController{
    NSUInteger index = 0;
    if ([viewController isKindOfClass:[ViewController_archiv class]]) {
        index = ((ViewController_archiv*) viewController).pageIndex;
    }
    if ([viewController isKindOfClass:[ViewController class]]) {
        index = ((ViewController*) viewController).pageIndex;
    }
    if ([viewController isKindOfClass:[ViewController_program class]]) {
        index = ((ViewController_program*) viewController).pageIndex;
    }
    return index;
}

//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
//{
//    return pageSize;
//}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 1;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
//    NSLog(@"willTransitionToViewControllers");
    for (id vc in pendingViewControllers) {
        if ([vc isKindOfClass:[UIViewController class]]) {
            currIndex = [self getPageIndexFromVC:vc];
            break;
        }
    }
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
//    NSLog(@"didFinishAnimating");
    if (completed) {
        pageControl.currentPage = currIndex;
    }
}

@end
