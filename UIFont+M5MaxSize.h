//
//  UIFont+M5MaxSize.h
//  UILabel+M5FillFrame
//
//  Created by Mathew Huusko V on 3/2/15.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (M5MaxSize)

#pragma mark - UIFont (M5MaxSize) -

+ (UIFont *)M5_maxFontWithName:(NSString *)fontName minSize:(NSInteger)minSize boundsSize:(CGSize)labelSize heightOnly:(BOOL)heightOnly string:(NSString *)string;

#pragma mark -

@end
