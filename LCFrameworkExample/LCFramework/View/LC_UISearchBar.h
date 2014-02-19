//
//  LC_UISearchBar.h
//  WuxianchangPro
//
//  Created by 郭历成 ( titm@tom.com ) on 13-10-31.
//  Copyright (c) 2013年 Wuxiantai Developer ( http://www.wuxiantai.com ). All rights reserved.
//

#import <UIKit/UIKit.h>

@class LC_UISearchBar;

typedef void (^SearchBarTextDidBeginEditingBlock)( LC_UISearchBar * searchBar );
typedef void (^SearchBarTextDidEndEditingBlock)( LC_UISearchBar * searchBar );
typedef void (^SearchBarTextDidChangedBlock)( LC_UISearchBar * searchBar, NSString * searchText );
typedef void (^SearchBarSearchButtonClickedBlock)( LC_UISearchBar * searchBar );
typedef void (^SearchBarBookmarkButtonClickedBlock)( LC_UISearchBar * searchBar );
typedef void (^SearchBarCancelButtonClickedBlock)( LC_UISearchBar * searchBar );
typedef void (^SearchBarResultsListButtonClickedBlock)( LC_UISearchBar * searchBar );

@interface LC_UISearchBar : UISearchBar

@property (nonatomic,copy) SearchBarTextDidBeginEditingBlock textDidBeginEditingBlock;
@property (nonatomic,copy) SearchBarTextDidEndEditingBlock textDidEndEditingBlock;
@property (nonatomic,copy) SearchBarTextDidChangedBlock textDidChangedBlock;
@property (nonatomic,copy) SearchBarSearchButtonClickedBlock searchButtonClickedBlock;
@property (nonatomic,copy) SearchBarBookmarkButtonClickedBlock bookmarkButtonClickedBlock;
@property (nonatomic,copy) SearchBarCancelButtonClickedBlock cancelButtonClickedBlock;
@property (nonatomic,copy) SearchBarResultsListButtonClickedBlock resultsListButtonClickedBlock;

@end
