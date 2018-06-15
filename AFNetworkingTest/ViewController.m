//
//  ViewController.m
//  AFNetworkingTest
//
//  Created by Alonso on 2018/6/13.
//  Copyright © 2018 Alonso. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    
    [manager GET:@"http://localhost" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
