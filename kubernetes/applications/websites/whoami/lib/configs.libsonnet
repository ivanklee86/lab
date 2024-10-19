local configs = import "manifests/configs.libsonnet";

configs + {
    _configs+: {
        name: "whoami",

        container+: {
            image: "containous/whoami",
            tag: "latest"
        },

        ports+: {
            containerPort: 80
        },

        ingress+: {
            enabled: true,
            hosts: ["whoami.aoach.tech"]
        }
    }
}
