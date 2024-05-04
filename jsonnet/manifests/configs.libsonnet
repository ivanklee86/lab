{
  _configs: {
    name: 'default',

    container: {
      image: 'alpine',
      tag: '3',
      envVars: {},
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

    volumes: [],  // {}
  },
}
