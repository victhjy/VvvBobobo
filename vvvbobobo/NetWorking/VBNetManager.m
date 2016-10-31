//
//  VBNetManager.m
//  vvvbobobo
//
//  Created by huangjinyang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import "VBNetManager.h"

@implementation VBNetManager
+ (instancetype)sharedManager {
    static VBNetManager *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASEHOST]];
        manager.securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy.validatesDomainName = NO;
    });
    return manager;
}

+ (instancetype)sharedManagerAbsoluteUrl {
    static VBNetManager *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        manager.securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy.validatesDomainName = NO;
    });
    return manager;
}


-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 5;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    [VBTools MBHudShow];
    switch (method) {
        case GET:{
            [self GET:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                success(responseObject);
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//                [VBTools MBHudHidden];
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                VBLog(@"Error: %@", error);
                failure(error);
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//                [VBTools MBHudHidden];
            }];
            break;
        }
        case POST:{
            [self POST:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                VBLog(@"JSON: %@", responseObject);
                success(responseObject);
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [VBTools MBHudHidden];
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                VBLog(@"Error: %@", error);
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [VBTools MBHudHidden];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                failure(error);
            }];
            break;
        }
        default:
            break;
    }    
}

@end
