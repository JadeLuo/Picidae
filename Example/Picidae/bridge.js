/**
 * Created by Neo on 2017/03/02.
 */
(function(win) {

    var ua = navigator.userAgent;

    function getQueryString(name) {
        var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
        var r = window.location.search.substr(1).match(reg);
        if (r !== null) return unescape(r[2]);
        return null;
    }

    function isAndroid() {
        return ua.indexOf('Android') > 0;
    }

    function isIOS() {
        return /(iPhone|iPad|iPod)/i.test(ua);
    }

    function checkAppRouterValidity(argument) {
        // body... 
        if ((isAndroid() || isIOS()) && (typeof(win['bridge']) !== 'undefined') === true) {
            return true;
        } else {
            return false;
        }
    }

    var mobile = {

        /**
         *通过bridge调用app端的方法
         * @param method
         * @param params
         * @param callback
         */
        callAppRouter: function(method, params, callback) {
            var req = {
                'Method': method,
                'Data': params
            };
            if (isIOS()) {
                win.bridge.callRouter(req, function(err, result) {
                    var resultObj = null;
                    var errorMsg = null;
                    if (typeof(result) !== 'undefined' && result !== 'null' && result !== null) {
                        resultObj = JSON.parse(result);
                        if (resultObj) {
                            resultObj = resultObj['result'];
                        }
                    }
                    if (err !== 'null' && typeof(err) !== 'undefined' && err !== null) {
                        errorMsg = err;
                    }
                    callback(err, resultObj);
                });
            } else if (isAndroid()) {
                //生成回调函数方法名称
                var cbName = 'CB_' + Date.now() + '_' + Math.ceil(Math.random() * 10);
                //挂载一个临时函数到window变量上，方便app回调
                win[cbName] = function(err, result) {
                    var resultObj;
                    if (typeof(result) !== 'undefined' && result !== null) {
                        resultObj = JSON.parse(result)['result'];
                    }
                    callback(err, resultObj);
                    //回调成功之后删除挂载到window上的临时函数
                    delete win[cbName];
                };
                win.bridge.callRouter(JSON.stringify(req), cbName);
            }
        },
        /**
         * H5登录成功之后，保存ticket到app端
         * @param userTicket
         * @param callback
         */
        saveUserTicket: function(userTicket, callback) {
            this.callAppRouter('SaveTicket', { 'userTicket': userTicket }, function(err, res) {
                console.log('saveUserTicket call back');
                console.log(res);
                var newUserTicket;
                var referrer = getQueryString('referrer');
                callback(err, newUserTicket);
                if (typeof(res) !== 'undefined' && res !== null) {
                    newUserTicket = res['userTicket'];
                    console.log(newUserTicket);
                    if (typeof(referrer) !== 'undefined') {
                        window.location.href = referrer;
                    }
                } else {
                    window.location.href = '/account/common/transferPage.htm';
                }
            });
        },
        login: function() {
            // body...
            this.callAppRouter('Login', null, function(errMsg, res) {
                // body...

                if (errMsg !== null && errMsg !== 'undefined' && errMsg !== 'null') {

                } else {
                    var name = res['phone'];
                    if (name !== 'undefined' && name !== 'null') {
                        var button = document.getElementById('loginButton');
                        button.innerHTML = name;
                    }
                }
            });
        }
    };

    //将mobile对象挂载到window全局
    win.webBridge = mobile;
})(window);
