//
//  SDKPayModel.h
//  SingleSDK
//
//  Created by 刘姣姣 on 2017/6/27.
//  Copyright © 2017年 com.newlandcomputer.app. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 全局设备终端type
 * P - 智能POS
 * A - app扫码
 * C - PC端
 * T - 台牌扫码
 */
typedef NS_ENUM(NSInteger, TrmTyp) {
    P = 0,
    A = 1,
    C = 2,
    T = 3,
};

@interface SDKPayModel : NSObject

// 经度
@property (nonatomic, copy) NSString *longitude;

// 纬度
@property (nonatomic, copy) NSString *latitude;

// 机构号
@property (nonatomic, copy) NSString *orgNo;

// 商户号
@property (nonatomic, copy) NSString *mercId;

// 设备号
@property (nonatomic, copy) NSString *trmNo;

// 设备终端type
@property (nonatomic, assign) TrmTyp trmTyp;

// 设备端交易时间  eg: 20170527153245
@property (nonatomic, copy) NSString *txnTime;

// 操作员号
@property (nonatomic, copy) NSString *oprId;

@end
