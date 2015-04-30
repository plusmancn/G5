 /**
         * 二维码扫描接口
         */
//        [_bridge registerHandler:@"scanQRCode" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
//            [self leaveOutShowNavigation];
//            
////            [JuJsSdk scanQrCode:self.navigationController
////                     scanResult:^(NSDictionary *resultDic) {
////                        responseCallback(@{@"errorCode":@0,
////                                           @"errorMessage":@"success",
////                                           @"data":resultDic[@"string"]
////                                           });
////            }];
//            
//        }];
//        
//        
//        /**
//         * 图像选择接口
//         */
//        [_bridge registerHandler:@"chooseImage" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
//            [self leaveOutShowNavigation];
//            
////            UIImagePickerControllerSourceType soureType = (UIImagePickerControllerSourceType)[data[@"soureType"] integerValue];
////            
////            [JuJsSdk chooseImage:self.navigationController
////                       soureType:soureType
////             returnImageData:^(NSDictionary *resultDic) {
////                 
////                 responseCallback(@{@"errorCode":@0,
////                                    @"errorMessage":@"success",
////                                    @"data":resultDic
////                                    });
////                 
////             } returnUploadProcess:^(NSInteger resultNum) {
////                 
////                 [_bridge callHandler:@"getUploadProcess"
////                                 data:[NSNumber numberWithInteger:resultNum]
////                  ];
////                 
////             } returnUploadStart:^{
////                 [_bridge callHandler:@"uploadStart"];
////             }];
//            
//            
//        }];
//        
//        /**
//         * 地理位置选取接口
//         */
//        [_bridge registerHandler:@"getLocation" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
//            [self leaveOutShowNavigation];
//            
////            [JuJsSdk getLocation:self.navigationController result:^(NSDictionary *resultDic) {
////                responseCallback(@{@"errorCode":@0,
////                                   @"errorMessage":@"success",
////                                   @"data":resultDic
////                                   });
////            }];
//        }];
//        
//        
//        /**
//         * 地理位置展示接口
//         */
//        [_bridge registerHandler:@"openLocation" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
//            [self leaveOutShowNavigation];
//            
////            [JuJsSdk openLocation:self.navigationController
////                             Lat:[data[@"latitude"] floatValue]
////                             lng:[data[@"longitude"] floatValue]
////                           title:data[@"address"]
////            ];
//        }];
//        
//        /**
//         * 位置签到
//         */
//        [_bridge registerHandler:@"mapMeetCheckIn" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
//            [self leaveOutShowNavigation];
//            
////            [JuJsSdk openLocation:self.navigationController
////                              Lat:[data[@"latitude"] floatValue]
////                              lng:[data[@"longitude"] floatValue]
////                            title:data[@"address"]
////                        meetingId:data[@"meetingId"]
////             ];
//            
//        }];
//        
//        /**
//         * 关闭当前窗口
//         */
//        [_bridge registerHandler:@"closeWindow" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
//            if (self.navigationController != nil) {
//                [self.navigationController popViewControllerAnimated:YES];
//            }else{
//                
//                [self dismissViewControllerAnimated:YES completion:^{
//                    //  do something
//                }];
//            }
//            
//        }];
//        
//        /**
//         * 分享接口
//         */
//        [_bridge registerHandler:@"shareSocialNetwork" handler:^(id data, WVJBResponseCallback responseCallback) {
////            [JuJsSdk shareSocialNetwork:data];
//        }];
//        
//        /**
//         * 打开好友名片
//         */
//        [_bridge registerHandler:@"openUserNameCard" handler:^(id data, WVJBResponseCallback responseCallback) {
//            [self leaveOutShowNavigation];
//            
////            [JuJsSdk openUserNameCard:self.navigationController
////                          RnameCardId:data[@"nameCardId"]
////            ];
//        }];
//        
//        
//        [_bridge registerHandler:@"openUrl" handler:^(id data, WVJBResponseCallback responseCallback) {
//            
////            [JuJsSdk openUrl:data[@"url"]];
//        
//        }];