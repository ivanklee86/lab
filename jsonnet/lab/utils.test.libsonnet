local testUtils = import './testUtils.libsonnet';
local utils = import './utils.libsonnet';

local TestObjToEnvVar() =
  assert utils.objToEnvVar({ foo: 'bar', baz: 1 }) == [
    { name: 'baz', value: '1' },
    { name: 'foo', value: 'bar' },
  ];
  true;

{
  TestObjToEnvVar: TestObjToEnvVar(),
}
