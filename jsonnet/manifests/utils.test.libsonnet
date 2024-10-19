local testUtils = import './testUtils.libsonnet';
local utils = import './utils.libsonnet';

local nestedObject = { a: { m: { x: 3 }, n: 2 }, b: 1 };

local TestObjToEnvVar() =
  assert utils.objToEnvVar({ foo: 'bar', baz: 1 }) == [
    { name: 'baz', value: '1' },
    { name: 'foo', value: 'bar' },
  ];
  true;

local TestGetKey() =
  assert utils.getKey(nestedObject, ['a', 'm', 'x'], 4) == 3;
  assert utils.getKey(nestedObject, ['a', 'm', 'fizzbuzz'], 4) == 4;
  true;

{
  TestObjToEnvVar: TestObjToEnvVar(),
  TestGetKey: TestGetKey(),
}
