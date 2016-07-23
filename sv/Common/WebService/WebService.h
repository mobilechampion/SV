//
//  WebService.h
//  SV
//
//  Created by BaoAnh on 2/21/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Constant.h"

#define WEBSERVICE      [WebService sharedInstant]

@interface WebService : NSObject

+ (id)sharedInstant;
- (void)loadRequest:(NSString *)apiName param:(NSDictionary *)param success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
