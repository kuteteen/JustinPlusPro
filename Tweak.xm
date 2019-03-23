#import <UIKit/UIKit.h>

static 

@interface JustinWindow: UIWindow
@property (nonatomic, assign, setter=setJustinEcstatic:) BOOL isJustinEcstatic;
- (void)noteJustinTap;
@end

@implementation JustinWindow {
    UIImage *happyDaddy;
    UIImage *daddy;
    NSTimer *justinRevertTimer;
    UIImageView *justinView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURL *directoryPath = [NSURL fileURLWithPath:@"/var/mobile/Library/Application Support/JustinPlusPro"];
        happyDaddy = [UIImage imageWithContentsOfFile:[directoryPath URLByAppendingPathComponent:@"daddy-happy.png"].path];
        daddy = [UIImage imageWithContentsOfFile:[directoryPath URLByAppendingPathComponent:@"daddy.png"].path];

        self.backgroundColor = nil;
        self.windowLevel = UIWindowLevelAlert;

        justinView = [[UIImageView alloc] initWithImage:daddy];
        justinView.userInteractionEnabled = NO;
        justinView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:justinView];
        [justinView.widthAnchor constraintEqualToConstant:daddy.size.width].active = YES;
        [justinView.heightAnchor constraintEqualToConstant:daddy.size.height].active = YES;
        [justinView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:40].active = YES;
        [justinView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    }
    return self;
}

- (BOOL)_shouldCreateContextAsSecure {
    return YES;
}

- (BOOL)_ignoresHitTest {
    return YES;
}

- (void)noteJustinTap {
    self.isJustinEcstatic = YES;
    [self destroyRevertTimer];
    justinRevertTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:NO block:^(NSTimer *timer) {
        [self destroyRevertTimer];
        self.isJustinEcstatic = NO;
    }];
}

- (void)destroyRevertTimer {
    if (justinRevertTimer) [justinRevertTimer invalidate];
    justinRevertTimer = nil;
}

- (void)setJustinEcstatic:(BOOL)isJustinEcstatic {
    if (isJustinEcstatic == _isJustinEcstatic) return;
    _isJustinEcstatic = isJustinEcstatic;
    justinView.image = _isJustinEcstatic ? happyDaddy : daddy;
    justinView.alpha = _isJustinEcstatic ? 0.8 : 1;
}

@end

static JustinWindow *window = nil;

%hook SpringBoard

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    %orig;
    window = [[JustinWindow alloc] init];
    window.hidden = NO;
}

- (void)sendEvent:(UIEvent *)event {
    if (event.type == UIEventTypeTouches && window) [window noteJustinTap];
    %orig;
}


%end