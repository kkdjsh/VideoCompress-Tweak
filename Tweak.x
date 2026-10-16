//
//  Tweak.x
//  VideoCompress 缁堟瀬瑙ｉ攣鐗?//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>

%hook VCSettingsConfig

// VIP瑙ｉ攣: shouldLockForProductIdentifier: 寮哄埗杩斿洖NO
+ (BOOL)shouldLockForProductIdentifier:(NSString *)productIdentifier {
    return NO;
}

%end

%hook VCAdvertiseController

// 鎻掑睆骞垮憡鍘婚櫎: showInterstitialAdAfterTimeLengthInViewController: 寮哄埗杩斿洖nil
- (id)showInterstitialAdAfterTimeLengthInViewController:(UIViewController *)vc {
    return nil;
}

%end

%ctor {
    NSLog(@"[VideoCompress Tweak] 缁堟瀬瑙ｉ攣鐗堝姞杞芥垚鍔燂紒");
    
    // Hook BoringSSL鐨凷SL_write鍑芥暟锛屾嫤鎴┛灞辩敳骞垮憡璇锋眰
    // 杩欓噷鎴戜滑鐢╢ishhook鏉ook C鍑芥暟
    // 娉ㄦ剰锛氳秺鐙辩幆澧冨彲浠ヤ娇鐢╢ishhook
    
    // 鐢变簬鎴戜滑涓嶇煡閬揝SL_write鐨勫叿浣撲綅缃紝鍏堟敞閲婃帀
    // 鍚庨潰鍐嶆兂鍔炴硶
}
