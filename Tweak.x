#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static void listClasses() {
    unsigned int count;
    Class *classes = objc_copyClassList(&count);
    
    NSMutableArray *matched = [NSMutableArray array];
    
    for (unsigned int i = 0; i < count; i++) {
        const char *name = class_getName(classes[i]);
        NSString *clsName = [NSString stringWithUTF8String:name];
        
        if ([clsName containsString:@"Setting"] || 
            [clsName containsString:@"Config"] || 
            [clsName containsString:@"Store"] ||
            [clsName containsString:@"Purchase"] ||
            [clsName containsString:@"VIP"] ||
            [clsName containsString:@"Pro"]) {
            [matched addObject:clsName];
        }
    }
    
    free(classes);
    
    NSLog(@"[VideoCompress] Found %lu matching classes:", (unsigned long)matched.count);
    for (NSString *clsName in matched) {
        NSLog(@"[VideoCompress]   - %@", clsName);
    }
}

__attribute__((constructor))
static void init(void) {
    NSLog(@"[VideoCompress] Tweak loaded!");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            listClasses();
        });
    });
}
