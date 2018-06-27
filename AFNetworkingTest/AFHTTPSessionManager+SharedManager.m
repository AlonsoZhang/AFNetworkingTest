//
//  AFHTTPSessionManager+SharedManager.m
//  AFNetworking
//
//  Created by Alonso on 2018/6/27.
//

#import "AFHTTPSessionManager+SharedManager.h"

@implementation AFHTTPSessionManager (SharedManager)

+ (AFHTTPSessionManager *)zwsharedManager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [AFHTTPSessionManager manager];
        manager.operationQueue.maxConcurrentOperationCount = 5;
        manager.requestSerializer.timeoutInterval=30.f;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",@"text/json",nil];
        [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    });
    return manager;
}

@end
