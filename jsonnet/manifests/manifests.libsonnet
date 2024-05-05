// Package
local wrapper = import '.wrapper.libsonnet';
local onePWSecrets = import 'onePWSecrets.libsonnet';
local utils = import 'utils.libsonnet';

// Kubernetes
local k8s = import './k8s.libsonnet';
local k = k8s.k;

// - Resources
local container = k.core.v1.container;
local containerPort = k.core.v1.containerPort;
local deployment = k.apps.v1.deployments;
local envFromSource = k.core.v1.envFromSource;
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
    deployment.name(
      name=name,
      replicas=1,
      // containers=[
      //   wrapper.wrap(
      //     $.generateContainer(name=configs, configs),
      //   )
      // ]
    ),

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
        app: name,
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

  new(configs, serviceWrapper=null, deploymentWrapper=null, containerWrapper=null):
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
      service: wrapper.wrap(
        $.generateService(
          name=configs.name,
          ports=configs.ports,
          configs=configs
        ),
        serviceWrapper,
        configs
      ),
      secrets: $.generateSecrets(configs.secrets),
      pvcs: $.generatePersistentVolumeClaims(configs.volumes),
    },
}
