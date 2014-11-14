//
//  LC_UISearchBar.h
//  WuxianchangPro
//
//  Created by Licheng Guo . ( SUGGESTIONS & BUG titm@tom.com ) on 13-10-31.
//  Copyright (c) 2013年 Wuxiantai Developer ( http://www.wuxiantai.com ). All rights reserved.
//

#import <UIKit/UIKit.h>

@class LC_UISearchBar;

typedef BOOL (^LCSearchBarShouldBeginEditingBlock)( LC_UISearchBar * searchBar );
typedef void (^LCSearchBarTextDidBeginEditingBlock)( LC_UISearchBar * searchBar );
typedef void (^LCSearchBarTextDidEndEditingBlock)( LC_UISearchBar * searchBar );
typedef void (^LCSearchBarTextDidChangedBlock)( LC_UISearchBar * searchBar, NSString * searchText );
typedef void (^LCSearchBarSearchButtonClickedBlock)( LC_UISearchBar * searchBar );
typedef void (^LCSearchBarBookmarkButtonClickedBlock)( LC_UISearchBar * searchBar );
typedef void (^LCSearchBarCancelButtonClickedBlock)( LC_UISearchBar * searchBar );
typedef void (^LCSearchBarResultsListButtonClickedBlock)( LC_UISearchBar * searchBar );

@interface LC_UISearchBar : UISearchBar

@property (nonatomic,copy) LCSearchBarShouldBeginEditingBlock shouldBeginEditingBlock;
@property (nonatomic,copy) LCSearchBarTextDidBeginEditingBlock textDidBeginEditingBlock;
@property (nonatomic,copy) LCSearchBarTextDidEndEditingBlock textDidEndEditingBlock;
@property (nonatomic,copy) LCSearchBarTextDidChangedBlock textDidChangedBlock;
@property (nonatomic,copy) LCSearchBarSearchButtonClickedBlock searchButtonClickedBlock;
@property (nonatomic,copy) LCSearchBarBookmarkButtonClickedBlock bookmarkButtonClickedBlock;
@property (nonatomic,copy) LCSearchBarCancelButtonClickedBlock cancelButtonClickedBlock;
@property (nonatomic,copy) LCSearchBarResultsListButtonClickedBlock resultsListButtonClickedBlock;

@end
