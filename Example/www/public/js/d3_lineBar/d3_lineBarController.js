define(["app","d3liquidFillGauge"], function(app,d3liquidFillGauge) {
    var $$ = Dom7;


    function dataInit(callBack){
        jhyx.getDeviceBatteryUsage({
            success:function(usage){
                callBack(usage);
            }
        });
    }

    function templateInit(query){
        var config = d3liquidFillGauge.liquidFillGaugeDefaultSettings();
        config.waveAnimateTime = 2000;
        d3liquidFillGauge.loadLiquidFillGauge("fillgauge1", query.usage,config);
        var config1 = d3liquidFillGauge.liquidFillGaugeDefaultSettings();
        config1.circleColor = "#FF7777";
        config1.textColor = "#FF4444";
        config1.waveTextColor = "#FFAAAA";
        config1.waveColor = "#FFDDDD";
        config1.circleThickness = 0.2;
        config1.textVertPosition = 0.2;
        config1.waveAnimateTime = 1000;
        d3liquidFillGauge.loadLiquidFillGauge("fillgauge2", query.usage, config1);
        var config2 = d3liquidFillGauge.liquidFillGaugeDefaultSettings();
        config2.circleColor = "#D4AB6A";
        config2.textColor = "#553300";
        config2.waveTextColor = "#805615";
        config2.waveColor = "#AA7D39";
        config2.circleThickness = 0.1;
        config2.circleFillGap = 0.2;
        config2.textVertPosition = 0.8;
        config2.waveAnimateTime = 2000;
        config2.waveHeight = 0.3;
        config2.waveCount = 1;
        d3liquidFillGauge.loadLiquidFillGauge("fillgauge3", query.usage, config2);
        var config3 = d3liquidFillGauge.liquidFillGaugeDefaultSettings();
        config3.textVertPosition = 0.8;
        config3.waveAnimateTime = 5000;
        config3.waveHeight = 0.15;
        config3.waveAnimate = false;
        config3.waveOffset = 0.25;
        config3.valueCountUp = false;
        config3.displayPercent = false;
        d3liquidFillGauge.loadLiquidFillGauge("fillgauge4", query.usage, config3);
        var config4 = d3liquidFillGauge.liquidFillGaugeDefaultSettings();
        config4.circleThickness = 0.15;
        config4.circleColor = "#808015";
        config4.textColor = "#555500";
        config4.waveTextColor = "#FFFFAA";
        config4.waveColor = "#AAAA39";
        config4.textVertPosition = 0.8;
        config4.waveAnimateTime = 1000;
        config4.waveHeight = 0.05;
        config4.waveAnimate = true;
        config4.waveRise = false;
        config4.waveOffset = 0.25;
        config4.textSize = 0.75;
        config4.waveCount = 3;
        d3liquidFillGauge.loadLiquidFillGauge("fillgauge5", query.usage, config4);
        var config5 = d3liquidFillGauge.liquidFillGaugeDefaultSettings();
        config5.circleThickness = 0.4;
        config5.circleColor = "#6DA398";
        config5.textColor = "#0E5144";
        config5.waveTextColor = "#6DA398";
        config5.waveColor = "#246D5F";
        config5.textVertPosition = 0.52;
        config5.waveAnimateTime = 5000;
        config5.waveHeight = 0;
        config5.waveAnimate = false;
        config5.waveCount = 2;
        config5.waveOffset = 0.25;
        config5.textSize = 1.2;
        config5.minValue = 30;
        config5.maxValue = 150
        config5.displayPercent = false;
        d3liquidFillGauge.loadLiquidFillGauge("fillgauge6", query.usage, config5);
    }

    function init(query){
        dataInit(function(usage){
            query.usage = parseInt(usage*100);
            templateInit(query);
        });
    }

    return {
        init:init,
    }
}); 