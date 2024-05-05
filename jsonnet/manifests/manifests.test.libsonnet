local configs = import './configs.libsonnet';
local manifests = import './manifests.libsonnet';
local testUtils = import './testUtils.libsonnet';


local TestgenerateContainer() =
  assert testUtils.debug(
    manifests.generateContainer('default',
                                configs._configs + { volumes: [{ name: '1', path: 'path1', size: '1Gi' }] })
  ) == {
    env: [],
    envFrom: [],
    image: 'alpine:3',
    imagePullPolicy: 'Always',
    name: 'default',
    ports: [
      {
        containerPort: 8080,
        name: 'http',
      },
    ],
    volumeMounts: [
      {
        mountPath: 'path1',
        name: '1',
      },
    ],
  };
  true;

local TestGenerateSecrets() =
  assert std.length(manifests.generateSecrets([
    { name: 'a', path: 'path1' },
    { name: '2', path: 'path2' },
  ])) == 2;
  true;

local TestGenerateService() =
  assert manifests.generateService(
    name='test',
    ports=configs._configs.ports,
    configs=configs._configs
  ) == {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: 'test',
    },
    spec: {
      ports: [
        {
          containerPort: 8080,
          servicePort: {
            name: 'http',
            port: 80,
            protocol: 'TCP',
            targetPort: 'http',
          },
        },
      ],
      selector: {
        app: 'test',
      },
    },
  };
  true;

local TestGeneratePersistentVolumeClaims() =
  assert std.length(manifests.generatePersistentVolumeClaims([
    { name: 'a', path: 'path1', size: '1Gi' },
    { name: '2', path: 'path2', size: '1Gi' },
  ])) == 2;
  true;

{
  TestgenerateContainer: TestgenerateContainer(),
  TestGenerateSecrets: TestGenerateSecrets(),
  TestGenerateService: TestGenerateService(),
  TestGeneratePersistentVolumeClaims: TestGeneratePersistentVolumeClaims(),
}
