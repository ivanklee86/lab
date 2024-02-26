local configs = import './configs.libsonnet';
local manifests = import './manifests.libsonnet';
local testUtils = import './testUtils.libsonnet';


local TestManifestsService() =
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
          name: "http",
          port: 80,
          protocol: 'TCP',
          targetPort: 8080,
        },
      ],
      selector: {
        app: 'test',
      },
    },
  };
  true;

{
  TestManifestsService: TestManifestsService(),
}
