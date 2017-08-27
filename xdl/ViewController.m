//
//  ViewController.m
//  xdl
//
//  Created by hbd on 2017/8/25.
//  Copyright © 2017年 hbd. All rights reserved.
//

#import "ViewController.h"
#import "SingleSDK.h"
#import "lhScanQCodeViewController.h"
#import "HbdLibrary.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

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


//测试弹出框
-(IBAction)helloButtonEvent:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"显示的标题" message:@"标题的提示信息" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.label.text = @"取消";
        NSLog(@"点击取消");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.label.text = @"点击确认";
        NSLog(@"点击确认");
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


//商户主扫
-(IBAction)scanButtonEvent:(UIButton *)sender{
    lhScanQCodeViewController *sqVC = [[lhScanQCodeViewController alloc]init];
    sqVC.payChannel = WXPAY;
    
    UINavigationController * nVC = [[UINavigationController alloc]initWithRootViewController:sqVC];
    [self presentViewController:nVC animated:YES completion:^{
        
    }];
}



//客户主扫
-(IBAction)QRCoderPay:(UIButton *)sender{
    
    SDKPayModel *model = [[HbdLibrary alloc] getPayModel];
    PayChannel payChannel = WXPAY;
    NSString *orderNo = [NSString stringWithFormat:@"950115140%@",[[HbdLibrary alloc] getNowTimestamp]];
    
    
    
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

@end
