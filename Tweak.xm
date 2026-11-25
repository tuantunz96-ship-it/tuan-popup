#import <UIKit/UIKit.h>

static void showTuanPopup() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = nil;
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    for (UIWindow *w in scene.windows) {
                        if (w.isKeyWindow) {
                            window = w;
                            break;
                        }
                    }
                }
            }
        }
        if (!window) {
            window = [UIApplication sharedApplication].keyWindow;
        }
        if (!window || [window viewWithTag:998877]) return;

        // Lớp phủ tối toàn màn hình
        UIView *overlay = [[UIView alloc] initWithFrame:window.bounds];
        overlay.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.55];
        overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlay.tag = 998877;

        // Khung bảng thông báo ở giữa
        CGFloat boxW = MIN(460.0, window.bounds.size.width - 40.0);
        CGFloat boxH = 220.0;
        UIView *box = [[UIView alloc] initWithFrame:CGRectMake((window.bounds.size.width - boxW) / 2.0,
                                                               (window.bounds.size.height - boxH) / 2.0,
                                                               boxW, boxH)];
        box.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                               UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        box.layer.borderColor = [UIColor colorWithRed:0.86 green:0.72 blue:0.38 alpha:1.0].CGColor;
        box.layer.borderWidth = 1.5;
        box.layer.shadowColor = [UIColor blackColor].CGColor;
        box.layer.shadowOpacity = 0.6;
        box.layer.shadowRadius = 12.0;

        // Nền gradient xanh tím giống bảng Liên Quân
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = box.bounds;
        gradient.colors = @[
            (id)[UIColor colorWithRed:0.20 green:0.19 blue:0.44 alpha:0.97].CGColor,
            (id)[UIColor colorWithRed:0.29 green:0.28 blue:0.58 alpha:0.97].CGColor
        ];
        gradient.startPoint = CGPointMake(0.5, 0.0);
        gradient.endPoint = CGPointMake(0.5, 1.0);
        [box.layer insertSublayer:gradient atIndex:0];

        // Đường kẻ ngang mảnh dưới thanh tiêu đề
        UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(0, 48, boxW, 1.0)];
        divider.backgroundColor = [UIColor colorWithRed:0.86 green:0.72 blue:0.38 alpha:0.35];
        [box addSubview:divider];

        // 1. Tiêu đề góc trên trái
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, boxW - 70, 30)];
        titleLabel.text = @"TUAN MOD AOV";
        titleLabel.textColor = [UIColor colorWithRed:0.95 green:0.88 blue:0.72 alpha:1.0];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [box addSubview:titleLabel];

        // Nút đóng (X) góc trên phải
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        closeBtn.frame = CGRectMake(boxW - 48, 6, 40, 38);
        [closeBtn setTitle:@"✕" forState:UIControlStateNormal];
        [closeBtn setTitleColor:[UIColor colorWithRed:0.95 green:0.78 blue:0.36 alpha:1.0] forState:UIControlStateNormal];
        closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        [closeBtn addTarget:overlay action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
        [box addSubview:closeBtn];

        // 2. Dòng chữ ở giữa bảng
        UILabel *centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, boxW - 40, 120)];
        centerLabel.text = @"Tuấn MOP AOV";
        centerLabel.textColor = [UIColor colorWithRed:0.98 green:0.82 blue:0.25 alpha:1.0];
        centerLabel.textAlignment = NSTextAlignmentCenter;
        centerLabel.font = [UIFont boldSystemFontOfSize:20];
        [box addSubview:centerLabel];

        [overlay addSubview:box];
        [window addSubview:overlay];
    });
}

__attribute__((constructor)) static void initializePopup() {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
        showTuanPopup();
    }];
}
