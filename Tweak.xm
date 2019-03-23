#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JustinStyle) {
    JustinStyleNormal,
    JustinStyleCommie,
    JustinStyleShill
};
#define JustinStyleLast JustinStyleShill

@interface JustinWindow: UIWindow
@property (nonatomic, assign, setter=setJustinEcstatic:) BOOL isJustinEcstatic;
@property (nonatomic, assign) JustinStyle justinStyle;
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

        self.backgroundColor = nil;
        self.windowLevel = UIWindowLevelAlert;

        [self loadImages];
        justinView = [[UIImageView alloc] initWithImage:daddy];
        justinView.userInteractionEnabled = NO;
        [self addSubview:justinView];
    }
    return self;
}

- (BOOL)_shouldCreateContextAsSecure {
    return YES;
}

- (BOOL)_ignoresHitTest {
    return YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    justinView.frame = CGRectMake(self.bounds.size.width - daddy.size.width + 40, self.bounds.size.height - daddy.size.height, daddy.size.width, daddy.size.height);
}

- (void)noteJustinTap {
    self.isJustinEcstatic = YES;
    [self destroyRevertTimer];
    justinRevertTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(tick) userInfo:nil repeats:NO];
}

- (void)tick {
    [self destroyRevertTimer];
    self.isJustinEcstatic = NO;
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

- (void)setJustinStyle:(JustinStyle)justinStyle {
    _justinStyle = justinStyle;
    [self loadImages];
}

- (void)loadImages {
    NSURL *directoryPath = [NSURL fileURLWithPath:@"/var/mobile/Library/Application Support/JustinPlusPro"];
    NSString *imageName = [self imageNameForStyle:_justinStyle];
    happyDaddy = [UIImage imageWithContentsOfFile:[directoryPath URLByAppendingPathComponent:[NSString stringWithFormat:@"%@-happy.png", imageName]].path];
    daddy = [UIImage imageWithContentsOfFile:[directoryPath URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imageName]].path];
}

- (NSString *)imageNameForStyle:(JustinStyle)justinStyle {
    switch (justinStyle) {
    case JustinStyleNormal: return @"daddy";
    case JustinStyleCommie: return @"commie";
    case JustinStyleShill: return @"shill";
    }
    return nil;
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
    if (event.type == UIEventTypeTouches && window) {
        [window noteJustinTap];
        if(arc4random_uniform(window.justinStyle == JustinStyleNormal ? 25 : 10) == 0) window.justinStyle = floor(arc4random_uniform(JustinStyleLast + 1));
    }
    %orig;
}

%end