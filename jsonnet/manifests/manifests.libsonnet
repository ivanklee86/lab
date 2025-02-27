// Package
local onePWSecrets = import 'onePWSecrets.libsonnet';
local utils = import 'utils.libsonnet';
local wrapper = import 'wrapper.libsonnet';

// Kubernetes
local k8s = import './k8s.libsonnet';
local k = k8s.k;

// - Resources
local container = k.core.v1.container;
local containerPort = k.core.v1.containerPort;
local deployment = k.apps.v1.deployment;
local envFromSource = k.core.v1.envFromSource;
local ingress = k.networking.v1.ingress;
local ingressRule = k.networking.v1.ingressRule;
local httpIngressPath = k.networking.v1.httpIngressPath;
local service = k.core.v1.service;
local persistentVolumeClaim = k.core.v1.persistentVolumeClaim;
local volumeMount = k.core.v1.volumeMount;

{
  generateContainer(
    name='default',
    configs,
  ):
    container.new(
      name,
      '%s:%s' % [configs.container.image, configs.container.tag]
    ) +
    container.withImagePullPolicy('Always') +
    container.withEnv(utils.objToEnvVar(configs.container.envVars)) +
    container.withEnvFrom([envFromSource.secretRef.withName(x.name) for x in configs.secrets]) +
    container.withPorts([
      containerPort.newNamed(configs.ports.containerPort, 'http'),
    ])
    +
    container.withVolumeMounts(
      [
        volumeMount.withName(x.name) +
        volumeMount.withMountPath(x.path)
        for x in configs.volumes
      ]
    )
  ,

  generateDeployment(
    name='default',
    containerWrapper=null,
    configs={},
  ):
    deployment.new(
      name=name,
      replicas=1,
      containers=[
        wrapper.wrap(
          $.generateContainer(name=name, configs=configs),
          containerWrapper,
          configs
        ),
      ]
    ) +
    deployment.spec.selector.withMatchLabels({
      name: name,
    }) +
    deployment.spec.withReplicas(configs.replicas),

  generateIngress(name='default', configs):
    if utils.getKey(configs, ['ingress', 'enabled'], false) then
      ingress.new(name) +
      ingress.metadata.withAnnotations({
        'nginx.ingress.kubernetes.io/force-ssl-redirect': 'true',
      }) +
      ingress.metadata.withAnnotationsMixin(configs.ingress.annotations) +
      ingress.spec.withIngressClassName('nginx') +
      ingress.spec.withRules([
        ingressRule.withHost(x) +
        ingressRule.http.withPaths(
          httpIngressPath.withPath('/') +
          httpIngressPath.withPathType('Prefix') +
          httpIngressPath.backend.service.withName(name) +
          httpIngressPath.backend.service.port.withName(configs.ports.servicePort.name)
        )
        for x in configs.ingress.hosts
      ])
    else {},

  generateSecrets(
    secrets=[],
  ):
    [
      onePWSecrets.new(x.name, x.path)
      + onePWSecrets.metadata.withAnnotationsMixedIn({
        'argocd.argoproj.io/compare-options': 'IgnoreExtraneous',
        'argocd.argoproj.io/sync-options': 'Prune=false',
      })
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
        name: name,
      },
      ports=ports
    ),

  generatePersistentVolumeClaims(
    volumes=[]
  ):
    [
      persistentVolumeClaim.new(x.name) +
      persistentVolumeClaim.spec.withAccessModes('ReadWriteOnce') +
      persistentVolumeClaim.spec.resources.withRequests({ storage: x.size })
      for x in volumes
    ],

  new(configs, serviceWrapper=null, deploymentWrapper=null, containerWrapper=null, ingressWrapper=null):
    {
      deployment: wrapper.wrap(
        $.generateDeployment(
          name=configs.name,
          containerWrapper=containerWrapper,
          configs=configs,
        ),
        deploymentWrapper,
        configs
      ),
      ingress: wrapper.wrap(
        $.generateIngress(
          name=configs.name,
          configs=configs
        ),
        ingressWrapper,
        configs
      ),
      service: wrapper.wrap(
        $.generateService(
          name=configs.name,
          ports=configs.ports.servicePort,
          configs=configs
        ),
        serviceWrapper,
        configs
      ),
      secrets: $.generateSecrets(configs.secrets),
      pvcs: $.generatePersistentVolumeClaims(configs.volumes),
    },
}
