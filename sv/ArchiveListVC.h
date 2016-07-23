//
//  ArchiveListVC.h
//  SV
//
//  Created by BaoAnh on 2/21/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"

@interface ArchiveListVC : UITableViewController{
    NSMutableArray *dataSource;
//    NSInteger startIndex;
    NSString *nextPageToken;
    BOOL isMore;
    IBOutlet UIActivityIndicatorView *indicatorView;
}

@end
