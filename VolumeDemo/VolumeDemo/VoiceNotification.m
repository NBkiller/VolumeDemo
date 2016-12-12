//
//  VoiceNotification.m
//  GuaGuaDriver
//
//  Created by Wei Wei(weiwei106@sunfit.cn) on 16/10/12.
//  Copyright © 2016年 LeoChen. All rights reserved.
//

#import "VoiceNotification.h"
#import <MediaPlayer/MediaPlayer.h>


@interface VoiceNotification()

/** 系统声音 */
@property (nonatomic, strong) MPVolumeView *volumeView;

@end


@implementation VoiceNotification

#pragma mark - xxx

+(VoiceNotification *)sharedInstance{
    static VoiceNotification *voiceNoti;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        voiceNoti = [[self alloc]init];
    });
    
    return voiceNoti;
}

- (MPVolumeView *)volumeView
{
    if (!_volumeView) {
        _volumeView = [[MPVolumeView alloc] init];
        _volumeView.frame = CGRectMake(-1000, -1000, 10, 10);
        _volumeView.showsVolumeSlider = NO;
        _volumeView.showsRouteButton = NO;
    }
    return _volumeView;
}


//发车通知：start_trip_noti
//新增乘客订单：new_order_noti
//乘客/系统 取消订单：order_canceled_noti
//申请取消被拒绝：order_cancel_refused_noti

- (void)playVoiceWithNoti:(NSString *)notiName{
    
     AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动
    // 1.初始化播放器需要指定音乐文件的路径
    NSString *path = [[NSBundle mainBundle]pathForResource:notiName ofType:@"mp3"];
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    if ([fileManager fileExistsAtPath:path]) {
        // 2 将路径字符串转换成url，从本地读取文件，需要使用fileURL
        NSURL *url = [NSURL fileURLWithPath:path];
        // 3.初始化背景音乐播放器
        _voiceNotiPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        // 4.准备播放
        [_voiceNotiPlayer prepareToPlay];
        [_voiceNotiPlayer setVolume:1.0];
        [_voiceNotiPlayer setNumberOfLoops:100];
        
        [self setSystemVolumSliderValue:0.5];//不管当前 系统音量是多少 ，每次播放 我就把它设置为0.5

        // 5.开始播放
        [_voiceNotiPlayer play];
    }
}

#pragma mark - 音量控制
/*
 *获取系统音量滑块
 */
-(void)setSystemVolumSliderValue:(double)value{
    static UISlider * volumeViewSlider = nil;
    if (volumeViewSlider == nil) {
        for (UIView* newView in self.volumeView.subviews) {
            
            if ([newView.class.description isEqualToString:@"MPVolumeSlider"]){
                volumeViewSlider = (UISlider*)newView;
                break;
            }
        }
    }
    volumeViewSlider.value = value;
}




@end
