#import "CreditsViewController.h"
#import <objc/runtime.h>

@implementation CreditsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Credits";
    self.view.backgroundColor = [UIColor systemBackgroundColor];

    UIScrollView *sv = [[UIScrollView alloc] init];
    sv.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:sv];

    UIStackView *stack = [[UIStackView alloc] init];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.spacing = 24;
    stack.alignment = UIStackViewAlignmentCenter;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [sv addSubview:stack];

    [stack addArrangedSubview:[self profileCard:@"mintoo" role:@"Main Developer"
        pfp:@"https://avatars.githubusercontent.com/u/210064350?v=4"
        url:@"https://github.com/noname7821"]];
    [stack addArrangedSubview:[self profileCard:@"LaFAirs" role:@"Made Windows spam"
        pfp:@"https://avatars.githubusercontent.com/u/330343932?v=4"
        url:@"https://github.com/noname7821"]];

    UILabel *real = [[UILabel alloc] init];
    real.text = @"Only https://github.com/noname7821/Butterfly is real!!!!!!!!!!!!";
    real.font = [UIFont systemFontOfSize:12];
    real.textColor = [UIColor secondaryLabelColor];
    real.textAlignment = NSTextAlignmentCenter;
    real.numberOfLines = 0;
    [stack addArrangedSubview:real];

    [NSLayoutConstraint activateConstraints:@[
        [sv.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [sv.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [sv.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [sv.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [stack.topAnchor constraintEqualToAnchor:sv.topAnchor constant:20],
        [stack.leadingAnchor constraintEqualToAnchor:sv.leadingAnchor constant:20],
        [stack.trailingAnchor constraintEqualToAnchor:sv.trailingAnchor constant:-20],
        [stack.widthAnchor constraintEqualToAnchor:sv.widthAnchor constant:-40]
    ]];
}

- (UIView *)profileCard:(NSString *)name role:(NSString *)role
                    pfp:(NSString *)pfp url:(NSString *)url {
    UIView *card = [[UIView alloc] init];
    card.backgroundColor = [UIColor secondarySystemBackgroundColor];
    card.layer.cornerRadius = 14;
    card.translatesAutoresizingMaskIntoConstraints = NO;

    UIImageView *iv = [[UIImageView alloc] init];
    iv.translatesAutoresizingMaskIntoConstraints = NO;
    iv.layer.cornerRadius = 32;
    iv.clipsToBounds = YES;
    iv.backgroundColor = [UIColor tertiarySystemBackgroundColor];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *d = [NSData dataWithContentsOfURL:[NSURL URLWithString:pfp]];
        UIImage *img = d ? [UIImage imageWithData:d] : nil;
        if (img) dispatch_async(dispatch_get_main_queue(), ^{ iv.image = img; });
    });
    [card addSubview:iv];

    UILabel *lname = [[UILabel alloc] init];
    lname.text = name;
    lname.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    lname.translatesAutoresizingMaskIntoConstraints = NO;
    [card addSubview:lname];

    UILabel *lrole = [[UILabel alloc] init];
    lrole.text = role;
    lrole.font = [UIFont systemFontOfSize:14];
    lrole.textColor = [UIColor secondaryLabelColor];
    lrole.translatesAutoresizingMaskIntoConstraints = NO;
    [card addSubview:lrole];

    UIButton *tap = [UIButton buttonWithType:UIButtonTypeCustom];
    tap.translatesAutoresizingMaskIntoConstraints = NO;
    objc_setAssociatedObject(tap, @selector(tag), url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [tap addTarget:self action:@selector(openProfile:) forControlEvents:UIControlEventTouchUpInside];
    [card addSubview:tap];

    [NSLayoutConstraint activateConstraints:@[
        [iv.leadingAnchor constraintEqualToAnchor:card.leadingAnchor constant:16],
        [iv.centerYAnchor constraintEqualToAnchor:card.centerYAnchor],
        [iv.widthAnchor constraintEqualToConstant:64],
        [iv.heightAnchor constraintEqualToConstant:64],
        [lname.leadingAnchor constraintEqualToAnchor:iv.trailingAnchor constant:16],
        [lname.topAnchor constraintEqualToAnchor:card.topAnchor constant:16],
        [lrole.leadingAnchor constraintEqualToAnchor:lname.leadingAnchor],
        [lrole.topAnchor constraintEqualToAnchor:lname.bottomAnchor constant:4],
        [card.bottomAnchor constraintGreaterThanOrEqualToAnchor:lrole.bottomAnchor constant:16],
        [card.heightAnchor constraintGreaterThanOrEqualToConstant:96],
        [tap.leadingAnchor constraintEqualToAnchor:card.leadingAnchor],
        [tap.trailingAnchor constraintEqualToAnchor:card.trailingAnchor],
        [tap.topAnchor constraintEqualToAnchor:card.topAnchor],
        [tap.bottomAnchor constraintEqualToAnchor:card.bottomAnchor]
    ]];
    return card;
}

- (void)openProfile:(UIButton *)sender {
    NSString *url = objc_getAssociatedObject(sender, @selector(tag));
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
}
@end
