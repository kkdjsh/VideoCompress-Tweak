#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 鍏圚ook涓€涓‘瀹氬瓨鍦ㄧ殑绯荤粺绫伙紝娴嬭瘯涓€涓?hook鑳戒笉鑳界敤
%hook UIApplication

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    %orig;
    NSLog(@"[VideoCompress] App did finish launching!");
}

%end

%ctor {
    NSLog(@"[VideoCompress] Tweak loaded!");
}
