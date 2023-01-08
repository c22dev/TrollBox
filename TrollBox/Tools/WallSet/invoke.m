//
//  invoke.m
//  TrollBox
//
//  Created by Constantin Clerc on 20/12/2022.
//

#import <Foundation/Foundation.h>

// only way I could find to call setWallpaperMode without crashing was with NSInvocation

void invoke(SEL selector, id target, void *arg) {
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
    [inv setSelector:selector];
    [inv setTarget:target];
    [inv setArgument:arg atIndex:2];
    [inv invoke];
}

void invokeInt(SEL selector, id target, long long arg) {
    invoke(selector, target, &arg);
}
void invokeDouble(SEL selector, id target, double arg) {
    invoke(selector, target, &arg);
}
void invokeAny(SEL selector, id target, id arg) {
    invoke(selector, target, &arg);
}
