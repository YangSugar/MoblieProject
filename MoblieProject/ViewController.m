//
//  ViewController.m
//  MoblieProject
//
//  Created by futang yang on 2017/11/20.
//  Copyright © 2017年 futang yang. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <JavaScriptCore/JavaScriptCore.h>



@interface ViewController ()<NSURLSessionDelegate, UIWebViewDelegate>

@property (nonatomic, strong) NSMutableData *dataM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)testClick:(id)sender {
    [self afn_POST_Method];
}






- (void)groupSync {

    dispatch_queue_t disqueue =  dispatch_queue_create("com.shidaiyinuo.NetWorkStudy", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t disgroup = dispatch_group_create();
    dispatch_group_async(disgroup, disqueue, ^{
        NSLog(@"任务一完成    线程=%@",[NSThread currentThread]);
    });
    dispatch_group_async(disgroup, disqueue, ^{
        sleep(5);
        NSLog(@"任务二完成    线程=%@",[NSThread currentThread]);
    });
    dispatch_group_notify(disgroup, disqueue, ^{
        NSLog(@"dispatch_group_notify 执行   线程=%@",[NSThread currentThread]);
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_group_wait(disgroup, dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC));
        NSLog(@"dispatch_group_wait 结束    线程=%@",[NSThread currentThread]);
    });

    
}




#pragma mark - AFN
- (void)afn_POST_Method {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"code"] = @"llg";
    
    [manager POST:@"http://hq.xukaihang.com/query/quotation" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---- %@ ", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];

}





#pragma mark - NSURLSessionDownloadTask 简单下载
- (void)DownloadTask {
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_02.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDownloadTask *downTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@",location);
        
        NSString *fullPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        
        NSLog(@"%@", fullPath);
        
        
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL URLWithString:fullPath] error:nil];
    }];
    
    
    [downTask resume];
}



#pragma mark - POST代理
- (void)postTask {
    
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
    NSMutableURLRequest *requsetM = [NSMutableURLRequest requestWithURL:url];
    requsetM.HTTPMethod = @"POST";
    requsetM.HTTPBody = [@"username=520&pwd=520&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *seesion = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSURLSessionDataTask *dataTask = [seesion dataTaskWithRequest:requsetM];
    [dataTask resume];
    
    [seesion finishTasksAndInvalidate];
}

-(void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler {
    //子线程中执行
    NSLog(@"接收到服务器响应的时候调用 -- %@", [NSThread currentThread]);
    
     self.dataM = [NSMutableData data];
    //默认情况下不接收数据
    //必须告诉系统是否接收服务器返回的数据
    completionHandler(NSURLSessionResponseAllow);
}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"接受到服务器返回数据的时候调用,可能被调用多次");
    //拼接服务器返回的数据
    [self.dataM appendData:data];
}
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    NSLog(@"请求完成或者是失败的时候调用");
    //解析服务器返回数据
    NSLog(@"%@", [[NSString alloc] initWithData:self.dataM encoding:NSUTF8StringEncoding]);
}

#pragma mark - GET
- (void)getTask {
    // 创建 URL
    NSURL *url = [NSURL URLWithString:@"https://cj.jujin8.com/kx?page=1&num=20"];
    NSURLSession *seesion = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [seesion dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"----- %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"%@", [NSThread currentThread]);
        
    }];
    
    [dataTask resume];
}



@end
