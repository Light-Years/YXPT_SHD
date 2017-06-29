//
//  UtilsMacro.h
//  PhoneSearch
//
//  Created by 王隆帅 on 15/5/20.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

/**
 *  本类放一些方便使用的宏定义
 */


#define YD_HISTORY_STORAGE @"yd_history_storage"

// ios7之上的系统
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)

// 获取屏幕 宽度、高度 bounds就是屏幕的全部区域
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define IS_IPHONE4 [UIScreen mainScreen].bounds.size.height == 480

// 获取当前屏幕的高度 applicationFrame就是app显示的区域，不包含状态栏
#define kMainScreenHeight ([UIScreen mainScreen].applicationFrame.size.height)
#define kMainScreenWidth  ([UIScreen mainScreen].applicationFrame.size.width)

// 判断字段时候为空的情况
#define IF_NULL_TO_STRING(x) ([(x) isEqual:[NSNull null]]||(x)==nil)? @"":TEXT_STRING(x)
// 转换为字符串
#define TEXT_STRING(x) [NSString stringWithFormat:@"%@",x]

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

// 设置颜色RGB
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]
#define ImageNamed(name) [UIImage imageNamed:name]

// 下拉 有更多数据
#define LS_HEADER_REFRESH_HASMORE_DATA 1
// 下拉 无更多数据
#define LS_HEADER_REFRESH_NOMORE_DATA 2
// 上拉 有更多数据
#define LS_FOOTER_REFRESH_HASMORE_DATA 3
// 上拉 无更多数据
#define LS_FOOTER_REFRESH_NOMORE_DATA 4
// 刷新出错
#define LS_REFRESH_ERROR 5

// 每次请求列表 数据量
#define LS_REQUEST_LIST_COUNT @"10"
#define LS_REQUEST_LIST_NUM_COUNT 10

//登陆通用红色字体
#define CL_LOGIN_TEXT_COLOR_RED RGBACOLOR(225, 66, 88,1)


#define CL_COMMENT_BG_COLOR RGBCOLOR(216, 216, 216)
#define CL_DETAIL_BG_COLOR RGBCOLOR(236, 236, 236)

#define YC_DEFAULT_LOGO_IMAGE [UIImage imageNamed:@"ls_company_icon.png"]
#define YC_DEFAULT_SQUARE_IMAGE [UIImage imageNamed:@"ls_square_default.png"]
#define YC_DEFAULT_RECTANGLE_IMAGE [UIImage imageNamed:@"ls_rectangle_default.png"]

// coredata
#define CITY_LEVEL @"level"
#define CITY_ID @"yc_id"
#define CITY_PID @"yc_p_id"
#define CITY_NAME @"city"

#define PROFESSION_LEVEL @"level"
#define PROFESSION_ID @"yc_id"
#define PROFESSION_PID @"yc_p_id"
#define PROFESSION_NAME @"profession"

// 系统消息 和 公司反馈的时间
#define SYSTEM_MESSAGE_INDETIFIER @"systemMessageIndetifier"
#define COMPANY_MESSAGE_INDETIFIER @"companyMessageIndetifier"

#define LS_COMPANY_FACEVIEW_WIDTH (SCREENWIDTH - 30)/2.0

#define USER_ID @"user_id"
#define USER_PHONE @"user_phone"
// 1 有 2 无
#define USER_RESUME_IS_TRUE @"resumeIsTrue"

// 用户登录的所得字典
#define USER_LOGIN_INFO @"user_login_info"
// 1 成功 2 失败
#define USER_LOCATION_SUCCESS @"user_locaton_success"

#define IS_LOGIN (((NSString *)SEEKPLISTTHING(USER_ID)).length > 0)

//一级标题字体大小
#define H1_FONT HB14
//一级标题字体颜色
#define H1_COLOR black_color
//二级标题字体大小
#define H2_FONT H13
//二级标题字体颜色
#define H2_COLOR gray_color

#define YC_USER_ID IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(USER_ID)))
#define YC_USER_PHONE IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(USER_PHONE)))

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define YQY_MATERNALLINFANT_TOKEN SEEKPLISTTHING(USER_TOKEN)//@"a19679e8aac549b180c0e7c27bce6580"
#define GX_BGCOLOR COLOR(246, 246, 246, 1)











