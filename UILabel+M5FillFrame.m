//
//  UILabel+M5FillFrame.m
//  UILabel+M5FillFrame
//
//  Created by Mathew Huusko V on 3/2/15.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
//

#import "UILabel+M5FillFrame.h"

#import "UIFont+M5MaxSize.h"
#import <objc/runtime.h>

NSString* const kM5FillFrameFontScale = @"M5FillFrameFontScale"; // 0 -> 1
NSString* const kM5FillFrameHeightOnly = @"M5FillFrameHeightOnly"; // YES / NO

NS_INLINE void M5SwizzleMethod(Class clazz, SEL original, SEL alternate) {
    Method origMethod = class_getInstanceMethod(clazz, original);
    Method newMethod = class_getInstanceMethod(clazz, alternate);
    
    if(class_addMethod(clazz, original, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(clazz, alternate, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

@implementation UILabel (M5FillFrame)

#pragma mark - UILabel (M5FillFrame) Private -

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @synchronized(self.class) {
            M5SwizzleMethod(self.class, @selector(drawTextInRect:), @selector(M5_drawTextInRect:));
        }
    });
}

- (void)M5_drawTextInRect:(CGRect)rect {
    if (self.M5_fillFrameFontScale) {
        self.font = self.M5_scaledMaximizedFont;
    }
    
    [self M5_drawTextInRect:rect];
}

- (UIFont *)M5_scaledMaximizedFont {
    UIFont *font = [UIFont M5_maxFontWithName:self.font.fontName minSize:8 boundsSize:(self.M5_fillFrameRect ? self.M5_fillFrameRect.CGRectValue : self.frame).size heightOnly:self.M5_fillFrameHeightOnly.boolValue string:self.text];
    
    return [font fontWithSize:font.pointSize * self.M5_fillFrameFontScale.floatValue];
}

- (NSNumber *)M5_fillFrameFontScale {
    return objc_getAssociatedObject(self, @selector(M5_fillFrameFontScale));
}

- (void)M5_setFillFrameFontScale:(NSNumber *)scale {
    objc_setAssociatedObject(self, @selector(M5_fillFrameFontScale), scale, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)M5_fillFrameHeightOnly {
    return objc_getAssociatedObject(self, @selector(M5_fillFrameHeightOnly));
}

- (void)M5_setFillFrameHeightOnly:(NSNumber *)rect {
    objc_setAssociatedObject(self, @selector(M5_fillFrameHeightOnly), rect, OBJC_ASSOCIATION_RETAIN);
}

- (NSValue *)M5_fillFrameRect {
    return objc_getAssociatedObject(self, @selector(M5_fillFrameRect));
}

- (void)M5_setFillFrameRect:(NSValue *)rect {
    objc_setAssociatedObject(self, @selector(M5_fillFrameRect), rect, OBJC_ASSOCIATION_RETAIN);
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:kM5FillFrameFontScale] && [value isKindOfClass:NSNumber.class]) {
        [self M5_setFillFrameFontScale:value];
    } else if ([key isEqualToString:kM5FillFrameHeightOnly] && [value isKindOfClass:NSNumber.class]) {
        [self M5_setFillFrameHeightOnly:value];
    } else {
        [super setValue:value forKey:key];
    }
}

#pragma mark -

@end

@implementation UIButton (M5FillFrame)

#pragma mark - UIButton (M5FillFrame) Private -

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @synchronized(self.class) {
            M5SwizzleMethod(self.class, @selector(drawRect:), @selector(M5_drawRect:));
        }
    });
}

- (void)M5_drawRect:(CGRect)rect {
    if (self.titleLabel.M5_fillFrameFontScale) {
        [self.titleLabel M5_setFillFrameRect:[NSValue valueWithCGRect:rect]];
    }
    
    [self M5_drawRect:rect];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:kM5FillFrameFontScale] && [value isKindOfClass:NSNumber.class]) {
        [self.titleLabel M5_setFillFrameFontScale:value];
    } else if ([key isEqualToString:kM5FillFrameHeightOnly] && [value isKindOfClass:NSNumber.class]) {
        [self.titleLabel M5_setFillFrameHeightOnly:value];
    } else {
        [super setValue:value forKey:key];
    }
}

#pragma mark -

@end
