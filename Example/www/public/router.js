define(function() {
    // Export selectors engines
    var $$ = Dom7;

    // 路由需要忽略的路径
    var ignoreList = [
        'index',
        'form'
    ];

    /**
     * Init router, that handle page events
     */
    function init() {
        $$(document).on('pageBeforeInit', function (e) {
            var page = e.detail.page;

            if (page.url == false) {
                query = $$.parseUrlQuery(location.href);
            }else{
                query = page.query;
            }

            load(page.name, query);
        });

        // 整合页面事件
        $$(document).on('pageAfterAnimation',function (e){
            
            if (typeof(jhyx) != 'undefined') {
                var reg  = /\/(\w+)\.(html|ejs)/gi;
                // 页面名称
                var page = e.detail.page;
                // 页面事件加载
                var execResult = reg.exec(location.href);

                if (execResult[1] == page.name) {
                    jhyx.postNotification({
                        'name':'G5_Noti_enabledNativeBackEffect'
                    });
                }else{
                    jhyx.postNotification({
                        'name':'G5_Noti_diabledNativeBackEffect'
                    });
                }
            };

        });
    }
    
    /**
     * Load (or reload) controller from js code (another controller) - call it's init function
     * @param controllerName
     * @param query
     */
    function load(controllerName, query) {
        if (ignoreList.indexOf(controllerName) == -1) {
            require(['js/' + controllerName + '/'+ controllerName + 'Controller'], function(controller) {
                controller.init(query);
            });
        };
    }

    return {
        init: init,
        load: load
    };
});