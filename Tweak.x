#import <Foundation/Foundation.h>
#import <substrate.h>
#import <mach-o/dyld.h>

static void *g_orig0 = NULL;
static void *g_orig1 = NULL;
static void *g_orig2 = NULL;

static id hook_func0(id self, SEL _cmd) {
    return (id)0;
}

static id hook_func1(id self, SEL _cmd) {
    return (id)0;
}

static id hook_func2(id self, SEL _cmd) {
    return (id)0;
}

__attribute__((constructor))
static void init(void) {
    void *base = (void *)_dyld_get_image_header(0);
    
    MSHookFunction((void *)((uintptr_t)base + 0xa8350), hook_func0, &g_orig0);
    MSHookFunction((void *)((uintptr_t)base + 0xa6ad0), hook_func1, &g_orig1);
    MSHookFunction((void *)((uintptr_t)base + 0xa8240), hook_func2, &g_orig2);
}
