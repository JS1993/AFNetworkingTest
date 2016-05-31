//
//  ViewController.m
//  AFNetworkingTest
//
//  Created by  江苏 on 16/5/31.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 直接使用“服务器本来返回的数据”，不做任何解析
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //    [AFJSONResponseSerializer serializer]; // 解析服务器返回的JSON数据
    //    [AFXMLParserResponseSerializer serializer]; // 解析服务器返回的XML数据
    
    [mgr GET:@"http://120.25.226.186:32812/resources/images/minion_02.png" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData * responseObject) {
         NSLog(@"请求成功---%zd", responseObject.length);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败---%@", error);
    }];
}

//解析XML
-(void)xml{
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        
        // responseSerializer 用来解析服务器返回的数据
        
        // 告诉AFN，以XML形式解析服务器返回的数据
        mgr.responseSerializer = [AFXMLParserResponseSerializer serializer];
        
        NSDictionary *params = @{
                                 @"username" : @"520it",
                                 @"pwd" : @"520it",
                                 @"type" : @"XML"
                                 };
    
    [mgr GET:@"http://120.25.226.186:32812/login" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"请求失败---%@", error);
    }];
}

//上传方式1
- (void)upload
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr POST:@"http://120.25.226.186:32812/upload" parameters:@{@"username" : @"123"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 在这个block中设置需要上传的文件
        NSData *data = [NSData dataWithContentsOfFile:@"/Users/jiangsu/Desktop/placeholder.png"];
        [formData appendPartWithFileData:data name:@"file" fileName:@"test.png" mimeType:@"image/png"];
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"/Users/jiangsu/Desktop/placeholder.png"] name:@"file" fileName:@"xxx.png" mimeType:@"image/png" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSLog(@"-------%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//上传方式2
- (void)upload2
{
    //    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //    [mgr uploadTaskWithRequest:<#(NSURLRequest *)#> fromData:<#(NSData *)#> progress:<#(NSProgress *__autoreleasing *)#> completionHandler:<#^(NSURLResponse *response, id responseObject, NSError *error)completionHandler#>];
}

//下载
- (void)download
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_02.png"]] progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //返回一个下载后要存储的路径就行了。。。
        return [NSURL URLWithString:@"/Users/jiangsu/Desktop"];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    }];

}

//使用AFN监控网络状态
- (void)afnMonitoring
{
    // 开始网络监控
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"-----当前的网络状态---%zd", status);
    }];
    
    [mgr startMonitoring];
    
    // 拿到当前网络状态
    //    mgr.networkReachabilityStatus;
}

//post请求，格式和get请求一样
- (void)post
{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{
                             @"username" : @"jiansu",
                             @"pwd" : @"2313"
                             };
   [mgr POST:@"" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
       
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
   }];
}




@end
