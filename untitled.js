
function setupWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
    if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
    window.WVJBCallbacks = [callback];
    var WVJBIframe = document.createElement('iframe');
    WVJBIframe.style.display = 'none';
    WVJBIframe.src = 'https://__bridge_loaded__';
    document.documentElement.appendChild(WVJBIframe);
    setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
}


function openUserLogin(){
    setupWebViewJavascriptBridge(function(bridge) {
                                 log('JS calling handler "openUserLogin"')
                                 bridge.callHandler('openUserLogin', , function(response) {
                                                    
                                                    })
                                 }
                                 
function goHome(){
setupWebViewJavascriptBridge(function(bridge) {
                            log('JS calling handler "goHome"')
                            bridge.callHandler('goHome', , function(response) {
                                               
                                               })
                            
                            }


alert("openVip");                          
function openVip(){

alert("openVip");
}

function openPriceList(){

alert("openPriceList");

}

function openPriceDetail(code){

alert("openPriceDetail");
}


function openFundin(){

alert("openFundin");

}


function customService(){

alert("customService");

}

function openUserRegister(){

alert("openUserRegister");

}

function  openHelpCenter(){

alert("openHelpCenter");
                                  }
                                                              
                                                              
                                                              

