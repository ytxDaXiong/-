//
//  YTXHTTPSessionManager.m
//  百思不得姐
//
//  Created by 俞天 on 16/9/8.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXHTTPSessionManager.h"

@implementation YTXHTTPSessionManager
- (instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
//        self.securityPolicy.validatesDomainName = NO;
//        self.responseSerializer = nil;
//        self.requestSerializer  = nil;
    }
    return self;
}
@end
