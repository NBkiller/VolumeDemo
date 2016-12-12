//
//  ViewController.m
//  VolumeDemo
//
//  Created by MR.KING on 16/5/4.
//  Copyright © 2016年 Tmp. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VoiceNotification.h"
#import "oneViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[VoiceNotification sharedInstance] playVoiceWithNoti:@"order_cancel_succeed_noti"];
}
- (IBAction)stopClick:(id)sender {
    
    [[VoiceNotification sharedInstance].voiceNotiPlayer stop];
}


- (IBAction)buttonClick:(UIButton *)sender {
    
    oneViewController *next = [[oneViewController alloc] init];
    
    [self.navigationController pushViewController:next animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChange:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    
    
    [self.view addSubview:[self getSystemVolumSlider]];
    self.stepper.value = [self getSystemVolumValue];
    
    
}
- (IBAction)change:(UIStepper*)sender {
    [self setSysVolumWith:sender.value];
    self.slider.value = sender.value;
}
- (IBAction)slider:(UISlider*)sender {
    [self setSysVolumWith:sender.value];
    self.stepper.value = sender.value;
}

-(void)volumeChange:(NSNotification*)notifi{
    NSString * style = [notifi.userInfo objectForKey:@"AVSystemController_AudioCategoryNotificationParameter"];
    CGFloat value = [[notifi.userInfo objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] doubleValue];
    if ([style isEqualToString:@"Ringtone"]) {
        NSLog(@"铃声改变");
    }else if ([style isEqualToString:@"Audio/Video"]){
        NSLog(@"音量改变 当前值:%f",value);
        self.stepper.value = value;
        self.slider.value = value;
    }
}


#pragma mark - 音量控制
/*
 *获取系统音量滑块
 */
-(UISlider*)getSystemVolumSlider{
    static UISlider * volumeViewSlider = nil;
    if (volumeViewSlider == nil) {
        //在这里 把它添加到View上就能隐藏 ***************
        MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(100, 100, 200, 4)];
        volumeView.showsRouteButton = YES;
        volumeView.showsVolumeSlider = NO;
        [volumeView userActivity];
        [self.view addSubview:volumeView];
        
        for (UIView* newView in volumeView.subviews) {
            if ([newView.class.description isEqualToString:@"MPVolumeSlider"]){
                volumeViewSlider = (UISlider*)newView;
                break;
            }
        }
    }
    
    return volumeViewSlider;
}


/*
 *获取系统音量大小
 */
-(CGFloat)getSystemVolumValue{
    
    return [self getSystemVolumSlider].value;
}
/*
 *设置系统音量大小
 */
-(void)setSysVolumWith:(double)value{
    [self getSystemVolumSlider].value = value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
