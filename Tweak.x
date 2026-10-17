#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static id hookFunc(id self, SEL _cmd, id arg) {
    NSLog(@"[VideoCompress] Hook called!");
    return (id)0;
}

__attribute__((constructor))
static void init(void) {
    NSLog(@"[VideoCompress] Tweak loaded!");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            Class cls = objc_getClass("VCSettingsConfig");
            if (cls != nil) {
                NSLog(@"[VideoCompress] Found VCSettingsConfig!");
                
                Method m = class_getClassMethod(cls, @selector(shouldLockForProductIdentifier:));
                if (m != NULL) {
                    NSLog(@"[VideoCompress] Found method!");
                    method_setImplementation(m, (IMP)hookFunc);
                }
            }
        });
    });
}
