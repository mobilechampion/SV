//
//  Video.h
//  SV
//
//  Created by BaoAnh on 2/21/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject

@property (nonatomic, retain) NSString *iD;
@property (nonatomic, retain) NSString *name;
@property NSInteger views;
@property NSInteger duration;       // seconds value
@property (nonatomic, retain) NSString *updateTime;
@property (nonatomic, retain) NSString *urlThumb;
@property (nonatomic, retain) NSString *urlStream;

- (id)initWithJson:(NSDictionary *)json;

@end
