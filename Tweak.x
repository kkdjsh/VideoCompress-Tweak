#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static id hook_shouldLock(id self, SEL _cmd, id arg) {
    NSLog(@"[VideoCompress] shouldLockForProductIdentifier called, returning NO");
    return (id)0;
}

__attribute__((constructor))
static void init(void) {
    NSLog(@"[VideoCompress] Tweak loaded!");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 鏌ユ壘VCSettingsConfig绫?            Class VCSettingsConfig = objc_getClass("VCSettingsConfig");
            if (VCSettingsConfig) {
                NSLog(@"[VideoCompress] Found VCSettingsConfig class!");
                
                // 鏌ユ壘shouldLockForProductIdentifier:绫绘柟娉?                Method method = class_getClassMethod(VCSettingsConfig, @selector(shouldLockForProductIdentifier:));
                if (method) {
                    NSLog(@"[VideoCompress] Found shouldLockForProductIdentifier: method!");
                    
                    // 鐩存帴鏇挎崲鏂规硶瀹炵幇
                    method_setImplementation(method, (IMP)hook_shouldLock);
                    NSLog(@"[VideoCompress] Method implementation replaced!");
                } else {
                    NSLog(@"[VideoCompress] shouldLockForProductIdentifier: not found");
                }
            } else {
                NSLog(@"[VideoCompress] VCSettingsConfig class not found");
            }
        });
    });
}
