//
//  URL.h
//  RFProjectDemo
//
//  Created by 任 on 2019/7/15.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#ifndef URL_h
#define URL_h

#define isAppOnline 0            // 0、测试环境   1、正式环境

// >>>>>>>>>> 生产环境 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#if isAppOnline == 1
#define BaseUrl          @"http://api.jochtech.cn"
// >>>>>>>>>> 测试环境 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#else
#define BaseUrl          @"http://112.30.194.102:8081/sales/"
#endif








#endif /* URL_h */
