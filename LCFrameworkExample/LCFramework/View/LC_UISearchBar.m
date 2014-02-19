//
//  LC_UISearchBar.m
//  WuxianchangPro
//
//  Created by 郭历成 ( titm@tom.com ) on 13-10-31.
//  Copyright (c) 2013年 Wuxiantai Developer ( http://www.wuxiantai.com ). All rights reserved.
//

#import "LC_UISearchBar.h"

@interface LC_UISearchBar () <UISearchBarDelegate>
{
    ;
}


@end

@implementation LC_UISearchBar

-(void) dealloc
{
    self.textDidBeginEditingBlock = nil;
    self.textDidEndEditingBlock = nil;
    self.textDidChangedBlock = nil;
    self.searchButtonClickedBlock = nil;
    self.bookmarkButtonClickedBlock = nil;
    self.cancelButtonClickedBlock = nil;
    self.resultsListButtonClickedBlock = nil;

    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        if (IOS7_OR_LATER) {
            
        }else{
            for (UIView *subview in  self.subviews) {
                if ([subview isKindOfClass: NSClassFromString ( @"UISearchBarBackground" )]) {
                    [subview removeFromSuperview];
                    break ;
                }
            }
        }
        
        self.delegate = self;
    
    }
    return self;
}

-(void) removeFromSuperview
{
    [super removeFromSuperview];
}

- (void)searchBarTextDidBeginEditing:(LC_UISearchBar *)searchBar
{
    if (self.textDidBeginEditingBlock) {
        self.textDidBeginEditingBlock(searchBar);
    }
}

- (BOOL)searchBarShouldBeginEditing:(LC_UISearchBar *)searchBar
{
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(LC_UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidEndEditing:(LC_UISearchBar *)searchBar
{
    if (self.textDidEndEditingBlock) {
        self.textDidEndEditingBlock(searchBar);
    }
}

- (void)searchBar:(LC_UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.textDidChangedBlock) {
        self.textDidChangedBlock(searchBar,searchText);
    }
}

- (BOOL)searchBar:(LC_UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(LC_UISearchBar *)searchBar
{
    if (self.searchButtonClickedBlock) {
        self.searchButtonClickedBlock(searchBar);
    }
}

- (void)searchBarBookmarkButtonClicked:(LC_UISearchBar *)searchBar
{
    if (self.bookmarkButtonClickedBlock) {
        self.bookmarkButtonClickedBlock(searchBar);
    }
}

- (void)searchBarCancelButtonClicked:(LC_UISearchBar *) searchBar
{
    if (self.cancelButtonClickedBlock) {
        self.cancelButtonClickedBlock(searchBar);
    }
}

- (void)searchBarResultsListButtonClicked:(LC_UISearchBar *)searchBar
{
    if (self.resultsListButtonClickedBlock) {
        self.resultsListButtonClickedBlock(searchBar);
    }
}


@end
