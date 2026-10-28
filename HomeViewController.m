#import "HomeViewController.h"
#import "SpamViewController.h"
#import "CreditsViewController.h"

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Butterfly";
    self.view.backgroundColor = [UIColor systemBackgroundColor];

    UILabel *title = [[UILabel alloc] init];
    title.text = @"Butterfly";
    title.font = [UIFont systemFontOfSize:42 weight:UIFontWeightBold];
    title.textAlignment = NSTextAlignmentCenter;
    title.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:title];

    UIStackView *stack = [[UIStackView alloc] init];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.spacing = 14;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stack];

    NSArray *items = @[@[@"IOS spam", @"ios"], @[@"Android spam", @"android"],
                       @[@"Windows spam", @"windows"], @[@"All", @"all"]];
    for (NSArray *item in items) {
        UIButton *b = [UIButton buttonWithType:UIButtonTypeSystem];
        [b setTitle:item[0] forState:UIControlStateNormal];
        b.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        b.backgroundColor = [UIColor secondarySystemBackgroundColor];
        b.layer.cornerRadius = 10;
        b.tag = [items indexOfObject:item];
        [b.heightAnchor constraintEqualToConstant:52].active = YES;
        [b addTarget:self action:@selector(openSpam:) forControlEvents:UIControlEventTouchUpInside];
        [stack addArrangedSubview:b];
    }

    UIButton *credits = [UIButton buttonWithType:UIButtonTypeSystem];
    [credits setTitle:@"Credits" forState:UIControlStateNormal];
    credits.titleLabel.font = [UIFont systemFontOfSize:18];
    [credits addTarget:self action:@selector(openCredits) forControlEvents:UIControlEventTouchUpInside];
    credits.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:credits];

    [NSLayoutConstraint activateConstraints:@[
        [title.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:40],
        [title.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [stack.topAnchor constraintEqualToAnchor:title.bottomAnchor constant:40],
        [stack.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:30],
        [stack.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-30],
        [credits.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-20],
        [credits.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
}

- (void)openSpam:(UIButton *)sender {
    SpamViewController *vc = [SpamViewController new];
    vc.mode = sender.tag;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)openCredits {
    [self.navigationController pushViewController:[CreditsViewController new] animated:YES];
}
@end
