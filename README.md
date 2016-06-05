### HttpManager

HttpManager是对AFN3.0框架进行封装的网络层工具类。

新特性：

1. AFNetwork3.0进行封装,简单的实现了Get、Post请求、上传图片、下载的功能。
2. 集成对网络的监听。
3. 实用YYCache框架对请求的数据进行缓存，当判断没有网络的时候会从数据库中获取缓存数据。

#### 网络监听

在程序启动的时候开启对网络变化的监听，在必要的时候注册网络变化的通知kReachabilityChangedNotification

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	    
	    //开启网络监控
	    [ShareHttpManager startNotifierReachability];
	    
	    return YES;
	}
	
	    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

	
实时获取当前的网络状态。

	//获取当前的网络状态
	NetworkStatus status = [ShareHttpManager.reach currentReachabilityStatus];

#### 数据缓存

数据缓存的实现:在网络请求前判断当前的网络,如果当前没有网络，则通过（URL+参数值）的MD5做为key从本地数据库获取缓存数据。在有网络的情况下，通过（URL+参数值）的MD5做为key将获取到的数据保存到本地数据库。

	+ (void)BPOSTWithCache:(NSString *)urlString parameters:(id)params success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	+ (void)BPOSTWithCache:(NSString *)urlString parameters:(id)params requestProgress:(RequestProgress)progress success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	+ (void)BGETWithCache:(NSString *)urlString parameters:(id)params success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	+ (void)BGETWithCache:(NSString *)urlString parameters:(id)params requestProgress:(RequestProgress)progress success:(SuccessResponse)success failure:(FailureResponse)failure;


#### API
	
	#import <Foundation/Foundation.h>
	#import "AFNetworking.h"
	#import "Reachability.h"
	
	#define ShareHttpManager [HttpManager shareHttpManager]
	#define kReachabilityStatusChange @"kReachabilityStatusChange"
	
	typedef void(^SuccessResponse)(NSURLSessionDataTask *task,id responseObject);
	typedef void(^FailureResponse)(NSURLSessionDataTask *task,NSError *error);
	typedef void(^RequestProgress)(NSProgress *progress);
	typedef void(^DownloadHandler)(NSURLResponse *response, NSURL *filePath, NSError *error);
	
	@interface HttpManager : AFHTTPSessionManager
	
	//默认开启网络监听
	@property (nonatomic,strong) Reachability *reach;
	
	+ (instancetype)shareHttpManager;
	
	#pragma mark - Get请求
	//没有缓存Get请求
	+ (void)BGET:(NSString *)urlString parameters:(id)params success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	+ (void)BGET:(NSString *)urlString parameters:(id)params requestProgress:(RequestProgress)progress success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	//有缓存的请求
	+ (void)BGETWithCache:(NSString *)urlString parameters:(id)params success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	+ (void)BGETWithCache:(NSString *)urlString parameters:(id)params requestProgress:(RequestProgress)progress success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	#pragma mark - Post请求
	//没有缓存的Post请求
	+ (void)BPOST:(NSString *)urlString parameters:(id)params success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	+ (void)BPOST:(NSString *)urlString parameters:(id)params requestProgress:(RequestProgress)progress success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	//没有缓存的Post请求
	+ (void)BPOSTWithCache:(NSString *)urlString parameters:(id)params success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	+ (void)BPOSTWithCache:(NSString *)urlString parameters:(id)params requestProgress:(RequestProgress)progress success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	#pragma mark - 其他请求
	// 文件下载
	+ (NSURLSessionDownloadTask *)download:(NSString *)urlString downloadProgress:(RequestProgress)progress completeHandler:(DownloadHandler)handler;
	
	//图片上传
	+ (NSURLSessionDataTask *)uploadImage:(NSString *)urlString parameters:(id)params imageArray:(NSArray *)images uploadProgress:(RequestProgress)progress success:(SuccessResponse)success failure:(FailureResponse)failure;
	
	//取消请求
	+ (void)httpCancelAllRequest;
	
	#pragma mark - 网络监听
	- (void)startNotifierReachability;
	
	- (void)stopNotifierReachability;

@end
