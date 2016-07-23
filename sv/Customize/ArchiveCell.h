//
//  ArchiveCell.h
//  SV
//
//  Created by BaoAnh on 2/21/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"

@interface ArchiveCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbOrder;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UIImageView *imvThumb;

- (void)configCell:(Video *)video;

@end
