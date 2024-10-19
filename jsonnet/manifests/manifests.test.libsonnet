local configs = import './configs.libsonnet';
local manifests = import './manifests.libsonnet';
local testUtils = import './testUtils.libsonnet';


local TestgenerateContainer() =
  assert manifests.generateContainer(
    'default',
    configs._configs + { volumes: [{ name: '1', path: 'path1', size: '1Gi' }] }
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

local TestGenerateIngress() =
  assert testUtils.debug(manifests.generateIngress(
    'default',
    configs._configs + { ingress+: { enabled: true, hosts: ['a.com', 'www.a.com'] } }
  )) == {
    apiVersion: 'networking.k8s.io/v1',
    kind: 'Ingress',
    metadata: {
      annotations: {
        'nginx.ingress.kubernetes.io/force-ssl-redirect': 'true',
      },
      name: 'default',
    },
    spec: {
      ingressClassName: 'nginx',
      rules: [
        {
          host: 'a.com',
          http: {
            paths: [
              {
                backend: {
                  service: {
                    name: 'default',
                    port: {
                      name: 'http',
                    },
                  },
                },
                path: '/',
                pathType: 'Prefix',
              },
            ],
          },
        },
        {
          host: 'www.a.com',
          http: {
            paths: [
              {
                backend: {
                  service: {
                    name: 'default',
                    port: {
                      name: 'http',
                    },
                  },
                },
                path: '/',
                pathType: 'Prefix',
              },
            ],
          },
        },
      ],
    },
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

local TestGenerateDeployment() =
  assert manifests.generateDeployment('foobar', null, configs._configs) == {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: 'foobar',
    },
    spec: {
      replicas: 1,
      selector: {
        matchLabels: {
          app: 'foobar',
        },
      },
      template: {
        metadata: {
          labels: {
            name: 'foobar',
          },
        },
        spec: {
          containers: [
            {
              env: [

              ],
              envFrom: [

              ],
              image: 'alpine:3',
              imagePullPolicy: 'Always',
              name: 'foobar',
              ports: [
                {
                  containerPort: 8080,
                  name: 'http',
                },
              ],
              volumeMounts: [

              ],
            },
          ],
        },
      },
    },
  };
  true;

local TestNew() =
  assert manifests.new(configs._configs) != {};
  true;

{
  TestGenerateContainer: TestgenerateContainer(),
  TestGenerateIngress: TestGenerateIngress(),
  TestGenerateSecrets: TestGenerateSecrets(),
  TestGenerateService: TestGenerateService(),
  TestGeneratePersistentVolumeClaims: TestGeneratePersistentVolumeClaims(),
  TestGenerateDeployment: TestGenerateDeployment(),
  TestNew: TestNew(),
}
