//
//  UILabel+M5FillFrame.m
//  UILabel+M5FillFrame
//
//  Created by Mathew Huusko V.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
//

#import "UILabel+M5FillFrame.h"

#import "UIFont+M5MaxSize.h"
#import <objc/runtime.h>

#pragma mark - UILabel+M5FillFrame -

#pragma mark Fields

NSString* const kM5FillFrameFontScale = @"M5FillFrameFontScale";
NSString* const kM5FillFrameHeightOnly = @"M5FillFrameHeightOnly";

#pragma mark -

@implementation UILabel (M5FillFrame)

#pragma mark - UILabel+M5FillFrame (Private) -

#pragma mark Methods

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

#pragma mark - NSObject -

#pragma mark Methods

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:kM5FillFrameFontScale] && [value isKindOfClass:NSNumber.class]) {
        [self M5_setFillFrameFontScale:value];
    } else if ([key isEqualToString:kM5FillFrameHeightOnly] && [value isKindOfClass:NSNumber.class]) {
        [self M5_setFillFrameHeightOnly:value];
    } else {
        [super setValue:value forKey:key];
    }
}

+ (void)load {
    @synchronized(self) {
        SEL selector = @selector(drawTextInRect:);
        
        __block IMP oldImp = nil;
        IMP newImp = imp_implementationWithBlock(^(id self, CGRect rect) {
            if (((UILabel *)self).M5_fillFrameFontScale) {
                ((UILabel *)self).font = ((UILabel *)self).M5_scaledMaximizedFont;
            }
            
            if (oldImp) {
                ((void(*)(id, SEL, CGRect))oldImp)(self, selector, rect);
            }
        });
        
        Method method = class_getInstanceMethod(self, selector);
        if (method) {
            oldImp = method_setImplementation(method, newImp);
        } else {
            const char *methodTypes = [NSString stringWithFormat:@"%s%s%s%s", @encode(void), @encode(id), @encode(SEL), @encode(CGRect)].UTF8String;
            
            class_addMethod(self, selector, newImp, methodTypes);
        }
    }
}

#pragma mark -

#pragma mark -

@end

@implementation UIButton (M5FillFrame)

#pragma mark - NSObject -

#pragma mark Methods

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:kM5FillFrameFontScale] && [value isKindOfClass:NSNumber.class]) {
        [self.titleLabel M5_setFillFrameFontScale:value];
    } else if ([key isEqualToString:kM5FillFrameHeightOnly] && [value isKindOfClass:NSNumber.class]) {
        [self.titleLabel M5_setFillFrameHeightOnly:value];
    } else {
        [super setValue:value forKey:key];
    }
}


+ (void)load {
    @synchronized(self) {
        SEL selector = @selector(drawRect:);
        
        __block IMP oldImp = nil;
        IMP newImp = imp_implementationWithBlock(^(id self, CGRect rect) {
            if (((UIButton *)self).titleLabel.M5_fillFrameFontScale) {
                [((UIButton *)self).titleLabel M5_setFillFrameRect:[NSValue valueWithCGRect:rect]];
            }
            
            if (oldImp) {
                ((void(*)(id, SEL, CGRect))oldImp)(self, selector, rect);
            }
        });
        
        Method method = class_getInstanceMethod(self, selector);
        if (method) {
            oldImp = method_setImplementation(method, newImp);
        } else {
            const char *methodTypes = [NSString stringWithFormat:@"%s%s%s%s", @encode(void), @encode(id), @encode(SEL), @encode(CGRect)].UTF8String;
            
            class_addMethod(self, selector, newImp, methodTypes);
        }
    }
}

#pragma mark -

@end
