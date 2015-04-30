define(["app"], function(app) {
    var $$ = Dom7;

    // Json 高亮显示
    function syntaxHighlight(json) {
        if (typeof json != 'string') {
             json = JSON.stringify(json, undefined, 2);
        }
        json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
        return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
            var cls = 'number';
            if (/^"/.test(match)) {
                if (/:$/.test(match)) {
                    cls = 'key';
                } else {
                    cls = 'string';
                }
            } else if (/true|false/.test(match)) {
                cls = 'boolean';
            } else if (/null/.test(match)) {
                cls = 'null';
            }
            return '<span class="' + cls + '">' + match + '</span>';
        });
    }


    function demoScanQRCode() {
        jhyx.scanQRCode({
            success:function(response){
                $$('#scanResult').html(syntaxHighlight(response));
            }
        });
    }


    function demoChooseImage(soureType) {
        jhyx.chooseImage({
            soureType:soureType,
            success:function(response){
                // base64
                var imgSrc = "data:image/png;base64," + response.data.base64Data;
                $$('#ChooseImageBase64').attr('src',imgSrc);

                // 图片地址
                response.data.base64Data = response.data.base64Data.substring(0,50);
                $$('#ChooseImageResult').html(syntaxHighlight(response));
            },
            percentDone:function(percentDone){
                $$('#ChooseImagePercenDone').html(percentDone);
            },
            uploadStart:function(){
                app.f7.alert('开始上传');
            }
        });
    }


    function demoGetLocation(){
        jhyx.getLocation({
            success:function(response){
                $$('#GetLocationResult').html(syntaxHighlight(response));
            }
        });
    }


    function demoCloseWindow(){
        jhyx.closeWindow();
    }


    function demoShareSocialNetwork(params){
        jhyx.shareSocialNetwork({
            params:params,
        });
    }

    // 模板变量
    var part5 = app.template7Compile('part5');

    function init(){

        if (typeof(jhyx) == "undefined") {
            app.f7.alert('请在app内运行本页面');
        };

        // 扫描二维码
        $$(".ScanQRCode").on('click',function(){
            demoScanQRCode();
        }); 

        // 选取图片
        $$(".ChooseImage").on('click',function(){
            var actionSheetButtons = [
                // First buttons group
                [
                    // Group Label
                    {
                        text: '选取图片来源',
                        label: true
                    },
                    // First button
                    {
                        text: '从相册选取',
                        onClick: function () {
                            demoChooseImage(0);
                        }
                    },
                    // Another button
                    {
                        text: '拍照上传',
                        onClick: function () {
                            demoChooseImage(1);
                        }
                    },
                ],

                // Second group
                [
                    {
                        text: '取消',
                        color: 'red',
                        bold: true
                    }
                ]
            ];

            app.f7.actions(actionSheetButtons);

        }); 

        // 选取地理位置
        $$(".GetLocation").on('click',function(){
            demoGetLocation();
        });  


        $$(".closeWindow").on('click',function(){
            demoCloseWindow();
        });

        // 初始化Dom内容
        var part5_html = part5({
            name:'Template7',
            where:'JsBridgeController.init',
            people : [
                {
                  name: 'John',
                  job: 'phper'
                },
                {
                  name: 'Mark',
                  job: 'ioser'
                },
            ]
        });

        $$("#part5_html").html(part5_html);

        // 分享接口
        var shareParams = {
            content:'分享内容（必填）',
            defaultContent:'默认内容',
            image:'http://ac-ahjekkg2.clouddn.com/wnfxLNnawLrtgTgHszBU2Nc1BuzIXe003KBkykpu.png',
            title:'分享标题（必填）',
            url:'http://www.idangero.us/framework7/kitchen-sink/',
            description:'简要概述',
        }

        $$("#shareSocialNetworkParams").html(syntaxHighlight(shareParams));

        $$(".shareSocialNetwork").on('click',function(){
            demoShareSocialNetwork(shareParams);
        });
    }


    return {
        init:init,
    }

});