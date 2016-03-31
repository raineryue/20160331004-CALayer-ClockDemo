//
//  ViewController.m
//  20160331004-CALayer-ClockDemo
//
//  Created by Rainer on 16/3/31.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "ViewController.h"

#define kClockW self.clockImageView.image.size.width
// 秒针每秒走6度
#define kSecondAngle 6
// 分针每分走6度
#define kMinuteAngle 6
// 时针每时走30度
#define kHourAngle 30
// 每分钟时针走0.5度
#define kMinuteHourAngle 0.5
// 角度值转弧度值
#define angle2radion(angle) ((angle) / 180.0 * M_PI)

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *clockImageView;

@property (nonatomic, strong) CALayer *secondLayer;
@property (nonatomic, strong) CALayer *minuteLayer;
@property (nonatomic, strong) CALayer *hourLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加时针
    [self setupHourLayer];
    
    // 添加分针
    [self setupMinuteLayer];
    
    // 添加秒针
    [self setupSecondLayer];
    
    // 添加定时器并设置监听方法
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRunAction:) userInfo:nil repeats:YES];
    
    // 手动开启一次事件监听
    [self timerRunAction:nil];
}

/**
 *  添加秒针
 */
- (void)setupSecondLayer {
    self.secondLayer = [[CALayer alloc] init];
    
    self.secondLayer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    self.secondLayer.anchorPoint = CGPointMake(0.5, 0.9);
    self.secondLayer.backgroundColor = [UIColor redColor].CGColor;
    self.secondLayer.bounds = CGRectMake(0, 0, 1, kClockW * 0.5 - 10);
    
    [self.clockImageView.layer addSublayer:self.secondLayer];
}

/**
 *  添加分针
 */
- (void)setupMinuteLayer {
    self.minuteLayer = [[CALayer alloc] init];
    
    self.minuteLayer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    self.minuteLayer.anchorPoint = CGPointMake(0.5, 0.95);
    self.minuteLayer.backgroundColor = [UIColor blueColor].CGColor;
    self.minuteLayer.bounds = CGRectMake(0, 0, 3, kClockW * 0.5 - 20);
    
    [self.clockImageView.layer addSublayer:self.minuteLayer];
}

/**
 *  添加时针
 */
- (void)setupHourLayer {
    self.hourLayer = [[CALayer alloc] init];
    
    self.hourLayer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    self.hourLayer.anchorPoint = CGPointMake(0.5, 0.95);
    self.hourLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.hourLayer.bounds = CGRectMake(0, 0, 4, kClockW * 0.5 - 35);
    self.hourLayer.cornerRadius = 4;
    
    [self.clockImageView.layer addSublayer:self.hourLayer];
}

/**
 *  定时器事件监听方法
 */
- (void)timerRunAction:(NSTimer *)timer {
    // 1.获取当前的日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 2.从日历对象中获取日期组件
    NSDateComponents *dateComponents = [calendar components:kCFCalendarUnitSecond | kCFCalendarUnitMinute | kCFCalendarUnitHour fromDate:[NSDate date]];
    
    // 3.设置时分秒针分别旋转
    // 3.1.设置秒针旋转
    // 3.1.1.从日期组件中获取当前秒
    NSInteger currentSecond = dateComponents.second;
    
    // 3.1.2.计算秒针的弧度值
    CGFloat secondAngle = currentSecond * angle2radion(kSecondAngle);
    
    // 3.1.3.设置秒针旋转
    self.secondLayer.transform = CATransform3DMakeRotation(secondAngle, 0, 0, 1);
    
    // 3.2.1.从日期组件中获取当前分
    NSInteger currentMinute = dateComponents.minute;
    
    // 3.2.1.计算分针的弧度值
    CGFloat minuteAngle = currentMinute * angle2radion(kMinuteAngle);
    
    // 3.2.1.设置分针旋转
    self.minuteLayer.transform = CATransform3DMakeRotation(minuteAngle, 0, 0, 1);
    
    // 3.2.1.从日期组件中获取当前时
    NSInteger currentHour = dateComponents.hour;
    
    // 3.2.1.计算时针的弧度值
    CGFloat hourAngle = currentHour * angle2radion(kHourAngle)  + currentMinute * angle2radion(kMinuteHourAngle);
    
    // 3.2.1.设置时针旋转
    self.hourLayer.transform = CATransform3DMakeRotation(hourAngle, 0, 0, 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
