define(["sitecore", "/-/speak/v1/ExperienceEditor/ExperienceEditor.js"], function (Sitecore, ExperienceEditor) {
  Sitecore.Commands.SaveProfile =
  {
    canExecute: function (context) {
      var isProfiling = ExperienceEditor.isDebugging() && ExperienceEditor.Web.getUrlQueryStringValue("sc_prof") == "1";
      return ExperienceEditor.canToggleDebug() && isProfiling;
    },
    execute: function (context) {
      context.currentContext.value = ExperienceEditor.Web.getUrlQueryStringValue("sc_prf");
      context.app.disableButtonClickEvents();
      ExperienceEditor.PipelinesUtil.initAndExecutePipeline(context.app.SaveDebugProfile, context);
      context.app.enableButtonClickEvents();
    }
  };
});