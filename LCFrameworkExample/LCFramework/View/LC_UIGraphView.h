//
//  LC_UIGraphView.h
//  LCFramework

//  Created by 郭历成 ( titm@tom.com ) on 13-10-10.
//  Copyright (c) 2014年 Licheng Guo iOS developer ( http://nsobject.me ).All rights reserved.
//  Also see the copyright page  http://nsobject.me/copyright.rtf ).
//
//

#import <UIKit/UIKit.h>

@interface LC_UIGraphView : UIView

-(void) setMaxValue:(float)maxPoint;
-(void) setMinValue:(float)minPoint;

// add point to the array dynamically
-(void)setPoint:(float)point;

// reset graph to all 0.0 values
-(void)resetGraph;

// set an array of alues to be displayed in a the graph
-(void)setArray:(NSArray*)array ;

// set the spacing from the max value in graph array to top of view. default = 10.
-(void)setSpacing:(int)space;

// set the view to fill below graph. default = YES
-(void)setFill:(BOOL)fill;

// set the color of the graph line. default = [UIColor redColor].
-(void)setStrokeColor:(UIColor*)color;

// set the color of the zero line. default = [UIColor greenColor].
-(void)setZeroLineStrokeColor:(UIColor*)color;

// set the filled space below graph. default = [UIColor orangeColor].
-(void)setFillColor:(UIColor*)color;

// set the color of the graph line. default = 2.
-(void)setLineWidth:(int)width;

// set up the number of values diplayes in the graph along the x-axis
-(void)setNumberOfPointsInGraph:(int)numberOfPoints;

// set curved graph lines. default = YES;
-(void)setCurvedLines:(BOOL)curved;

@end
