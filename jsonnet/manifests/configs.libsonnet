{
  _configs:: {
    name: 'default',

    container: {
      image: 'alpine',
      tag: '3',
      envVars: {},
    },

    replicas: 1,

    ingress: {
      enabled: false,
      annotations: {},
      hosts: [],  // [a.com, www.a.com]
    },

    ports: {
      servicePort: {
        protocol: 'TCP',
        name: 'http',
        port: 80,
        targetPort: 'http',
      },
      containerPort: 8080,
    },

    secrets: [],  // { name: "a", path: "vaults/..." }

    volumes: [],  // { name: "a", path: "", size: "5g"}
  },
}
