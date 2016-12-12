//
//  oneViewController.m
//  VolumeDemo
//
//  Created by mlrc on 2016/12/8.
//  Copyright © 2016年 Tmp. All rights reserved.
//

#import "oneViewController.h"
#import "VoiceNotification.h"


@interface oneViewController ()

@end

@implementation oneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(stopClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)stopClick
{
    [[VoiceNotification sharedInstance].voiceNotiPlayer stop];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //在这个 控制器里面 播放音乐 但是 声音 每次都调为 0.5 
    [[VoiceNotification sharedInstance] playVoiceWithNoti:@"order_cancel_succeed_noti"];
}

@end
