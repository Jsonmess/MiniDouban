/*
 公共类
*/
//如果宏存在结果等式，切记一定要加括号
//判断是否是iPhone5等4.0英寸屏幕设备
#define iPhone5_and_later ([UIScreen mainScreen].bounds.size.height==568)
//状态栏和导航栏高度
#define Kstatusbar_navi_height 64.0f
//这俩个宏需要指定，一个用于设置选项卡高度，一个设置选项卡中按钮的数量。
#define  Ktabbar_height 46
#define  kbutton_count 4
//MBProgress的背景颜色
#define KMBProgressBg [UIColor colorWithRed:190.0f/255.0f green:190.0f/255.0f blue:190.0f/255.0f alpha:1.0f]
//日志输出宏定义   用于在程序发布时候，自动过滤NSLog输出
#ifdef DEBUG
//调试状态
#define Debuglog(...) NSLog(__VA_ARGS__)
#else
//发布状态
#define Debuglog(...)
#endif