//
//  UIFont+M5MaxSize.m
//  UILabel+M5FillFrame
//
//  Created by Mathew Huusko V.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
//

#import "UIFont+M5MaxSize.h"

typedef enum {
    kDimensionHeight,
    kDimensionWidth,
} DimensionType;

@implementation UIFont (M5MaxSize)

#pragma mark - UIFont+M5MaxSize -

#pragma mark Methods

+ (UIFont *)M5_maxFontWithName:(NSString *)fontName minSize:(NSInteger)minSize boundsSize:(CGSize)boundsSize heightOnly:(BOOL)heightOnly string:(NSString *)string {
    UIFont *maxFont = nil;
    NSString *testString = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    UIFont *fontConstrainingHeight = [UIFont M5_maxFontWithName:fontName minSize:minSize boundsSize:boundsSize.height testString:testString dimension:kDimensionHeight];
    
    CGSize boundsConstrainingHeight = [string sizeWithAttributes:@{ NSFontAttributeName: fontConstrainingHeight }];
    CGSize boundsConstrainingWidth = CGSizeZero;
    
    if (boundsConstrainingHeight.width <= boundsSize.width || heightOnly) {
        maxFont = fontConstrainingHeight;
    } else {
        testString = string;
        
        maxFont = [UIFont M5_maxFontWithName:fontName minSize:minSize boundsSize:boundsSize.width testString:testString dimension:kDimensionWidth];
        
        boundsConstrainingWidth = [string sizeWithAttributes:@{ NSFontAttributeName: maxFont }];
    }
    
    return maxFont;
}

#pragma mark -

#pragma mark - UIFont+M5MaxSize (Private) -

#pragma mark Methods

+ (UIFont *)M5_maxFontWithName:(NSString *)fontName minSize:(NSInteger)minSize boundsSize:(CGFloat)boundsSize testString:(NSString *)testString dimension:(DimensionType)dimension {
	UIFont *tempFont = nil;
	NSInteger tempMin = minSize;
	NSInteger tempMax = 256;
	NSInteger mid = 0;
	CGFloat difference = 0;
	CGFloat testStringDimension = 0.0;

	while (tempMin <= tempMax) {
        mid = tempMin + (tempMax - tempMin) / 2;
        tempFont = [UIFont fontWithName:fontName size:mid];
        
        if (dimension == kDimensionHeight) {
            testStringDimension = [testString sizeWithAttributes:@{ NSFontAttributeName: tempFont }].height / 1.5;
        } else {
            testStringDimension = [testString sizeWithAttributes:@{ NSFontAttributeName: tempFont }].width;
        }
        
        difference = boundsSize - testStringDimension;
        
        if (mid == tempMin || mid == tempMax) {
            if (difference < 0) {
                return [UIFont fontWithName:fontName size:(mid - 1)];
            }
            
            return [UIFont fontWithName:fontName size:mid];
        }
        
        if (difference < 0) {
            tempMax = mid - 1;
        } else if (difference > 0) {
            tempMin = mid + 1;
        } else {
            return [UIFont fontWithName:fontName size:mid];
        }
	}
    
	return [UIFont fontWithName:fontName size:mid];
}

#pragma mark -

@end
