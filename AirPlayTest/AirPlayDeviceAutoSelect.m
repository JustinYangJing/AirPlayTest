//
//  AirPlayDeviceAutoSelect.m
//  CSleepNew
//
//  Created by JustinYang on 7/15/16.
//  Copyright © 2016 JustinYang. All rights reserved.
//

#import "AirPlayDeviceAutoSelect.h"
#import <objc/runtime.h>
@interface AirPlayDeviceAutoSelect ()
@property (nonatomic,strong) id routerController;
@end
@implementation AirPlayDeviceAutoSelect

-(void)setDeviceName:(NSString *)deviceName{
    _deviceName = deviceName;
    if (!_routerController) {
        Class MPAVRoutingController = NSClassFromString(@"MPAVRoutingController");
        self.routerController = [[MPAVRoutingController alloc] init];
        [self.routerController setValue:self forKey:@"delegate"];
        [self.routerController setValue:[NSNumber numberWithLong:2] forKey:@"discoveryMode"];
    }
}

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

-(void)dealloc{
    NSLog(@"%s",__func__);
}
@end
