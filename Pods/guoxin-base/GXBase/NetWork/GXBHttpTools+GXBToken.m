//
//  GXBHttpTools+GXBToken.m
//  GXBaseExample
//
//  Created by Vision on 2017/4/13.
//  Copyright © 2017年 guoxin. All rights reserved.
//

#import "GXBHttpTools+GXBToken.h"
#import "NSString+GXBDevice.h"

#define GXB_DEVICE_TOKEN @"GXB_DEVICE_TOKEN"
#define GXB_AUTH_TOKEN @"GXB_AUTH_TOKEN"
#define GXB_IDENTIFY_TOKEN @"GXB_IDENTIFY_TOKEN"

@implementation GXBHttpTools (GXBToken)

#pragma mark - devicetoken
//获取devicetoken
- (NSString *)getDeviceToken {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:GXB_DEVICE_TOKEN]) {
        [self setCommonHttpHeaders:@{@"device-token" :[[NSUserDefaults standardUserDefaults] objectForKey:GXB_DEVICE_TOKEN]}];
        return [[NSUserDefaults standardUserDefaults] objectForKey:GXB_DEVICE_TOKEN];
    }
    
    NSString *paramString =
    [NSString stringWithFormat:@"id=%@&type=%@&system=%@&systemVersion=%@&appVersion=%@",
     [NSString gxb_deviceUUID],
     [NSString gxb_deviceModel],
     [NSString gxb_deviceName],
     [NSString gxb_deviceSystemVersion],
     [NSString gxb_deviceAppVersion]];
    NSData *ParamData = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *DeviceRegisteUrl =nil;
    NSString *baseUrl = self.mainHostUrl;
    
    if([baseUrl rangeOfString:@"http"].location==NSNotFound)//_roaldSearchText
    {
        DeviceRegisteUrl=[NSURL URLWithString:[NSString stringWithFormat:@"https://%@%@",baseUrl,@"/device/register"]];
    }else{
        
        DeviceRegisteUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,@"/device/register"]];
        
    }
    NSMutableURLRequest *UrlQuest = [NSMutableURLRequest requestWithURL:DeviceRegisteUrl];
    [UrlQuest setHTTPMethod:@"POST"];
    [UrlQuest setHTTPBody:ParamData];
    NSURLResponse *response = nil;
    NSError *error = nil;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSData *data =  [NSURLConnection sendSynchronousRequest:UrlQuest returningResponse:&response error:&error];
#pragma clang diagnostic pop
    
    if (!data) {
        return nil;
    }
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    int status = [(NSNumber *)dict[@"success"] intValue];
    
    if (status == 1) {
        
        NSString *device_token = dict[@"value"];
        NSMutableString *newdevice_token = [[NSMutableString alloc] initWithCapacity:device_token.length];
        for (NSInteger i = device_token.length - 1; i >=0 ; i--) {
            unichar ch = [device_token characterAtIndex:i];
            [newdevice_token appendFormat:@"%c", ch];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newdevice_token forKey:GXB_DEVICE_TOKEN];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self setCommonHttpHeaders:@{@"device-token" :[[NSUserDefaults standardUserDefaults] objectForKey:GXB_DEVICE_TOKEN]}];
        return newdevice_token;
    }
    return nil;
    
}
//删除devicetoken
- (void)deleteDeviceToken {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:GXB_DEVICE_TOKEN];
}

#pragma mark - x-auth-token
//获取x-auth-token
- (NSString *)getXAuthToken {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:GXB_AUTH_TOKEN];
    !token ?:[self setCommonHttpHeaders:@{@"x-auth-token" : token}];
    return token;
}
//设置x-auth-token
- (void)saveXAuthToken:(NSString *)token {
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:GXB_AUTH_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
//删除x-auth-token
- (void)deleteXAuthToken {
    
    [self setCommonHttpHeaders:@{@"x-auth-token" : @""}];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:GXB_AUTH_TOKEN];
}
#pragma mark - X-IDENTIFY-TOKEN
//获取X-IDENTIFY-TOKEN
- (NSString *)getXIdentifyToken {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:GXB_IDENTIFY_TOKEN];
    
    !token ?: [self setCommonHttpHeaders:@{@"X-IDENTIFY-TOKEN": token}];
    return token;
}
//设置X-IDENTIFY-TOKEN
- (void)saveXIdentifyToken:(NSString *)token {
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:GXB_IDENTIFY_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
//删除X-IDENTIFY-TOKEN
- (void)deleteXIdentifyToken {
    
    [self setCommonHttpHeaders:@{@"X-IDENTIFY-TOKEN": @""}];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:GXB_IDENTIFY_TOKEN];
}

@end
