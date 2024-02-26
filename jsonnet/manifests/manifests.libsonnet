local wrapper = import '.wrapper.libsonnet';

local k8s = import './k8s.libsonnet';
local k = k8s.k;
local service = k.core.v1.service;


{
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
    },
}
