local wrapper = import './wrapper.libsonnet';

local object = {
  a: 'b',
};

local configs = {
  name: 'x',
};

local objectWrapper(obj, configs) = obj + { publicName: configs.name };

local TestWrapper() =
  assert wrapper.wrap(object, null, configs) == object;
  assert wrapper.wrap(object, objectWrapper, configs) == object + { publicName: configs.name };
  true;

{
  TestWrapper: TestWrapper(),
}
