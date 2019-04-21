require "vulkan"

# We must explicitely link against the C++ standard library because VMA is written in C++
@[Link(ldflags: "#{__DIR__}/../bin/vma.o -lvulkan -lstdc++")]
lib Vma
  RECORDING_ENABLED    = 0
  DEDICATED_ALLOCATION = 1
  STATS_STRING_ENABLED = 1

  alias AllocatorT = Void
  alias PfnVmaAllocateDeviceMemoryFunction = (Allocator, UInt32, Vk::DeviceMemory, Vk::DeviceSize -> Void)
  alias PfnVmaFreeDeviceMemoryFunction = (Allocator, UInt32, Vk::DeviceMemory, Vk::DeviceSize -> Void)
  alias PfnVkGetPhysicalDeviceProperties = (Vk::PhysicalDevice, Vk::PhysicalDeviceProperties* -> Void)
  alias PfnVkGetPhysicalDeviceMemoryProperties = (Vk::PhysicalDevice, Vk::PhysicalDeviceMemoryProperties* -> Void)
  alias PfnVkAllocateMemory = (Vk::Device, Vk::MemoryAllocateInfo*, Vk::AllocationCallbacks*, Vk::DeviceMemory* -> Vk::Result)
  alias PfnVkAllocationFunction = (Void*, LibC::SizeT, LibC::SizeT, Vk::SystemAllocationScope -> Void*)
  alias PfnVkReallocationFunction = (Void*, Void*, LibC::SizeT, LibC::SizeT, Vk::SystemAllocationScope -> Void*)
  alias PfnVkFreeFunction = (Void*, Void* -> Void)
  alias PfnVkInternalAllocationNotification = (Void*, LibC::SizeT, Vk::InternalAllocationType, Vk::SystemAllocationScope -> Void)
  alias PfnVkInternalFreeNotification = (Void*, LibC::SizeT, Vk::InternalAllocationType, Vk::SystemAllocationScope -> Void)
  alias PfnVkFreeMemory = (Vk::Device, Vk::DeviceMemory, Vk::AllocationCallbacks* -> Void)
  alias PfnVkMapMemory = (Vk::Device, Vk::DeviceMemory, Vk::DeviceSize, Vk::DeviceSize, Vk::MemoryMapFlags, Void** -> Vk::Result)
  alias PfnVkUnmapMemory = (Vk::Device, Vk::DeviceMemory -> Void)
  alias PfnVkFlushMappedMemoryRanges = (Vk::Device, UInt32, Vk::MappedMemoryRange* -> Vk::Result)
  alias PfnVkInvalidateMappedMemoryRanges = (Vk::Device, UInt32, Vk::MappedMemoryRange* -> Vk::Result)
  alias PfnVkBindBufferMemory = (Vk::Device, Vk::Buffer, Vk::DeviceMemory, Vk::DeviceSize -> Vk::Result)
  alias PfnVkBindImageMemory = (Vk::Device, Vk::Image, Vk::DeviceMemory, Vk::DeviceSize -> Vk::Result)
  alias PfnVkGetBufferMemoryRequirements = (Vk::Device, Vk::Buffer, Vk::MemoryRequirements* -> Void)
  alias PfnVkGetImageMemoryRequirements = (Vk::Device, Vk::Image, Vk::MemoryRequirements* -> Void)
  alias PfnVkCreateBuffer = (Vk::Device, Vk::BufferCreateInfo*, Vk::AllocationCallbacks*, Vk::Buffer* -> Vk::Result)
  alias PfnVkDestroyBuffer = (Vk::Device, Vk::Buffer, Vk::AllocationCallbacks* -> Void)
  alias PfnVkCreateImage = (Vk::Device, Vk::ImageCreateInfo*, Vk::AllocationCallbacks*, Vk::Image* -> Vk::Result)
  alias PfnVkDestroyImage = (Vk::Device, Vk::Image, Vk::AllocationCallbacks* -> Void)
  alias PfnVkCmdCopyBuffer = (Vk::CommandBuffer, Vk::Buffer, Vk::Buffer, UInt32, Vk::BufferCopy* -> Void)
  alias PfnVkGetBufferMemoryRequirements2KHR = (Vk::Device, Vk::BufferMemoryRequirementsInfo2*, Vk::MemoryRequirements2* -> Void)
  alias PfnVkGetImageMemoryRequirements2KHR = (Vk::Device, Vk::ImageMemoryRequirementsInfo2*, Vk::MemoryRequirements2* -> Void)
  alias RecordFlags = Vk::Flags
  alias AllocatorCreateFlags = Vk::Flags
  alias PoolT = Void
  alias AllocationCreateFlags = Vk::Flags
  alias PoolCreateFlags = Vk::Flags
  alias AllocationT = Void
  alias DefragmentationContextT = Void
  alias DefragmentationFlags = Vk::Flags

  enum MemoryUsage
    Unknown  =          0
    GpuOnly  =          1
    CpuOnly  =          2
    CpuToGpu =          3
    GpuToCpu =          4
    MaxEnum  = 2147483647
  end

  fun create_allocator = vmaCreateAllocator(create_info : AllocatorCreateInfo*, allocator : Allocator*) : Vk::Result
  fun destroy_allocator = vmaDestroyAllocator(allocator : Allocator)
  fun get_physical_device_properties = vmaGetPhysicalDeviceProperties(allocator : Allocator, physical_device_properties : Vk::PhysicalDeviceProperties**)
  fun get_memory_properties = vmaGetMemoryProperties(allocator : Allocator, physical_device_memory_properties : Vk::PhysicalDeviceMemoryProperties**)
  fun get_memory_type_properties = vmaGetMemoryTypeProperties(allocator : Allocator, memory_type_index : UInt32, flags : Vk::MemoryPropertyFlags*)
  fun set_current_frame_index = vmaSetCurrentFrameIndex(allocator : Allocator, frame_index : UInt32)
  fun calculate_stats = vmaCalculateStats(allocator : Allocator, stats : Stats*)
  fun build_stats_string = vmaBuildStatsString(allocator : Allocator, stats_string : LibC::Char**, detailed_map : Vk::Bool32)
  fun free_stats_string = vmaFreeStatsString(allocator : Allocator, stats_string : LibC::Char*)
  fun find_memory_type_index = vmaFindMemoryTypeIndex(allocator : Allocator, memory_type_bits : UInt32, allocation_create_info : AllocationCreateInfo*, memory_type_index : UInt32*) : Vk::Result
  fun find_memory_type_index_for_buffer_info = vmaFindMemoryTypeIndexForBufferInfo(allocator : Allocator, buffer_create_info : Vk::BufferCreateInfo*, allocation_create_info : AllocationCreateInfo*, memory_type_index : UInt32*) : Vk::Result
  fun find_memory_type_index_for_image_info = vmaFindMemoryTypeIndexForImageInfo(allocator : Allocator, image_create_info : Vk::ImageCreateInfo*, allocation_create_info : AllocationCreateInfo*, memory_type_index : UInt32*) : Vk::Result
  fun create_pool = vmaCreatePool(allocator : Allocator, create_info : PoolCreateInfo*, pool : Pool*) : Vk::Result
  fun destroy_pool = vmaDestroyPool(allocator : Allocator, pool : Pool)
  fun get_pool_stats = vmaGetPoolStats(allocator : Allocator, pool : Pool, pool_stats : PoolStats*)
  fun make_pool_allocations_lost = vmaMakePoolAllocationsLost(allocator : Allocator, pool : Pool, lost_allocation_count : LibC::SizeT*)
  fun check_pool_corruption = vmaCheckPoolCorruption(allocator : Allocator, pool : Pool) : Vk::Result
  fun allocate_memory = vmaAllocateMemory(allocator : Allocator, memory_requirements : Vk::MemoryRequirements*, create_info : AllocationCreateInfo*, allocation : Allocation*, allocation_info : AllocationInfo*) : Vk::Result
  fun allocate_memory_pages = vmaAllocateMemoryPages(allocator : Allocator, memory_requirements : Vk::MemoryRequirements*, create_info : AllocationCreateInfo*, allocation_count : LibC::SizeT, allocations : Allocation*, allocation_info : AllocationInfo*) : Vk::Result
  fun allocate_memory_for_buffer = vmaAllocateMemoryForBuffer(allocator : Allocator, buffer : Vk::Buffer, create_info : AllocationCreateInfo*, allocation : Allocation*, allocation_info : AllocationInfo*) : Vk::Result
  fun allocate_memory_for_image = vmaAllocateMemoryForImage(allocator : Allocator, image : Vk::Image, create_info : AllocationCreateInfo*, allocation : Allocation*, allocation_info : AllocationInfo*) : Vk::Result
  fun free_memory = vmaFreeMemory(allocator : Allocator, allocation : Allocation)
  fun free_memory_pages = vmaFreeMemoryPages(allocator : Allocator, allocation_count : LibC::SizeT, allocations : Allocation*)
  fun resize_allocation = vmaResizeAllocation(allocator : Allocator, allocation : Allocation, new_size : Vk::DeviceSize) : Vk::Result
  fun get_allocation_info = vmaGetAllocationInfo(allocator : Allocator, allocation : Allocation, allocation_info : AllocationInfo*)
  fun touch_allocation = vmaTouchAllocation(allocator : Allocator, allocation : Allocation) : Vk::Bool32
  fun set_allocation_user_data = vmaSetAllocationUserData(allocator : Allocator, allocation : Allocation, user_data : Void*)
  fun create_lost_allocation = vmaCreateLostAllocation(allocator : Allocator, allocation : Allocation*)
  fun map_memory = vmaMapMemory(allocator : Allocator, allocation : Allocation, data : Void**) : Vk::Result
  fun unmap_memory = vmaUnmapMemory(allocator : Allocator, allocation : Allocation)
  fun flush_allocation = vmaFlushAllocation(allocator : Allocator, allocation : Allocation, offset : Vk::DeviceSize, size : Vk::DeviceSize)
  fun invalidate_allocation = vmaInvalidateAllocation(allocator : Allocator, allocation : Allocation, offset : Vk::DeviceSize, size : Vk::DeviceSize)
  fun check_corruption = vmaCheckCorruption(allocator : Allocator, memory_type_bits : UInt32) : Vk::Result
  fun defragmentation_begin = vmaDefragmentationBegin(allocator : Allocator, info : DefragmentationInfo2*, stats : DefragmentationStats*, context : DefragmentationContext*) : Vk::Result
  fun defragmentation_end = vmaDefragmentationEnd(allocator : Allocator, context : DefragmentationContext) : Vk::Result
  fun defragment = vmaDefragment(allocator : Allocator, allocations : Allocation*, allocation_count : LibC::SizeT, allocations_changed : Vk::Bool32*, defragmentation_info : DefragmentationInfo*, defragmentation_stats : DefragmentationStats*) : Vk::Result
  fun bind_buffer_memory = vmaBindBufferMemory(allocator : Allocator, allocation : Allocation, buffer : Vk::Buffer) : Vk::Result
  fun bind_image_memory = vmaBindImageMemory(allocator : Allocator, allocation : Allocation, image : Vk::Image) : Vk::Result
  fun create_buffer = vmaCreateBuffer(allocator : Allocator, buffer_create_info : Vk::BufferCreateInfo*, allocation_create_info : AllocationCreateInfo*, buffer : Vk::Buffer*, allocation : Allocation*, allocation_info : AllocationInfo*) : Vk::Result
  fun destroy_buffer = vmaDestroyBuffer(allocator : Allocator, buffer : Vk::Buffer, allocation : Allocation)
  fun create_image = vmaCreateImage(allocator : Allocator, image_create_info : Vk::ImageCreateInfo*, allocation_create_info : AllocationCreateInfo*, image : Vk::Image*, allocation : Allocation*, allocation_info : AllocationInfo*) : Vk::Result
  fun destroy_image = vmaDestroyImage(allocator : Allocator, image : Vk::Image, allocation : Allocation)

  struct DeviceMemoryCallbacks
    pfn_allocate : PfnVmaAllocateDeviceMemoryFunction
    pfn_free : PfnVmaFreeDeviceMemoryFunction
  end

  struct VulkanFunctions
    get_physical_device_properties : PfnVkGetPhysicalDeviceProperties
    get_physical_device_memory_properties : PfnVkGetPhysicalDeviceMemoryProperties
    allocate_memory : PfnVkAllocateMemory
    free_memory : PfnVkFreeMemory
    map_memory : PfnVkMapMemory
    unmap_memory : PfnVkUnmapMemory
    flush_mapped_memory_ranges : PfnVkFlushMappedMemoryRanges
    invalidate_mapped_memory_ranges : PfnVkInvalidateMappedMemoryRanges
    bind_buffer_memory : PfnVkBindBufferMemory
    bind_image_memory : PfnVkBindImageMemory
    get_buffer_memory_requirements : PfnVkGetBufferMemoryRequirements
    get_image_memory_requirements : PfnVkGetImageMemoryRequirements
    create_buffer : PfnVkCreateBuffer
    destroy_buffer : PfnVkDestroyBuffer
    create_image : PfnVkCreateImage
    destroy_image : PfnVkDestroyImage
    cmd_copy_buffer : PfnVkCmdCopyBuffer
    get_buffer_memory_requirements2_khr : PfnVkGetBufferMemoryRequirements2KHR
    get_image_memory_requirements2_khr : PfnVkGetImageMemoryRequirements2KHR
  end

  struct RecordSettings
    flags : RecordFlags
    file_path : LibC::Char*
  end

  struct AllocatorCreateInfo
    flags : AllocatorCreateFlags
    physical_device : Vk::PhysicalDevice
    device : Vk::Device
    preferred_large_heap_block_size : Vk::DeviceSize
    allocation_callbacks : Vk::AllocationCallbacks*
    device_memory_callbacks : DeviceMemoryCallbacks*
    frame_in_use_count : UInt32
    heap_size_limit : Vk::DeviceSize*
    vulkan_functions : VulkanFunctions*
    record_settings : RecordSettings*
  end

  struct StatInfo
    block_count : UInt32
    allocation_count : UInt32
    unused_range_count : UInt32
    used_bytes : Vk::DeviceSize
    unused_bytes : Vk::DeviceSize
    allocation_size_min : Vk::DeviceSize
    allocation_size_avg : Vk::DeviceSize
    allocation_size_max : Vk::DeviceSize
    unused_range_size_min : Vk::DeviceSize
    unused_range_size_avg : Vk::DeviceSize
    unused_range_size_max : Vk::DeviceSize
  end

  struct Stats
    memory_type : StatInfo[32]
    memory_heap : StatInfo[16]
    total : StatInfo
  end

  struct AllocationCreateInfo
    flags : AllocationCreateFlags
    usage : MemoryUsage
    required_flags : Vk::MemoryPropertyFlags
    preferred_flags : Vk::MemoryPropertyFlags
    memory_type_bits : UInt32
    pool : Pool
    user_data : Void*
  end

  struct PoolCreateInfo
    memory_type_index : UInt32
    flags : PoolCreateFlags
    block_size : Vk::DeviceSize
    min_block_count : LibC::SizeT
    max_block_count : LibC::SizeT
    frame_in_use_count : UInt32
  end

  struct PoolStats
    size : Vk::DeviceSize
    unused_size : Vk::DeviceSize
    allocation_count : LibC::SizeT
    unused_range_count : LibC::SizeT
    unused_range_size_max : Vk::DeviceSize
    block_count : LibC::SizeT
  end

  struct AllocationInfo
    memory_type : UInt32
    device_memory : Vk::DeviceMemory
    offset : Vk::DeviceSize
    size : Vk::DeviceSize
    mapped_data : Void*
    user_data : Void*
  end

  struct DefragmentationInfo2
    flags : DefragmentationFlags
    allocation_count : UInt32
    allocations : Allocation*
    allocations_changed : Vk::Bool32*
    pool_count : UInt32
    pools : Pool*
    max_cpu_bytes_to_move : Vk::DeviceSize
    max_cpu_allocations_to_move : UInt32
    max_gpu_bytes_to_move : Vk::DeviceSize
    max_gpu_allocations_to_move : UInt32
    command_buffer : Vk::CommandBuffer
  end

  struct DefragmentationInfo
    max_bytes_to_move : Vk::DeviceSize
    max_allocations_to_move : UInt32
  end

  struct DefragmentationStats
    bytes_moved : Vk::DeviceSize
    bytes_freed : Vk::DeviceSize
    allocations_moved : UInt32
    device_memory_blocks_freed : UInt32
  end

  # these were originally opaque types
  alias Allocator = Void*
  alias Pool = Void*
  alias Allocation = Void*
  alias DefragmentationContext = Void*
end
