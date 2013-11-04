LCFramework
===========
LCFramework是一个轻量级的iOS网络交互应用的开发框架；LCFramework的产生原因是为了简化代码、优化开发时间、数据集中管理等,一定程度上减少程序开发的工作量.

LCFramework的优点
===========

1.使用注入NSObject的方式来实现简化Http请求、NSNotificationCenter、NSTimer、HUD等等.

2.框架本身自带常用功能如:Log、崩溃日志、版本检查、IAP、国际化、Debugger等等.

3.封装了常用UI使其更好用!如上下拉刷新等。

LCFramework的构成
===========

 LC.h (全局头文件)

 LC_Precompile.h (预编译)

 LC_Tools.h (常用宏定义)

 LC_UIApplicationSkeletion.h (使Appdelegate继承该类用以自行管理)

 Foundation文件夹 
  (Log、崩溃日志、沙盒目录、版本检查、IAP、系统信息、FileManager、UserDefaults、内存缓存管理、文件缓存管理、Debugger、国际化、以及各种类目等.)
 
 View文件夹 (LCFramework自带控件以及类目等.)
 
 Animation文件夹 (动画以及动画队列以及类目等.)
 
 Network文件夹 (网络请求的封装以及类目等.)
 
 Audio文件夹 (音频管理,包括背景音以及震动等.)
 
 External文件夹 (三方文件ASIHttp、FMDB、JSONKit、OpenUDID、MBProgressHUD)
 
 LCFramework的简单使用
===========

1.在XXX-Prefix.pch预编译文件中引入LC.h

2.添加Frameworks SystemConfiguration.framework、libsqlite3.dylib、CFNetwork.framework、libz.dylib

LC_Precompile.h中提供如下设置

   #define LC_LOG_ENABLE		         (1)	// 是否打开LOG

   #define LC_LOG_SHOW_FIRST_LINE  (1) // 是否打印框架信息

   #define LC_CRASH_REPORT         (1) // 是否打开崩溃记录

   #define LC_IAP_ENABLE           (1) // 是否打开内购模块 开启后需要引入StoreKit.framework

   #define LC_DEBUG_ENABLE         (1) // 是否打开DEBUG工具 三指上划开启或下划关闭


Example http request : 

        1.在任意处直接调用 如 :  
        
        self.GET(@"http://m.weather.com.cn/data/101010100.html") setWhenUpdate:^(LC_HTTPRequest * req){
        
              if (request.succeed) {
        
                   [self setDatasource:[request.jsonData objectForKey:@"weatherinfo"] key:___ds1];
        
                   [self endLoading];
           
              }else if (request.failed){
        
                   [self endLoading];
        
              }else if (request.cancelled){

              }
        }
       
Example use "NotificationCenter" : 

        1.注册一个消息,在适当的位置直接调用 如 : [self observeNotification:UIApplicationDidFinishLaunchingNotification];
        2.直接实现方法 -(void) handleNotification:(NSNotification *)notification

        -(void) handleNotification:(NSNotification *)notification
        {
               if ([notification is:UIApplicationDidFinishLaunchingNotification]){
               {
                  NSLog(@"ok");
               }
        }
        
        3.解除消息注册 : [self unobserveNotification:UIApplicationDidFinishLaunchingNotification]; 或者 [self unobserveAllNotifications];

Example 给一个TableViewController增加下拉刷新功能 : 

        1.创建一个ViewController类并继承LC_UITableViewController.
        2.在viewDidLoad中直接添加代码 : 
        
            __block CustomViewController * nRetainSelf = self;
        
            [self setPullStyle:LC_PULL_STYLE_HEADER
               backgroundStyle:LC_PULL_BACK_GROUND_STYLE_COLORFUL
             beginRefreshBlock:^(LC_UIPullLoader * pullLoader ,LC_PULL_DIRETION diretion){

                 [nRetainSelf performSelectorInBackground:@selector(loadData) withObject:nil];
                 
             }];
             
