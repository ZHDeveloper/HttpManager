//
//  ViewController.m
//  AFNetworking
//
//  Created by AdminZhiHua on 16/6/1.
//  Copyright © 2016年 AdminZhiHua. All rights reserved.
//

#import "ViewController.h"
#import "HttpManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"action"] = @"getRelationList";
    params[@"userId"] = @"580";
    params[@"adminTest"] = @"y";
    
    [HttpManager BGETWithCache:@"http://mycsapi.mycs.cn/ios/app/android/msgFriends.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)reachabilityChanged:(NSNotification *)noti {
    
    Reachability *reach = [noti object];
    
    NetworkStatus status = [reach currentReachabilityStatus];
    
    NSLog(@"%ld",(long)status);
}

@end
