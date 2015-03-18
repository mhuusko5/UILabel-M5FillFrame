//
//  UILabel+M5FillFrame.h
//  UILabel+M5FillFrame
//
//  Created by Mathew Huusko V.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (M5FillFrame)

#pragma mark - UILabel+M5FillFrame -

#pragma mark Fields

//Runtime attribute (IB or setValue:forKey:) for percent of frame to scale to. 0 –> 1. Default 1.
extern NSString* const kM5FillFrameFontScale; 

//Runtime attribute (IB or setValue:forKey:) to scale text only to height of frame. YES / NO. Default NO.
extern NSString* const kM5FillFrameHeightOnly;

#pragma mark -

@end
