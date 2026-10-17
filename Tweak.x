#import <Foundation/Foundation.h>
#import <mach-o/dyld.h>
#import <string.h>

__attribute__((constructor))
static void init(void) {
    NSLog(@"[VideoCompress] Tweak loaded!");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 鎵惧埌涓绘ā鍧?            uint32_t count = _dyld_image_count();
            void *base = NULL;
            
            for (uint32_t i = 0; i < count; i++) {
                const char *name = _dyld_get_image_name(i);
                if (strstr(name, "VideoCompress") != NULL) {
                    base = (void *)_dyld_get_image_header(i);
                    NSLog(@"[VideoCompress] Found main image: %s, base: %p", name, base);
                    break;
                }
            }
            
            if (!base) {
                NSLog(@"[VideoCompress] Main image not found!");
                return;
            }
            
            // ARM64: mov x0, #0; ret
            uint32_t patch[2] = {0xD2800000, 0xD65F03C0};
            
            // Patch 0xa8350
            void *addr1 = (void *)((uintptr_t)base + 0xa8350);
            memcpy(addr1, patch, sizeof(patch));
            NSLog(@"[VideoCompress] Patched 0xa8350 at %p", addr1);
            
            // Patch 0xa6ad0
            void *addr2 = (void *)((uintptr_t)base + 0xa6ad0);
            memcpy(addr2, patch, sizeof(patch));
            NSLog(@"[VideoCompress] Patched 0xa6ad0 at %p", addr2);
            
            // Patch 0xa8240
            void *addr3 = (void *)((uintptr_t)base + 0xa8240);
            memcpy(addr3, patch, sizeof(patch));
            NSLog(@"[VideoCompress] Patched 0xa8240 at %p", addr3);
            
            NSLog(@"[VideoCompress] All patches done!");
        });
    });
}
