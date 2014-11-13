当前版本是0.1.1，已经更新到0.1.3，正在整理，耐心等候...


LCFramework
===========
LCFramework是一个轻量级的iOS网络交互应用的开发框架；LCFramework的产生原因是为了简化代码、优化开发时间、数据集中管理等，一定程度上减少程序开发的工作量.

介绍
===========

1.你可以把它当成一个框架，使用LC的特性进行快速开发，也可以把它当成一个工具集来辅助你现有的项目开发，因为LC并没有很大程度上改变现有的Objective-C的开发模式，同时会大量简化你的代码。

2.虽然LC的UI布局是线性的，没有autolayout封装，但你也可以使用系统或是第三方类库进行autolayout。

3.LC几乎有绝大部分Application所需要的功能。

4.强大的Debugger。

 Use LCFramwork
===========

1.在XXX-Prefix.pch预编译文件中引入LC.h

2.添加SystemConfiguration.framework、libsqlite3.dylib、CFNetwork.framework、libz.dylib

LC_Precompile.h中提供如下设置

   #define LC_LOG_ENABLE		         (1)	// 是否开启LOG

   #define LC_CRASH_REPORT         (1) // 是否开启崩溃记录

   #define LC_IAP_ENABLE           (1) // 是否开启内购模块 开启后需要引入StoreKit.framework

   #define LC_DEBUG_ENABLE         (1) // 是否开启DEBUG



Updata
===========

v0.1.3

1.新的Log样式

2.增加了LC_Observer

3.增加了LC_Binder

4.增加了UISingle

5.新的Debugger

6.等等......

v0.1.1

1.完美修正自定义Tabbar bug，与系统tabbar完美结合

2.增加了iOS7的滑动返回

3.增加了LC_Audio
