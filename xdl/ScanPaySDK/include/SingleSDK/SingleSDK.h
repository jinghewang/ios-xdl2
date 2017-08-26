//
//  SingleSDK.h
//  SingleSDK
//
//  Created by 灬尕鱼 on 2017/6/26.
//  Copyright © 2017年 com.newlandcomputer.app. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDKPayModel.h"

/**
 全局支付方式
 
 - ALIPAY: 支付宝
 - WXPAY: 微信
 - YLPAY: 银联
 */
typedef NS_ENUM(NSInteger, PayChannel) {
    ALIPAY = 0,
    WXPAY = 1,
    YLPAY = 2,
};

@interface SingleSDK : NSObject


/**
 初始化SDK 的key

 @param key 申请的key
 */
+ (void)initWithKey:(NSString *)key;

/**
 扫码支付-商户主扫
 
 @param model 公共参数model
 @param amount 实付金额（以分为单位，如1元表示为100）
 @param total_amount 订单总金额（以分为单位，如1元表示为100）
 @param authCode （扫码支付授权码，设备读取用户微信或支付宝中的条码或者二维码信息）
 @param payChannel 支付渠道（支付宝:ALIPAY，微信:WXPAY，银联:YLPAY）
 @param subject 订单标题
 @param selOrderNo 订单号
 @param goods_tag 订单优惠说明
 @param attach 附加数据
 */
+ (void) postSdkBarcodePayWithPayModel:(SDKPayModel *)model
                             AndAmount:(NSString *)amount
                       AndTotal_Amount:(NSString *)total_amount
                           AndAuthCode:(NSString *)authCode
                         AndPayChannel:(PayChannel)payChannel
                            AndSubject:(NSString *)subject
                         AndSelOrderNo:(NSString *)selOrderNo
                          AndGoods_tag:(NSString *)goods_tag
                             AndAttach:(NSString *)attach
                               success:(void (^)(id))success
                               failure:(void (^)(NSError *, NSString *, NSString *))failure;

/**
 扫码支付-客户主扫
 
 @param model 公共参数model
 @param amount 实付金额（以分为单位，如1元表示为100）
 @param total_amount 订单总金额（以分为单位，如1元表示为100）
 @param payChannel 支付渠道（支付宝:ALIPAY，微信:WXPAY，银联:YLPAY）
 @param subject 订单标题
 @param selOrderNo 订单号
 @param goods_tag 订单优惠说明
 @param attach 附加数据
 */
+ (void) postSdkBarcodePosPayWithPayModel:(SDKPayModel *)model
                                AndAmount:(NSString *)amount
                          AndTotal_Amount:(NSString *)total_amount
                            AndPayChannel:(PayChannel)payChannel
                               AndSubject:(NSString *)subject
                            AndSelOrderNo:(NSString *)selOrderNo
                             AndGoods_tag:(NSString *)goods_tag
                                AndAttach:(NSString *)attach
                                  success:(void (^)(id))success
                                  failure:(void (^)(NSError *, NSString *, NSString *))failure;

/**
 退款
 
 @param model 公共参数model
 @param orderNo 支付渠道订单号
 @param txnAmt 退款金额
 */
+ (void) postSdkRefundBarcodePayWithPayModel:(SDKPayModel *)model
                                  AndOrderNo:(NSString *)orderNo
                                   AndTxnAmt:(NSString *)txnAmt
                                     success:(void (^)(id))success
                                     failure:(void (^)(NSError *, NSString *, NSString *))failure;

/**
 订单查询
 
 @param model 公共参数model
 @param qryNo 查询流水（可根据logNo、orderNo、tradeNo的值做查询）
 */
+ (void) postSdkQryBarcodePayWithPayModel:(SDKPayModel *)model
                                 AndQryNo:(NSString *)qryNo
                                  success:(void (^)(id))success
                                  failure:(void (^)(NSError *, NSString *, NSString *))failure;
@end
