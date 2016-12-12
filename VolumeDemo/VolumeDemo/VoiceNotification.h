//
//  VoiceNotification.h
//  GuaGuaDriver
//
//  Created by Wei Wei(weiwei106@sunfit.cn) on 16/10/12.
//  Copyright © 2016年 LeoChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface VoiceNotification : NSObject

+(VoiceNotification *)sharedInstance;

@property (nonatomic, strong) AVAudioPlayer *voiceNotiPlayer;

-(void)playVoiceWithNoti:(NSString *)notiName;


@end
