#import <Foundation/Foundation.h>
@interface SpamEngine : NSObject
+ (instancetype)shared;
- (void)startMode:(NSInteger)mode;
- (void)stop;
@end
