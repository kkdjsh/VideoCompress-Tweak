//
//  Tweak.x
//  VideoCompress Unlock + Ad Block
//  Address-based hooking (same as Frida script)
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <substrate.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>

// 鍑芥暟鎸囬拡绫诲瀷
typedef id (*original_func_t)(id self, SEL _cmd);

// 鍘熷鍑芥暟鎸囬拡
static original_func_t orig_0xa8350 = NULL;
static original_func_t orig_0xa6ad0 = NULL;
static original_func_t orig_0xa8240 = NULL;

// 鏇挎崲鍑芥暟锛歏IP瑙ｉ攣 - 寮哄埗杩斿洖0(NO)
static id replaced_0xa8350(id self, SEL _cmd) {
    return (id)0;
}

// 鏇挎崲鍑芥暟锛氭彃灞忓箍鍛?- 寮哄埗杩斿洖nil(0)
static id replaced_0xa6ad0(id self, SEL _cmd) {
    return (id)0;
}

// 鏇挎崲鍑芥暟锛氶澶栧姞鍥?- 寮哄埗杩斿洖0
static id replaced_0xa8240(id self, SEL _cmd) {
    return (id)0;
}

%ctor {
    NSLog(@"[VideoCompress Tweak] Loading...");
    
    // 鑾峰彇涓绘ā鍧楀熀鍦板潃锛堢涓€涓姞杞界殑闀滃儚灏辨槸涓诲彲鎵ц鏂囦欢锛?    void *mainBase = (void *)_dyld_get_image_header(0);
    NSLog(@"[VideoCompress Tweak] Main module base: %p", mainBase);
    
    // Hook 1: VIP瑙ｉ攣 @ 0xa8350
    void *addr_0xa8350 = (void *)((uintptr_t)mainBase + 0xa8350);
    MSHookFunction(addr_0xa8350, (void *)replaced_0xa8350, (void **)&orig_0xa8350);
    NSLog(@"[VideoCompress Tweak] Hooked VIP unlock @ 0xa8350");
    
    // Hook 2: 鎻掑睆骞垮憡 @ 0xa6ad0
    void *addr_0xa6ad0 = (void *)((uintptr_t)mainBase + 0xa6ad0);
    MSHookFunction(addr_0xa6ad0, (void *)replaced_0xa6ad0, (void **)&orig_0xa6ad0);
    NSLog(@"[VideoCompress Tweak] Hooked interstitial ad @ 0xa6ad0");
    
    // Hook 3: 棰濆鍔犲浐 @ 0xa8240
    void *addr_0xa8240 = (void *)((uintptr_t)mainBase + 0xa8240);
    MSHookFunction(addr_0xa8240, (void *)replaced_0xa8240, (void **)&orig_0xa8240);
    NSLog(@"[VideoCompress Tweak] Hooked extra ad block @ 0xa8240");
    
    NSLog(@"[VideoCompress Tweak] Loaded successfully!");
}
