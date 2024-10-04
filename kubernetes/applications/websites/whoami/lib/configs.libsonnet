local configs = import "manifests/configs.libsonnet";

configs + {
    _configs+: {
        name: "whoami",

        container+: {
            image: "containous/whami",
            tag: "latest"
        }
    }
}
