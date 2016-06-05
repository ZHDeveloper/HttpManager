# HttpManager
AFNetwork3.0进行封装,简单的实现了Get、Post请求、上传图片、下载的功能。

	//
	//  HttpManager.h
	//  AFNetworking
	//
	//  Created by AdminZhiHua on 16/6/1.
	//  Copyright © 2016年 AdminZhiHua. All rights reserved.
	//
	
	#import <Foundation/Foundation.h>
	#import "AFNetworking.h"
	
	typedef void(^SuccessResponse)(NSURLSessionDataTask *task,id responseObject);
	typedef void(^FailureResponse)(NSURLSessionDataTask *task,NSError *error);
	typedef void(^RequestProgress)(NSProgress *progress);
	typedef void(^DownloadHandler)(NSURLResponse *response, NSURL *filePath, NSError *error);
	
	@interface HttpManager : AFHTTPSessionManager
	
	+ (instancetype)shareHttpManager;
	
	//Get请求
	+ (void)BGET:(NSString *)urlString parameters:(id)params success:(SuccessResponse)success failure:(FailureResponse)failure;
	//带参数的Get请求
	+ (void)BGET:(NSString *)urlString parameters:(id)params requestProgress:(RequestProgress)progress success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	//Post请求
	+ (void)BPOST:(NSString *)urlString parameters:(id)params success:(SuccessResponse)success failure:(FailureResponse)failure;
	//带参数的Post请求
	+ (void)BPOST:(NSString *)urlString parameters:(id)params requestProgress:(RequestProgress)progress success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	// 文件下载
	+ (NSURLSessionDownloadTask *)download:(NSString *)urlString downloadProgress:(RequestProgress)progress completeHandler:(DownloadHandler)handler;
	
	//图片上传
	+ (NSURLSessionDataTask *)uploadImage:(NSString *)urlString parameters:(id)params imageArray:(NSArray *)images uploadProgress:(RequestProgress)progress success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	//取消请求
	+ (void)httpCancelAllRequest;
	
	@end
