//
//  Tweak.x
//  VideoCompress Unlock + Ad Block
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// VIP瑙ｉ攣: shouldLockForProductIdentifier: -> return NO
%hook VCSettingsConfig

+ (BOOL)shouldLockForProductIdentifier:(NSString *)productIdentifier {
    return NO;
}

%end

// 鎻掑睆骞垮憡: showInterstitialAdAfterTimeLengthInViewController: -> return nil
%hook VCAdvertiseController

- (id)showInterstitialAdAfterTimeLengthInViewController:(UIViewController *)viewController {
    return nil;
}

%end

%ctor {
    NSLog(@"[VideoCompress Tweak] Loaded successfully!");
}
