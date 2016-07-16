//
//  ViewController.m
//  AirPlayTest
//
//  Created by JustinYang on 5/14/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//
#define handleError(error)  if(error){ NSLog(@"%@",error); exit(1);}
#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <objc/runtime.h>
#import "AirPlayDeviceAutoSelect.h"
@interface ViewController ()
@property (nonatomic,strong) AirPlayDeviceAutoSelect *airplayPicker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MPVolumeView *volumView = [[MPVolumeView alloc] initWithFrame:CGRectMake(60, 100, 40, 40)];
    [volumView setRouteButtonImage:[UIImage imageNamed:@"pic-02"] forState:UIControlStateNormal];
    volumView.showsVolumeSlider = NO;
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:volumView];


    self.airplayPicker = [AirPlayDeviceAutoSelect new];
    self.airplayPicker.deviceName = @"X3";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end


