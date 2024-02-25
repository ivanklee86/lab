local k8s = import './k8s.libsonnet';
local k = k8s.k;

local envVar = k.core.v1.envVar;

{
  objToEnvVar(envVars):
    [envVar.new(x, std.toString(envVars[x])) for x in std.objectFields(envVars)],
}
