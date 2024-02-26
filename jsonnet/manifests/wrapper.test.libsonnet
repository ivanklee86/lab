local wrapper = import './wrapper.libsonnet';

local object = {
  a: 'b'
};

local config = {
  name: 'x'
};

local objectWrapper(obj, config) = obj + { publicName: config.name };

local TestWrapper() =
  assert wrapper.wrap(object, null, config) == object;
  assert wrapper.wrap(object, objectWrapper, config) == object + { publicName: config.name };
  true;

{
  TestWrapper: TestWrapper(),
}
