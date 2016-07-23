//
//  ArchiveCell.m
//  SV
//
//  Created by BaoAnh on 2/21/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import "ArchiveCell.h"
#import "VideoPlayer.h"
#import "Util.h"

@implementation ArchiveCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCell:(Video *)video{
    _lbName.text = video.name;
    _lbOrder.text = [NSString stringWithFormat:@"%ld", self.tag + 1];
    _lbTime.text = video.updateTime;
    _imvThumb.image = [self imageFromName:video.name];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSURL *thumbUrl = [NSURL URLWithString:video.urlThumb];
//        NSData *imgData = [NSData dataWithContentsOfURL:thumbUrl];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            _imvThumb.image = [[UIImage alloc]initWithData:imgData];
//        });
//    });
}

- (UIImage *)imageFromName:(NSString *)videoName{
    NSString *unaccentedString = [videoName stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    NSString *normalName = [unaccentedString lowercaseString];
    
    NSString *imageName = [UTIL thumbNameFromVideoName:normalName];
    return [UIImage imageNamed:imageName];
}

@end
