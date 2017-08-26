//
//  ViewController.m
//  xdl
//
//  Created by hbd on 2017/8/25.
//  Copyright © 2017年 hbd. All rights reserved.
//

#import "ViewController.h"
#import "SingleSDK.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//商户主扫
-(IBAction)scanButtonEvent:(UIButton *)sender{
 
    //[PaySDKModel ]
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"显示的标题" message:@"标题的提示信息" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确认");
    }]];
    
   [self presentViewController:alertController animated:YES completion:nil];
    
}

-(SDKPayModel *)getPayModel{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PropertyList" ofType:@"plist"];
    NSMutableDictionary *data2 = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    //NSString *orgNo = [data2 valueForKeyPath:@"xdl.orgNo"];
    
    SDKPayModel *model = [[SDKPayModel alloc]init];
    model.orgNo = [data2 valueForKeyPath:@"xdl.orgNo"];//@"1278";
    model.mercId =[data2 valueForKeyPath:@"xdl.mercId"];// @"800110000000207";
    model.trmNo = [data2 valueForKeyPath:@"xdl.trmNo"];//@"95011514";
    model.trmTyp = [[data2 valueForKeyPath:@"xdl.trmTyp"] intValue] ;//1;
    model.oprId = [data2 valueForKeyPath:@"xdl.oprId"];//@"001";
    model.txnTime = [self getNowTimestamp];
    
    return model;
}

//客户主扫
-(IBAction)QRCoderPay:(UIButton *)sender{
    
    SDKPayModel *model = [self getPayModel];
    PayChannel payChannel = WXPAY;
    NSString *orderNo = [NSString stringWithFormat:@"950115140%@",[self getNowTimestamp]];
    
    
    
    [SingleSDK postSdkBarcodePosPayWithPayModel:model
                                      AndAmount:@"1"
                                AndTotal_Amount:@"1"
                                  AndPayChannel:payChannel
                                     AndSubject:@"title"
                                  AndSelOrderNo:orderNo
                                   AndGoods_tag:@"红板凳测试数据"
                                      AndAttach:@"附加数据"
                                        success:^(id data) {
                                            NSLog(@"成功 : %@",data);
                                            NSString *payCode = data[@"payCode"];
                                            
                                            NSDictionary *dict =@{};
                                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:payCode] options:dict completionHandler:^(BOOL success) {
                                                NSLog(@"操作成功");
                                            }];
                                        }
                                        failure:^(NSError *error, NSString *code, NSString *message) {
                                            NSLog(@"失败 : %@",message);
                                        }];
}


- (NSString *)getNowTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYYMMddHHmmss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间
    
    
    
    NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    
    return [formatter stringFromDate:datenow];
    //时间转时间戳的方法:
    //
    //
    //
    //    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    //
    //
    //
    //    NSLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
    //
    //
    //    
    //    return timeSp;
    
}


@end