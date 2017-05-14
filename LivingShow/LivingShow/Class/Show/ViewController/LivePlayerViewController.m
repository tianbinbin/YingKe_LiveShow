//
//  LivePlayerViewController.m
//  LivingShow
//
//  Created by 田彬彬 on 2017/5/14.
//  Copyright © 2017年 田彬彬. All rights reserved.
//

#import "LivePlayerViewController.h"

#import <IJKMediaFramework/IJKMediaFramework.h>

@interface LivePlayerViewController ()

@property(atomic, retain) id<IJKMediaPlayback> player;              // 播放器
@property (nonatomic, strong) UIImageView * blurimagev;             // 毛玻璃
@property (nonatomic, strong) UIButton  * closeBtn;                 // 关闭按钮
@property (nonatomic, strong) LiveLiveChatViewController * chateVC; // 聊天


@end

@implementation LivePlayerViewController

-(UIButton *)closeBtn
{
    if(!_closeBtn)
    {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn sizeToFit];
        _closeBtn.frame = CGRectMake(SCREEN_WIDTH-_closeBtn.width-20, SCREEN_HEIGHT-_closeBtn.height-20, _closeBtn.width, _closeBtn.height);
        
    }
    return _closeBtn;
}


-(LiveLiveChatViewController *)chateVC
{
    if(!_chateVC)
    {
        _chateVC = [[LiveLiveChatViewController alloc]init];
        _chateVC.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    }
    return _chateVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"直播界面";
   
    [self initPalyer];
    
    [self initUI];
    
    [self addChildVC];
    
}

-(void)initPalyer
{
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    self.player =  [[IJKFFMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.urlStr] withOptions:options];
    
//    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    self.player.view.frame = self.view.bounds;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.player.shouldAutoplay = YES;    // 直接播放 拿到直播信号之后 直接播放
    
    self.view.autoresizesSubviews = YES;
    [self.view addSubview:self.player.view];
//    [self.view addSubview:self.mediaControl];
//    
//    self.mediaControl.delegatePlayer = self.player;
}


-(void)initUI{

    self.view.backgroundColor = [UIColor blackColor];
    self.blurimagev = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.blurimagev downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,self.imageStr] placeholder:@"psb"];
    
    [self.view addSubview:self.blurimagev];
    
    // 毛玻璃效果
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    // 创建毛玻璃视图
    UIVisualEffectView * ve = [[UIVisualEffectView alloc]initWithEffect:blur];
    ve.frame = self.blurimagev.bounds;
    
    // 毛玻璃视图加入图片
    [self.blurimagev addSubview:ve];
    
    
    UIWindow * window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    [window addSubview:self.closeBtn];
    
}

-(void)addChildVC
{
    [self addChildViewController:self.chateVC];
    [self.view addSubview:self.chateVC.view];
    
    [self.chateVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
        
    }];
    
    
}


-(void)closeAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //注册通知
    [self installMovieNotificationObservers];
    
    //准备播放
    [self.player prepareToPlay];
    
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // 关闭播放
    [self.player shutdown];
    
    // 移除通知
    [self removeMovieNotificationObservers];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden  = NO;
    
    [self.closeBtn removeFromSuperview];
}

#pragma mark Install Movie Notifications

/* Register observers for the various movie object notifications. */
-(void)installMovieNotificationObservers
{
    // 监听网络环境。监听缓冲
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    // 监听直播完成回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    // 监听用户主动操作
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}


- (void)loadStateDidChange:(NSNotification*)notification
{
    //    MPMovieLoadStateUnknown        = 0,       未知
    //    MPMovieLoadStatePlayable       = 1 << 0,  缓冲结束可以播放
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES。           缓冲结束自动播放
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started                            暂停
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    //    MPMovieFinishReasonPlaybackEnded,    直播结束
    //    MPMovieFinishReasonPlaybackError,    直播错误
    //    MPMovieFinishReasonUserExited        用户推出
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    //    MPMoviePlaybackStateStopped,      停止
    //    MPMoviePlaybackStatePlaying,      播放
    //    MPMoviePlaybackStatePaused,
    //    MPMoviePlaybackStateInterrupted,
    //    MPMoviePlaybackStateSeekingForward,
    //    MPMoviePlaybackStateSeekingBackward
    
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
    
    
    self.blurimagev.hidden = YES;
    [self.blurimagev removeFromSuperview];
}



#pragma mark Remove Movie Notification Handlers

/* Remove the movie notification observers from the movie object. */
-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}



@end
