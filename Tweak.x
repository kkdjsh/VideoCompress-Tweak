#import <Foundation/Foundation.h>

__attribute__((constructor))
static void init(void) {
    NSLog(@"[VideoCompress] Tweak loaded successfully!");
}
