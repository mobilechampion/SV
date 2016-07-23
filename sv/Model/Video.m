//
//  Video.m
//  SV
//
//  Created by BaoAnh on 2/21/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import "Video.h"
#import <UIKit/UIKit.h>

@implementation Video

- (id)initWithJson:(NSDictionary *)json{
    Video *video = [[Video alloc]init];
    
    // get title
    NSDictionary *itemBody = [json objectForKey:@"snippet"];
    video.name = [itemBody objectForKey:@"title"];
//    if ([video.name.lowercaseString isEqualToString:@"https://youtube.com/devicesupport"]) {
//        return nil;
//    }
    // get view count
//    NSDictionary *jsonViewCount = [json objectForKey:@"yt$statistics"];
//    video.views = [[jsonViewCount objectForKey:@"viewCount"] integerValue];
    // get seconds
    NSDictionary *jsonMedia = [itemBody objectForKey:@"thumbnails"];
//    NSDictionary *jsonDuration = [jsonMedia objectForKey:@"yt$duration"];
//    video.duration = [[jsonDuration objectForKey:@"seconds"]integerValue];
    // get urlThumb
    NSDictionary *jsonThumbs = [jsonMedia objectForKey:@"default"];
    
    video.urlThumb = [jsonThumbs objectForKey:@"url"];
//    for (NSDictionary *jsonThumb in jsonThumbs) {
//        int height = [[jsonThumb objectForKey:@"height"] integerValue];
//        if (height == 360) {
//            video.urlThumb = [jsonThumb objectForKey:@"url"];
//            break;
//        }
//    }
    // get update time
//    NSDictionary *jsonUpdated = [itemBody objectForKey:@"publishedAt"];
    NSString *strTemp = [itemBody objectForKey:@"publishedAt"];
    strTemp = [strTemp stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
    strTemp = [strTemp stringByReplacingOccurrencesOfString:@".000Z" withString:@""];
    video.updateTime = strTemp;
    
    // get urlStream
//    NSDictionary *jsonLinks = [json objectForKey:@"link"];
//    for (NSDictionary *jsonLink in jsonLinks) {
//        NSString *type = [jsonLink objectForKey:@"type"];
//        NSString *rel  = [jsonLink objectForKey:@"rel"];
//        
//        if ([type isEqualToString:@"text/html"] && [rel rangeOfString:@"mobile"].length > 0) {
//            video.urlStream = [jsonLink objectForKey:@"href"];
//            //            http://www.youtube.com/watch?v=h_5ewWo288k
//            video.iD = [[video.urlStream componentsSeparatedByString:@"v="] lastObject];
//            break;
//        }
//    }
    NSDictionary *videoID = [json objectForKey:@"id"];
    if ([videoID objectForKey:@"videoId"] == nil){
        if ([videoID objectForKey:@"playlistId"] == nil){
            if ([videoID objectForKey:@"channelId"] != nil){
                video.iD = [videoID objectForKey:@"channelId"];
            }
        }
        else {
            video.iD = [videoID objectForKey:@"playlistId"];
        }
    }
    else {
        video.iD = [videoID objectForKey:@"videoId"];
    }
//    if (itemNum <= 25){
//        video.iD = [videoID objectForKey:@"videoId"];
//    }
//    else {
//        video.iD =[videoID objectForKey:@"playlistId"];
//    }
    video.urlStream = [@"https://www.youtube.com/watch?v=" stringByAppendingString:video.iD];
    
    return video;
}
@end
