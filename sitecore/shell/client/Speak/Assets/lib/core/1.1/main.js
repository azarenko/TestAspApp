﻿(function (global) {
  require.config({
    baseUrl: "/",
    paths: {
        jquery: "/sitecore/shell/client/Speak/Assets/lib/core/1.1/deps/jQuery/jquery-2.1.1",
        underscore: "/sitecore/shell/client/Speak/Assets/lib/core/1.1/deps/underscore/underscore.1.4.4",
        knockout: "/sitecore/shell/client/Speak/Assets/lib/core/1.1/deps/ko/knockout-2.2.1",
        backbone: "/sitecore/shell/client/Speak/Assets/lib/core/1.1/deps/backbone/backbone.1.0.0",
        sitecore: "/sitecore/shell/client/Speak/Assets/lib/core/1.1/sitecore-1.0.2",        
        bootstrap: "/sitecore/shell/client/Speak/Assets/lib/ui/1.1/bootstrap",
        jqueryui: "/sitecore/shell/client/Speak/Assets/lib/ui/1.1/deps/jQueryUI/jquery-ui-1.10.1.custom"
    },
    shim: {
      'jquery': { exports: 'jQuery' },
      'jqueryui': { deps: ['jquery'] },
      'underscore': { exports: '_' },
      'knockout': { deps: ['underscore'], exports: 'ko' },
      'backbone': { deps: ['jquery', 'underscore'], exports: 'Backbone' },
      'sitecore': { deps: ['backbone', 'knockout'], exports: 'Sitecore.Speak' },
      'dynatree': { deps: ['jqueryui'/*, 'css!dynatreecss'*/] }
    },
    map: {
      '*': {
          'css': '/sitecore/shell/client/Speak/Assets/lib/core/1.1/deps/css.js'
      }
    }
  });

  require(["sitecore", "jquery"], function (_sc, $) {
    $(function () { _sc.load(global); });
  });
})(this);