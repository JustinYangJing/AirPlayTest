
## AirPlay
>需求:绕过系统限制，自动选择支持`AirPlay`的设备

### Airplay基础知识
要调用出AirPlay列表需要使用到`MPVolumeView`控件，当系统检测到网络环境中有支持`AirPlay`的设备时才会出现`AirPlay`图标,用户点击这个图标，呼出支持`AirPlay`的设备列表。

	 MPVolumeView *volumView = [[MPVolumeView alloc] initWithFrame:CGRectMake(60, 100, 40, 40)];
    [volumView setRouteButtonImage:[UIImage imageNamed:@"pic-02"] forState:UIControlStateNormal];
    volumView.showsVolumeSlider = NO;
 `setRouteButtonImage `自定`义AirPlay`图标
 
### 自动选择AirPlay设备
自动选择AirPlay设备要使用了`MediaPlayer.framework`的私用类`MPAVRoutingController`，在[这里](http://developer.limneos.net/?ios=8.0&framework=MediaPlayer.framework&header=MPAVRoutingController.h)可以搜到iOS所有的`framework`的头文件。

	Class MPAVRoutingController = NSClassFromString(@"MPAVRoutingController");
    self.routerController = [[MPAVRoutingController alloc] init];
    [self.routerController setValue:self forKey:@"delegate"];
    [self.routerController setValue:[NSNumber numberWithLong:2] forKey:@"discoveryMode"];
>`NSClassFromString `获取`MPAVRoutingController `类定义，并通过KVC给它的属性赋值,`discoveryMode `为2时才能及时在`AirPlay`设备发生变化时触发它协议的`-(void)routingControllerAvailableRoutesDidChange:(id)arg1;`方法

	-(void)routingControllerAvailableRoutesDidChange:(id)arg1{
	    if (self.deviceName == nil) {
	        return;
	    }
	    NSArray *availableRoutes = [self.routerController valueForKey:@"availableRoutes"];
	    for (id router in availableRoutes) {
	        NSString *routerName = [router valueForKey:@"routeName"];
	        if ([routerName rangeOfString:self.deviceName].length >0) {
	            BOOL picked = [[router valueForKey:@"picked"] boolValue];
	            if (picked == NO) {
	                [self.routerController performSelector:@selector(pickRoute:) withObject:router];
	            }
	            return;
	        }
	    }
	}
	
>在`MPAVRoutingControllerDelegate`的`routingControllerAvailableRoutesDidChange`用代码来选择用户指定的`AirPlay`设备，如果用户想取消自动选择的功能，将deviceName属性赋值为nil即可。
 
