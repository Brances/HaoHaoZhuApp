//
//  ZMApi.h

//
//  Created by Brances on 2018/4/9.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KAPIBaseURL                                          @"https://yapi.haohaozhu.com/"

#define KAPIGetDeviceID                                      KAPIBaseURL@"visitor/getVid"
#define KAPISaveDeviceID                                    KAPIBaseURL@"visitor/saveDevice"
#define KAPIHomeRecommendMergeHead           KAPIBaseURL@"Recommend/getMergeHead"
#define KAPIHomeRecommendMergedList           KAPIBaseURL@"Recommend/getMergedList3_2"
#define KAPIBeautyTopBanner                             KAPIBaseURL@"Recommend/getBanner"
#define KAPIBeautyNodeList                                KAPIBaseURL@"Recommend/getScrollCard"
#define KAPIExampleCategoryList                        KAPIBaseURL@"ArticleSelect/SearchFilter"
#define KAPIExampleSmallItemList                        KAPIBaseURL@"ArticleSelect/GetSitem"
#define KAPIExampleBigItemList                           KAPIBaseURL@"ArticleSelect/getarticle"
#define KAPISearchAllTagList                               KAPIBaseURL@"searchTag/getAll"
//#define KAPIArticleDetail                                      @"https://api.haohaozhu.com/index.php/Home/Article/article_detail2_0"//废弃
#define KAPIArticleDetail                                      KAPIBaseURL@"Article/detail"
#define KAPIArticleBaseCommentList                   @"https://capi.haohaozhu.com/index.php/Home/Comments/base_comment2_14"
#define KAPIArticleRelaRecommend                     KAPIBaseURL@"Article/RelaRecommend"


