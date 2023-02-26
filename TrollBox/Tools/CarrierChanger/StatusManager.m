// --------------------------------------------------------------------------------
// The MIT License (MIT)
//
// Copyright (c) 2014 Shiny Development
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
// --------------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import <sys/utsname.h>
//#import <mach-o/arch.h>
#import "StatusManager.h"
#import "StatusSetter.h"
#import "StatusSetter16_1.h"
#import "StatusSetter16.h"
#import "StatusSetter15.h"
#import "StatusSetter14.h"

@interface StatusManager ()
@property (nonatomic, strong) id <StatusSetter> setter;
@property (nonatomic) bool MDCMode;

@end

@implementation StatusManager

- (instancetype)init {
    self = [super init];
    return self;
}

- (id<StatusSetter>)setter {
    if (!_setter) {
        if (@available(iOS 16.1, *)) {
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"UseAlternativeSetter"]) {
                _setter = [StatusSetter16 new];
            } else {
                _setter = [StatusSetter16_1 new];
            }
        } else if (@available(iOS 16, *)) {
            _setter = [StatusSetter16 new];
        } else if (@available(iOS 15, *)) {
            _setter =  [StatusSetter15 new];
        } else if (@available(iOS 14, *)) {
            _setter = [StatusSetter14 new];
        }
    }
    return _setter;
}

- (bool) isMDCMode {
    return self.MDCMode;
}

/// Set whether we're using MacDirtyCOW or not
- (void) setIsMDCMode:(bool)mode {
    self.MDCMode = mode;
}

+ (StatusManager *)sharedInstance {
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    dispatch_once(&predicate, ^{ sharedObject = [[self alloc] init]; });
    return sharedObject;
}

- (bool) isCarrierOverridden {
    return [self.setter isCarrierOverridden];
}

- (NSString*) getCarrierOverride {
    return [self.setter getCarrierOverride];
}

- (void) setCarrier:(NSString*)text {
    [self.setter setCarrier:text];
}

- (void) unsetCarrier {
    [self.setter unsetCarrier];
}

@end