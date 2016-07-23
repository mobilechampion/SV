//
//  WebService.m
//  SV
//
//  Created by BaoAnh on 2/21/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import "WebService.h"
static WebService *_webService;

@implementation WebService

+ (id)sharedInstant{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _webService = [[WebService alloc]init];
    });
    return _webService;
}
- (NSString *)subUrlFromApiName:(NSString *)apiName param:(NSDictionary *)param{
    NSString *subUrl = @"";
    if (param) {
        NSString *keyValue;
        NSString *moreUrl = @"?";
        for (NSString *key in param.allKeys) {
            if (key.length > 0) {
                NSString *value = [param objectForKey:key];
                if (moreUrl.length == 1) {
                    keyValue = [NSString stringWithFormat:@"%@=%@", key, value];
                }else{
                    keyValue = [NSString stringWithFormat:@"&%@=%@", key, value];
                }
                moreUrl = [moreUrl stringByAppendingString:keyValue];
            }
        }
        subUrl = [moreUrl stringByAppendingString:subUrl];
        subUrl = [subUrl stringByAppendingString:@"&part=snippet"];
        keyValue = [NSString stringWithFormat:@"&%@=%@", @"key", SECRET_KEY];
        subUrl = [subUrl stringByAppendingString:keyValue];
        subUrl = [subUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return subUrl;
}
- (void)loadRequest:(NSString *)apiName param:(NSDictionary *)param success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    NSString *subUrl = [self subUrlFromApiName:apiName param:param];
    NSString *urlString = [BASE_URL stringByAppendingString:subUrl];
//    NSString *subUrl = [self subUrlFromApiName:@"" param:nil];
//    NSString *urlString = [WEB_URL stringByAppendingString:subUrl];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON of api %@: %@",apiName, responseObject);
        success(operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error of api %@: %@",apiName, error);
        failure(error);
    }];
}

@end
