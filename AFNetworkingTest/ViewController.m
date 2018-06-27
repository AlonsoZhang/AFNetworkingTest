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
//    [self doGetRequest];
//    [self doPostRequest];
//    [self doUploadRequest];
//    [self doDownLoadRequest];
    [self aFNetworkStatus];
}

/*- (AFHTTPSessionManager *)sharedManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //最大请求并发任务数
    manager.operationQueue.maxConcurrentOperationCount = 5;
    
    // 请求格式
    // AFHTTPRequestSerializer            二进制格式
    // AFJSONRequestSerializer            JSON
    // AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    
    // 超时时间
    manager.requestSerializer.timeoutInterval = 30.0f;
    // 设置请求头
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];

    
    // 返回格式
    // AFHTTPResponseSerializer           二进制格式
    // AFJSONResponseSerializer           JSON
    // AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
    // AFXMLDocumentResponseSerializer (Mac OS X)
    // AFPropertyListResponseSerializer   PList
    // AFImageResponseSerializer          Image
    // AFCompoundResponseSerializer       组合
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//返回格式 JSON
    //设置返回的Content-type
    manager.responseSerializer.acceptableContentTypes=[[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",@"text/json",nil];
    return manager;
}*/

-(void)doGetRequest
{
    //创建请求地址
    NSString *url=@"http://localhost";
    //构造参数
    //NSDictionary *parameters=@{@"name":@"yanzhenjie",@"pwd":@"123"};
    //AFN管理者调用get请求方法
    [[AFHTTPSessionManager zwsharedManager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //返回请求返回进度
        NSLog(@"downloadProgress-->%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功返回数据 根据responseSerializer 返回不同的数据格式
        NSString * str  =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"responseObject-->%@",str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"error-->%@",error);
    }];
}

- (void)doPostRequest {
    
    /*{
     do = "pri_memberlist";
     "member_id" = zpHr2dsRvQQxYJxo2;
     "workspace_id" = ILfYpE4Dhs2gWcuQx;
     }*/
    NSString *urlString = @"http://10.42.222.70/AEOverlay/D21AELimits/getlist.php";
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:@"pri_memberlist" forKey:@"do"];
//
//    [dict setObject:@"zpHr2dsRvQQxYJxo2" forKey:@"member_id"];
//    [dict setObject:@"ILfYpE4Dhs2gWcuQx" forKey:@"workspace_id"];
    // 参数1: url
    // 参数2: body体
    [[AFHTTPSessionManager zwsharedManager] POST:urlString parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"上传的进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        NSString * str  =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"post请求成功%@", str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"post请求失败:%@", error);
    }];
}

-(void)doUploadRequest
{
    // 创建URL资源地址
    NSString *url = @"http://10.42.222.70/AEOverlay/upload_file.php";
    // 参数
    [[AFHTTPSessionManager zwsharedManager] POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data  =[NSData dataWithContentsOfFile:@"/Users/alonso/Desktop/949.zip"];
        [formData appendPartWithFileData:data name:@"file" fileName:@"949.zip" mimeType:@"multipart/form-data; boundary=YYWEB"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSString * str  =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"请求成功：%@",str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}

-(void)doDownLoadRequest
{
    NSString *urlStr =@"http://10.42.222.70/AEOverlay/20180425_Artemis%20SA_Flex3_V0.11.zip";
    // 设置请求的URL地址
    NSURL *url = [NSURL URLWithString:urlStr];
    // 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 下载任务
    NSURLSessionDownloadTask *task = [[AFHTTPSessionManager zwsharedManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载进度
        NSLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
        NSString *filePath = @"/Users/alonso/Desktop/download.zip";
        return [NSURL fileURLWithPath:filePath]; // 返回的是文件存放在本地沙盒的地址
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 下载完成调用的方法
        NSLog(@"filePath---%@", filePath);
    }];
    //启动下载任务
    [task resume];
}

- (void)aFNetworkStatus{
    //创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}


+ (AFHTTPSessionManager *)sharedManager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [AFHTTPSessionManager manager];
        manager.operationQueue.maxConcurrentOperationCount = 5;
        manager.requestSerializer.timeoutInterval=30.f;
        manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
        [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
        
    });
    return manager;
}
@end
