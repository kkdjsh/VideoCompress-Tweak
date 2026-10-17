#import <Foundation/Foundation.h>

%hook VCSettingsConfig

- (NSInteger)shouldLockForProductIdentifier:(id)arg1 {
    return 0;
}

%end
