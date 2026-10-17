#import <Foundation/Foundation.h>
#import <mach-o/dyld.h>
#import <mach/mach.h>
#import <string.h>

// ARM64: mov x0, #0; ret
static uint32_t patch_code[2] = {0xD2800000, 0xD65F03C0};

static void patchFunction(void *funcAddr) {
    kern_return_t kr = vm_protect(mach_task_self(), (vm_address_t)funcAddr, sizeof(patch_code), FALSE, VM_PROT_READ | VM_PROT_WRITE | VM_PROT_COPY);
    if (kr != KERN_SUCCESS) {
        NSLog(@"[VideoCompress] vm_protect failed: %d", kr);
        return;
    }
    
    memcpy(funcAddr, patch_code, sizeof(patch_code));
    
    kr = vm_protect(mach_task_self(), (vm_address_t)funcAddr, sizeof(patch_code), FALSE, VM_PROT_READ | VM_PROT_EXECUTE);
    if (kr != KERN_SUCCESS) {
        NSLog(@"[VideoCompress] vm_protect restore failed: %d", kr);
        return;
    }
    
    NSLog(@"[VideoCompress] Patched function at %p", funcAddr);
}

static void *findMainImageBase() {
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0; i < count; i++) {
        const char *name = _dyld_get_image_name(i);
        if (strstr(name, "VideoCompress") != NULL) {
            NSLog(@"[VideoCompress] Found main image: %s", name);
            return (void *)_dyld_get_image_header(i);
        }
    }
    NSLog(@"[VideoCompress] Main image not found, using image 0");
    return (void *)_dyld_get_image_header(0);
}

static void doPatches() {
    NSLog(@"[VideoCompress] Starting patches...");
    
    void *base = findMainImageBase();
    NSLog(@"[VideoCompress] Main base: %p", base);
    
    // Patch 1: VIP瑙ｉ攣 @ 0xa8350
    patchFunction((void *)((uintptr_t)base + 0xa8350));
    
    // Patch 2: 鎻掑睆骞垮憡 @ 0xa6ad0
    patchFunction((void *)((uintptr_t)base + 0xa6ad0));
    
    // Patch 3: 棰濆鍔犲浐 @ 0xa8240
    patchFunction((void *)((uintptr_t)base + 0xa8240));
    
    NSLog(@"[VideoCompress] All patches applied!");
}

__attribute__((constructor))
static void init(void) {
    NSLog(@"[VideoCompress] Tweak loaded!");
    
    // 寤惰繜1绉掓墽琛宲atch锛岀瓑App瀹屽叏鍚姩鍚庡啀patch锛岄伩鍏嶉棯閫€
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            doPatches();
        });
    });
}
