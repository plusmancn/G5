;(function() {

function _connectWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) {
        callback(WebViewJavascriptBridge)
    } else {
        document.addEventListener('WebViewJavascriptBridgeReady', function() {
            callback(WebViewJavascriptBridge)
        }, false)
    }
}

_connectWebViewJavascriptBridge(function(bridge) {
    /* Init your app here */
    bridge.init(function(message, responseCallback) {
        console.log('Received message: ' + message)   
        if (responseCallback) {
            responseCallback("Right back ObjC")
        }
    });

    
    /**
     * 扫描二维码
     */
    function scanQRCode(params) {
        var lastParams = {
            needResult: 1, // 默认为1，0扫描结果由会友行处理，1则直接返回扫描结果，
            scanType:["qrCode"], // 可以指定扫二维码还是一维码，目前只支持二维码
        }

        var scanQRCodeCallback = {
            success:params.success,
            error:params.error
        }

        bridge.callHandler('scanQRCode', lastParams , function(response) {
            if (response.errorCode == 0) {
                scanQRCodeCallback.success(response);
            }
        });
    }

    /**
     * 图片上传
     */
    function chooseImage(params) {
        var lastParams = {
            soureType:parseInt(params.soureType), // 0 来自相册，1来自相机
        }

        var chooseImageCallback = {
            success:params.success,
            error:params.error,
            percentDone:params.percentDone,
            uploadStart:params.uploadStart
        }

        bridge.registerHandler("getUploadProcess", function(percentDone) {
            if (chooseImageCallback.percentDone != undefined) {
                chooseImageCallback.percentDone(percentDone);
            }
        });

        bridge.registerHandler("uploadStart",function(){
            if (chooseImageCallback.uploadStart != undefined) {
                chooseImageCallback.uploadStart();
            }
        });

        bridge.callHandler('chooseImage', lastParams , function(response) {

            if (response.errorCode == 0) {
                chooseImageCallback.success(response);
            }
        });
    }


    /**
     * 地址选择
     */
    function getLocation(params) {
        var lastParams = {
        }

        var getLocationCallback = {
            success:params.success,
            error:params.error,
        }

        bridge.callHandler('getLocation', lastParams , function(response) {

            if (response.errorCode == 0) {
                getLocationCallback.success(response);
            }
        });
    }
    

    /**
     * 分享到社交网络
     */
    function shareSocialNetwork(params){
        var lastParams = params.params;
        bridge.callHandler('shareSocialNetwork',lastParams);
    }


    /**
     * 关闭当前窗口
     */
    function closeWindow(){
        var lastParams = {

        }
        
        bridge.callHandler('closeWindow',lastParams);
    }

    /**
     * 发送通知
     */
    function postNotification(params){
        var lastParams = {
            name:params.name,
        }

        bridge.callHandler('postNotification',lastParams);
    }


    /**
     * 打开位置
     */
    function openLocation(params){
        
        var lastParams = {
            latitude: params.latitude, // 纬度，浮点数，范围为90 ~ -90
            longitude: params.longitude, // 经度，浮点数，范围为180 ~ -180。
            address: params.address,
        }

        bridge.callHandler('openLocation',lastParams);
    }

    /**
     * 开启位置签到
     */
    function mapMeetCheckIn(params){
        var lastParams = {
            latitude: params.latitude, // 纬度，浮点数，范围为90 ~ -90
            longitude: params.longitude, // 经度，浮点数，范围为180 ~ -180。
            address: params.address,
            meetingId:params.meetingId
        }

        bridge.callHandler('mapMeetCheckIn',lastParams);
    }

    /**
     * 打开好友名片
     */
    function openUserNameCard(params){
        
        var lastParams = {
            nameCardId:params.nameCardId,
        }
        
        bridge.callHandler('openUserNameCard',lastParams);
    }

    /**
     * 打开URL
     */
    function openUrl(params){
        var lastParams = {
            url:params.url,
        }

        bridge.callHandler('openUrl',lastParams);
    }

    window.jhyx = {
        // scanQRCode:scanQRCode,
        // chooseImage:chooseImage,
        // getLocation:getLocation,
        // closeWindow:closeWindow,
        // shareSocialNetwork:shareSocialNetwork,
        postNotification:postNotification,
        // openLocation:openLocation,
        // mapMeetCheckIn:mapMeetCheckIn,
        // openUserNameCard:openUserNameCard,
        // openUrl:openUrl,
        // connectWebViewJavascriptBridge:_connectWebViewJavascriptBridge
    }


})

})();