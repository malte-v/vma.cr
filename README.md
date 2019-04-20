# vma.cr

VulkanMemoryAllocator bindings to Crystal.

Current VulkanMemoryAllocator version: 2.2.0

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     vma:
       github: malte-v/vma.cr
   ```

2. Run `shards install`

3. (Optional) Run `cc -c src/wrapper.cpp -o bin/vma.o` from the root of this repo to compile VMA yourself.

4. Make sure the Vulkan library is in your PATH.

## Usage

```crystal
require "vma"
```

All the functions, structs, enums etc. are located inside `lib Vma`.

## Contributing

1. Fork it (<https://github.com/malte-v/vma.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [malte-v](https://github.com/malte-v) - creator and maintainer
