{
  _configs: {
    name: 'default',

    ports: [
      {
        protocol: 'TCP',
        name: 'http',
        port: 80,
        targetPort: 8080,
      },
    ],

    secrets: [],  // { name: "a", path: "vaults/..." }
  },
}
