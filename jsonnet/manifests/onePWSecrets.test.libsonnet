local onePWSecrets = import './onePWSecrets.libsonnet';
local testUtils = import './testUtils.libsonnet';

local TestOnePWSecretss() =
  assert onePWSecrets.new('foo', 'vault/VAULT/ITEM') == {
    apiVersion: 'onepassword.com/v1',
    kund: 'OnePasswordItem',
    metadata: {
      name: 'foo',
    },
    spec: {
      itemPath: 'vault/VAULT/ITEM',
    },
  };
  true;

{
  TestOnePWSecretss: TestOnePWSecretss(),
}
