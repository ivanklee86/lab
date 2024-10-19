{
  new(name='default', path='vaults/...'): {
    apiVersion: 'onepassword.com/v1',
    kund: 'OnePasswordItem',
    metadata: {
      name: name,
    },
    spec: {
      itemPath: path,
    },
  },
  metadata: {
    withAnnotations(annotations={}): { metadata+: { annotations: annotations } },
    withAnnotationsMixedIn(annotations={}): { metadata+: { annotations+: annotations } },
  },
}
