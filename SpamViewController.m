#import "SpamViewController.h"
#import "SpamEngine.h"

@implementation SpamViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *names = @[@"IOS spam", @"Android spam", @"Windows spam", @"All"];
    self.title = names[self.mode];
    self.view.backgroundColor = [UIColor systemBackgroundColor];

    UIButton *start = [UIButton buttonWithType:UIButtonTypeSystem];
    [start setTitle:@"Start" forState:UIControlStateNormal];
    start.titleLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];
    start.backgroundColor = [UIColor systemGreenColor];
    [start setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    start.layer.cornerRadius = 12;
    start.translatesAutoresizingMaskIntoConstraints = NO;
    start.tag = 1;
    [start addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];

    UIButton *stop = [UIButton buttonWithType:UIButtonTypeSystem];
    [stop setTitle:@"Stop" forState:UIControlStateNormal];
    stop.titleLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];
    stop.backgroundColor = [UIColor systemRedColor];
    [stop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    stop.layer.cornerRadius = 12;
    stop.translatesAutoresizingMaskIntoConstraints = NO;
    stop.tag = 0;
    [stop addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stop];

    [NSLayoutConstraint activateConstraints:@[
        [start.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [start.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-40],
        [start.widthAnchor constraintEqualToConstant:200],
        [start.heightAnchor constraintEqualToConstant:56],
        [stop.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [stop.topAnchor constraintEqualToAnchor:start.bottomAnchor constant:20],
        [stop.widthAnchor constraintEqualToConstant:200],
        [stop.heightAnchor constraintEqualToConstant:56]
    ]];
}

- (void)toggle:(UIButton *)sender {
    if (sender.tag == 1) {
        [[SpamEngine shared] startMode:self.mode];
    } else {
        [[SpamEngine shared] stop];
    }
}
@end
