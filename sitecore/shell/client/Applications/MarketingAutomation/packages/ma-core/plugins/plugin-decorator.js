export function Plugin(pluginConfig) {
    return function (pluginConstructor) {
        pluginConstructor._pluginConfig = pluginConfig;
    };
}
//# sourceMappingURL=plugin-decorator.js.map