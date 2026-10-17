#import <Foundation/Foundation.h>
#import <mach-o/dyld.h>
#import <string.h>

__attribute__((constructor))
static void init(void) {
    NSLog(@"[VideoCompress] Tweak loaded!");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            uint32_t count = _dyld_image_count();
            NSLog(@"[VideoCompress] Total images: %d", count);
            
            for (uint32_t i = 0; i < count; i++) {
                const char *name = _dyld_get_image_name(i);
                void *addr = (void *)_dyld_get_image_header(i);
                NSLog(@"[VideoCompress] Image %d: %s at %p", i, name, addr);
            }
            
            NSLog(@"[VideoCompress] Done listing images!");
        });
    });
}
