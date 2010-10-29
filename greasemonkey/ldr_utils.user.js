// ==UserScript==
// @name          Utilities for livedoor Reader
// @description   Make livedoor Reader more convenient.
// @namespace     http://antipop.gs/ns/greasemonkey/ldr_utils
// @include       http://reader.livedoor.com/reader/*
// modified from http://d.hatena.ne.jp/antipop/20060430/1146343265
// ==/UserScript==

(function(){
     var w = unsafeWindow;
     var _onload = w.onload;
     var onload  = function(){
         with (w) {
             // hide ads
             ['ads_top', 'ads_bottom'].forEach(function(v){DOM.hide(v);});

             // move total-unread-count into the control box
             var total_unread_count = DOM.clone($('total_unread_count'));
             setStyle(total_unread_count, {
                          'position' : 'absolute',
                          'right'    : '150px',
                          'top'      : '5px',
                          'font-size': '12px'
                      });
             DOM.remove('total_unread_count');
             DOM.insert($('control'), total_unread_count, $('fontpad'));

             // replace Control.toggle_fullscreen with custom function
             var toggle_fullscreen_with_control = function(){
                 var fs = [];
                 var elements = ['header', 'menu', 'control', 'footer'];
                 fs[0] = ['header', 'menu', 'control', 'footer'];
                 fs[1] = ['menu', 'control'];
                 fs[2] = ['control'];
                 fs[3] = [];
                 if(!State.fullscreen){
                     State.fullscreen = 1;
                 } else if(State.fullscreen == fs.length-1){
                     State.fullscreen = 0;
                 } else {
                     State.fullscreen++
                 }
                 Element.hide(elements);
                 Element.show(fs[State.fullscreen]);
                 fit_screen()
             };
             Keybind.add("Z", toggle_fullscreen_with_control);

             // make the view-area wide on the page loaded
             var i = 2;
             while (i) {
                 toggle_fullscreen_with_control();
                 i--;
             }
         }
     };

     w.onload = function(){
         _onload();
         onload();
     };
})();

