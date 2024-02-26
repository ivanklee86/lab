local wrapper = import '.wrapper.libsonnet';
local onePWSecrets = import 'onePWSecrets.libsonnet';

local k8s = import './k8s.libsonnet';
local k = k8s.k;
local service = k.core.v1.service;


{
  generateSecrets(
    secrets=[],
  ):
    [
      onePWSecrets.new(x.name, x.path)
      + onePWSecrets.metadata.withAnnotationsMixedIn( {
          'argocd.argoproj.io/compare-options': 'IgnoreExtraneous',
          'argocd.argoproj.io/sync-options': 'Prune=false'
      } )
      for x in secrets
    ],

  generateService(
    name='default',
    ports=[],
    configs={}
  ):
    service.new(
      name=name,
      selector={
        app: name,
      },
      ports=ports
    ),


  new(configs, serviceWrapper=null):
    {
      service: wrapper.wrap($.generateService(name=configs.name, ports=configs.ports, configs=configs), serviceWrapper, configs),
      secrets: $.generateSecrets(configs.secrets),
    },
}
