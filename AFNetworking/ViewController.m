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
    
    [HttpManager download:@"http://v1.mycs.cn/48/4893/27843/Oz0zOD5yNiI.mp4" downloadProgress:^(NSProgress *progress) {
        
        NSLog(@"%@",progress.localizedDescription);
        
    } completeHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
    }];
}

@end
