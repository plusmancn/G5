requirejs.config({
    "urlArgs": "bust=" + document.getElementById('appEntrance').getAttribute('data-version'),
    "baseUrl": 'public/',
    "paths": {
        jquery:'lib/jquery-2.1.3.min',
        jqueryValidator:'lib/jquery.form-validator.min',
    },
    "shim": {
        "jqueryValidator": ["jquery"],
    }
});


define('app', ['router'], function(Router) {

    Router.init();

    var browser={
        versions:function(){
            var u = navigator.userAgent, app = navigator.appVersion;
            return {
                trident: u.indexOf('Trident') > -1, //IE内核
                presto: u.indexOf('Presto') > -1, //opera内核
                webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
                gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,//火狐内核
                mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
                ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
                iPhone: u.indexOf('iPhone') > -1 , //是否为iPhone或者QQHD浏览器
                iPad: u.indexOf('iPad') > -1, //是否iPad
                webApp: u.indexOf('Safari') == -1, //是否web应该程序，没有头部与底部
                weixin: u.indexOf('MicroMessenger') > -1, //是否微信 （2015-01-22新增）
                qq: u.match(/\sQQ/i) == " qq" //是否QQ
            };
        }(),
        language:(navigator.browserLanguage || navigator.language).toLowerCase()
    }

    if (browser.versions.ios) {
        var f7 = new Framework7({
            //pushState: true,
            modalTitle: '会友行',
            modalButtonOk: '确定',
            modalButtonCancel: '取消',
            modalPreloaderTitle: '加载中...',

            //fastClicks: false,

            //暂时没有用到的功能。
            swipeout: false,
            sortable: false,

            // Hide and show indicator during ajax requests
            onAjaxStart: function (xhr) {
                f7.showIndicator();
            },
            onAjaxComplete: function (xhr) {
                f7.hideIndicator();
            }
        });

    }else{
        var f7 = new Framework7({
            //pushState: true,
            modalTitle: '会友行',
            modalButtonOk: '确定',
            modalButtonCancel: '取消',
            modalPreloaderTitle: '加载中...',
            
            //fastClicks: false,

            //暂时没有用到的功能。
            swipeout: false,
            sortable: false,

            swipeBackPage: false,
            swipeBackPageAnimateShadow: false,
            swipeBackPageAnimateOpacity: false,
            animatePages: false,//页面滑动切换效果

            // Hide and show indicator during ajax requests
            onAjaxStart: function (xhr) {
                f7.showIndicator();
            },
            onAjaxComplete: function (xhr) {
                f7.hideIndicator();
            }
        });

    }

    
    var $$ = Dom7;

    // 注册模板函数 ifext
    Template7.registerHelper('ifext', function (condition,options) {
        // First we need to check is the passed context is function
        if (typeof condition === 'function') condition = condition.call(this);
            // If context condition
        if (condition == options.hash.eq) {
            // We need to pass block content further to compilier with the same context and the same data:
            return options.fn(this, options.data);
        }else {
            // We need to pass block inverse ({{else}}) content further to compilier with the same context and the same data:
            return options.inverse(this, options.data);
        }
    });


    // 模板编译函数
    var template7Compile = function(templeId){
        var rawTemplate = $$('script#'+templeId).html();
        var compiledTemplate = Template7.compile(rawTemplate);
        return compiledTemplate;
    }
    
    // Add view
    var mainView = f7.addView('.view-main', {
        // Because we use fixed-through navbar we can enable dynamic navbar
        dynamicNavbar: true,
        // Enable Dom Cache so we can use all inline pages
        domCache: true,
    });

    return {
        f7: f7,
        mainView: mainView,
        router: Router,
        template7Compile:template7Compile,
    };

});
