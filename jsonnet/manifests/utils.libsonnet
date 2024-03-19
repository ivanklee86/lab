local k8s = import './k8s.libsonnet';
local k = k8s.k;

local envVar = k.core.v1.envVar;

{
  objToEnvVar(envVars):
    [envVar.new(x, std.toString(envVars[x])) for x in std.objectFields(envVars)],

  getKey(object={}, keys=[], fallback):
    if !std.objectHas(object, keys[0]) then
      fallback
    else if std.length(keys) == 1 then
      object[keys[0]]
    else
      $.getKey(object[keys[0]], keys[1:], fallback),
}
