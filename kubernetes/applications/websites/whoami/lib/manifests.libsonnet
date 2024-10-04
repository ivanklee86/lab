local manifestsLibrary = import "manifests/manifests.libsonnet";

(import './configs.libsonnet') +
{
    manifests: manifestsLibrary.new($._configs)
}
