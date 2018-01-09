//
//  ViewController.m
//  MoblieProject
//
//  Created by futang yang on 2017/11/20.
//  Copyright © 2017年 futang yang. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "RunTimeViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <Masonry.h>

#import "MainClass.h"
#import "MainClass+Category.h"
#import "MainClass+OtherCategory.h"

#import "HookViewController.h"


#define SelfClass [self class]

@interface ViewController ()

@property (nonatomic, strong) NSMutableData *dataM;
@property (nonatomic, strong) Person *person;

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
    }];
    btn.backgroundColor = [UIColor orangeColor];
    
    [btn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)jump {
    
    HookViewController *vc = [[HookViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (Method)class_getInstanceMethod:(Class)class selector:(SEL)selector {
    Method method = class_getInstanceMethod(class, selector);
    NSLog(@"%s%s%d",__func__,sel_getName(selector),[self method_getNumberOfArguments:method]);
    return method;
}

- (unsigned int)method_getNumberOfArguments:(Method)method {
    unsigned int num = method_getNumberOfArguments(method);
    NSLog(@"%s -  %@ has  - %d Arguments", __func__, NSStringFromSelector(method_getName(method)), num);
    return num;
}

#pragma mark - Method invoke: 方法实现的返回值
/**
 *  调用指定方法的实现
 *
 *  @param receiver 被调用的对象
 *  @param method   被调用的方法
 */
- (void)method_invoke:(id)receiver method:(Method)method {
    method_invoke(receiver,method);
}

#pragma mark - Initialize
- (void)initial:(NSString *)str {
    
    if (str) NSLog(@"%@",str);
    _person = [[Person alloc] init];
    _person.name = @"yangfutang";
    _person.age = @"18";
    _person.gender = @"male";
    _person.city = @"beijing";
    
    [self logRunTimeAction:nil];
}


- (void)logRunTimeAction:(id)sender {
    // Class
    [self class_getClassName:[self class]];
    [self class_getSuperClass:SelfClass];
    [self class_getInstanceSize:SelfClass];
    [self class_getInstanceVariable:SelfClass name:"_person"];
    [self class_getInstanceMethod:SelfClass selector:@selector(class_getInstanceMethod:selector:)];
    [self.class class_getClassMethod:SelfClass selector:@selector(class_getClassMethod:selector:)];

    [self class_copyIvarList:[_person class]];
    [self class_copyPropertyList:[_person class]];
    [self class_copyMethodList:[_person class]];
    
    [self class_addIvar:[_person class] name:"country" size:sizeof(NSString *) alignment:0 types:"@"];
    [self class_addProperty:[_person class] name:"country" attributes:nil attributeCount:3];
    
    [self class_addMethod:SelfClass selector:NSSelectorFromString(@"runtimeTestMethod:") imp:class_getMethodImplementation(SelfClass, @selector(find)) types:"v@:@"];

    
    // Method
    Method method = [self class_getInstanceMethod:SelfClass selector:@selector(initial:)];
    [self method_getName:method];
    [self method_getImplementation:class_getInstanceMethod(SelfClass, @selector(find))]; // 该方法imp_implementationWithBlock使得imp几乎相当于block
    
    [self method_exchangeImplementations:class_getInstanceMethod([_person class], @selector(runtimeTestAction3)) method:class_getInstanceMethod([_person class], @selector(runtimeTestAction2))];
    [self method_getDescription:method];
    
    

    
    
}

/// ********************  ///
#pragma mark - Method get: 方法名；方法实现；参数与返回值相关
/**
 *  获取方法名
 *
 *  @param method 方法
 *
 *  @return 方法选择器
 */
- (SEL)method_getName:(Method)method {
    SEL sel = method_getName(method);
    NSLog(@"%s %@", __func__, NSStringFromSelector(sel));
    return sel;
}

/**
 *  返回方法的实现
 *
 *  @param method 方法
 *
 *  @return 方法的实现
 */
- (IMP)method_getImplementation:(Method)method {
    IMP imp = method_getImplementation(method);
    return imp;
}

/**
 *  交换两个方法的实现
 *
 *  @param method1 方法1
 *  @param method2 方法2
 */
- (void)method_exchangeImplementations:(Method)method1 method:(Method)method2 {
    method_exchangeImplementations(method1, method2);
    [_person runtimeTestAction2];
    [_person runtimeTestAction3];
}


#pragma mark - Method 方法描述
- (struct objc_method_description *)method_getDescription:(Method)method {
    struct objc_method_description *description = method_getDescription(method);
    NSLog(@"%s %@",__func__,NSStringFromSelector(description->name));
    return description;
}


/// ********************  ///



- (void)class_addMethod:(Class)class selector:(SEL)selector imp:(IMP)imp types:(const char *)types {
    if (class_addMethod(class,selector,class_getMethodImplementation(class, selector),types)) {
        NSLog(@"%sadd method success",__func__);
    
    } else{
        NSLog(@"%sadd method fail",__func__);
    }
    //    [self class_copyMethodList:class];
    
}


- (void)find {
    NSLog(@"hahhahahahha");
}

/**
 *  查看类是否遵循指定协议
 *
 *  @param class    类
 *  @param protocol 协议
 */
- (BOOL)class_conformsToProtocol:(Class)class protocol:(Protocol *)protocol {
    if (class_conformsToProtocol(class, protocol)) {
        NSLog(@"%s %@ conformsToProtocol %@",__func__,NSStringFromClass(class),NSStringFromProtocol(protocol));
        return YES;
    }else{
        NSLog(@"%s %@ non-conformsToProtocol %@",__func__,NSStringFromClass(class),NSStringFromProtocol(protocol));
        return NO;
    }
}


#pragma mark - Class add: 成员变量；属性；方法；协议
/**
 *  添加成员变量(添加成员变量只能在运行时创建的类，且不能为元类)
 *
 *  @param class     类
 *  @param name      成员变量名字
 *  @param size      大小
 *  @param alignment 对其方式
 *  @param types     参数类型
 */
- (void)class_addIvar:(Class)class name:(const char *)name size:(size_t)size alignment:(uint8_t)alignment types:(const char *)types {
    
    if (class_addIvar(class, name, size, alignment, types)) {
        NSLog(@"%s add ivar success",__func__);
    } else {
       NSLog(@"%sadd ivar fail",__func__);
    }
}

- (void)class_addProperty:(Class)class name:(const char *)name attributes:(objc_property_attribute_t *)attributes attributeCount:(int)attributeCount {
    
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership = { "C", "N" }; // C = copy
    objc_property_attribute_t backingivar  = { "V", "" };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };
    
    if (class_addProperty(class, name, attrs, attributeCount)) {
        NSLog(@"%sadd method success",__func__);
    } else {
        NSLog(@"%sadd method fail",__func__);
    }
    
    
    unsigned int count;
    objc_property_t *prolist = class_copyPropertyList(class, &count);
    
    for (int i = 0; i < count; i++) {
        NSString *name = [NSString stringWithUTF8String:property_getName(prolist[i])];
        
        NSLog(@"%@", name);
    }
}

/**
 *  添加方法
 *
 *  @param class    类
 *  @param selector 方法
 *  @param imp      方法实现
 *  @param types    类型
 */
//- (void)class_addMethod:(Class)class selector:(SEL)selector imp:(IMP)imp types:(const char *)types {
//    if (class_addMethod(class,selector,class_getMethodImplementation(class, selector),types)) {
//        NSLog(@"%sadd method success",__func__);
//    }else{
//        NSLog(@"%sadd method fail",__func__);
//    }
//    //    [self class_copyMethodList:class];
//
//}

//- (void)class_addMethod:(Class)class selector:(SEL)selector imp:(IMP)imp types:(const char *)types {
//    if (class_addMethod(class, selector, class_getMethodImplementation(class, selector), types)) {
//      NSLog(@"%sadd method success",__func__);
//    }else{
//        NSLog(@"%sadd method fail",__func__);
//    }
//}




#pragma mark - Class 成员变量列表；属性列表；方法列表；协议列表；
/**
 *  获取成员变量列表
 *
 *  @param class 类
 */
- (void)class_copyIvarList:(Class)class {
    unsigned int count;
    Ivar *ivarList = class_copyIvarList(class, &count);
    NSLog(@"%s",__func__);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        
        // 获取成员属性名
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        NSLog(@"%@%@",type,name);
        
    }
}

- (void)class_copyPropertyList:(Class)class {
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList(class,&count);
    NSLog(@"%s",__func__);
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        // 获取成员属性名
        NSString *name = [NSString stringWithUTF8String:[self property_getName:property]];
        NSString *type = [NSString stringWithUTF8String:[self property_getAttributes:property]];
        NSLog(@"%@%@",type,name);
    }
}

/**
 *  获取方法列表
 *
 *  @param class 类
 */
- (void)class_copyMethodList:(Class)class {
    unsigned int count;
    Method *methodList = class_copyMethodList(class,&count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"%s%s",__func__,sel_getName(method_getName(method)));
    }
}




/**
 *  获取类的类名
 *
 *  @param class 类
 */
- (void)class_getClassName:(Class)class {
    NSLog(@"%s : %s",__func__, class_getName(class));
}
/**
 *  获取类的父类
 *
 *  @param class 类
 */
- (void)class_getSuperClass:(Class)class {
    NSLog(@"%s%@",__func__,NSStringFromClass(class_getSuperclass(class)));
}

/**
 *  获取实例大小
 *
 *  @param class 类
 */
- (void)class_getInstanceSize:(Class)class {
   // NSLog(@"%s%zu",__func__,class_getInstanceSize(class));
    NSLog(@"%s%zu",__func__,class_getInstanceSize(class));
}

/**
 *  获取类中指定名称实例成员变量的信息
 *
 *  @param class 类
 *  @param name  成员变量名
 */
- (void)class_getInstanceVariable:(Class)class name:(const char *)name {
    Ivar ivar = class_getInstanceVariable(class, name);
    NSLog(@"%s%s%s", __func__,[self ivar_getTypeEncoding:ivar],[self ivar_getName:ivar]);
}

/**
 *  获取类方法的信息
 *
 *  @param class    类
 *  @param selector 方法
 */
+ (Method)class_getClassMethod:(Class)class selector:(SEL)selector {
    Method method = class_getClassMethod(class, selector);
    NSLog(@"%s%s%u",__func__,sel_getName(method_getName(method)) ,method_getNumberOfArguments(method));
    return method;
}


#pragma mark - Property get
/**
 *  获取属性的信息(与获取成员变量信息类似，不同的是不用打_)
 *
 *  @param class 类
 *  @param name  属性名
 */
- (void)class_getProperty:(Class)class name:(const char *)name {
    objc_property_t property = class_getProperty(class, name);
    NSLog(@"%s %s  ======= %s",__func__, property_getName(property), [self property_getAttributes:property]);
}

/**
 *  获取属性名
 *
 *  @param property 属性
 *
 *  @return 属性名
 */
- (const char *)property_getName:(objc_property_t)property {
    return property_getName(property);
}

- (const char *)property_getAttributes:(objc_property_t)property {
    return property_getAttributes(property);
}


#pragma mark - Ivar get
/**
 *  获取成员变量名
 *
 *  @param ivar 成员变量
 *
 *  @return 变量名
 */
- (const char *)ivar_getName:(Ivar)ivar {
    return ivar_getName(ivar);
}

/**
 *  获取成员变量类型编码
 *
 *  @param ivar 成员变量
 *
 *  @return 编码类型
 */
- (const char *)ivar_getTypeEncoding:(Ivar)ivar {
    return ivar_getTypeEncoding(ivar);
}


- (IBAction)testClick:(id)sender {
    
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
