//
//  Tweak.x
//  VideoCompress Unlock + Ad Block
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <substrate.h>

// ========== VIP Unlock ==========
// Hook VCSettingsConfig shouldLockForProductIdentifier: -> return NO

%hook VCSettingsConfig

+ (BOOL)shouldLockForProductIdentifier:(NSString *)productIdentifier {
    return NO;
}

%end

// ========== Interstitial Ad Block ==========
// Hook showInterstitialAdAfterTimeLengthInViewController: -> return nil

%hook VCAdvertiseController

- (id)showInterstitialAdAfterTimeLengthInViewController:(UIViewController *)viewController {
    return nil;
}

%end

%ctor {
    NSLog(@"[VideoCompress Tweak] Loaded successfully!");
}
