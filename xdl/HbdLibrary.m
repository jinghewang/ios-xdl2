//
//  WZKPerson.m
//  xdl
//
//  Created by hbd on 2017/8/27.
//  Copyright © 2017年 hbd. All rights reserved.
//

#import "HbdLibrary.h"
#import "SingleSDK.h"

@implementation HbdLibrary

-(void)Hello:(NSString *)msg{
    NSLog(@"msg:%@",msg);
}


-(NSString *)Hello2:(NSString *)msg{
    return msg;
}


-(SDKPayModel *)getPayModel{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PropertyList" ofType:@"plist"];
    NSMutableDictionary *data2 = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    //NSString *orgNo = [data2 valueForKeyPath:@"xdl.orgNo"];
    
    SDKPayModel *model = [[SDKPayModel alloc]init];
    model.orgNo = [data2 valueForKeyPath:@"xdl.orgNo"];//机构号;
    model.mercId =[data2 valueForKeyPath:@"xdl.mercId"];//商户号;
    model.trmNo = [data2 valueForKeyPath:@"xdl.trmNo"];//终端号;
    model.trmTyp = [[data2 valueForKeyPath:@"xdl.trmTyp"] intValue] ;//1;
    model.oprId = [data2 valueForKeyPath:@"xdl.oprId"];//@"001";
    model.txnTime = [self getNowTimestamp];
    
    return model;
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
