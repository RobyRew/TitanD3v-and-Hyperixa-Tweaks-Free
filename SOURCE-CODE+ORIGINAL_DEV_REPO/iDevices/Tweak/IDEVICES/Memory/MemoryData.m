#import "MemoryData.h"

#import <mach/mach_init.h>
#import <mach/mach_host.h>

static const unsigned int MEGABYTES = 1 << 20;
static unsigned long long PHYSICAL_MEMORY;
__strong static id ramInfoObject;

@implementation MemoryData

+ (nullable NSString *)getTotalRam {
  mach_port_t host_port;
  mach_msg_type_number_t host_size;
  vm_size_t pagesize;
  vm_statistics_data_t vm_stat;
  NSMutableString* mutableString = [[NSMutableString alloc] init];

  host_port = mach_host_self();
  host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
  host_page_size(host_port, &pagesize);
  if(host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) == KERN_SUCCESS)
  {

    [mutableString appendString: [NSString stringWithFormat:@"%lluMB", PHYSICAL_MEMORY]];

    PHYSICAL_MEMORY = [NSProcessInfo processInfo].physicalMemory / MEGABYTES;

  }
  return [mutableString copy];
}


+ (nullable NSString *) getUsedRam {

  mach_port_t host_port;
  mach_msg_type_number_t host_size;
  vm_size_t pagesize;
  vm_statistics_data_t vm_stat;
  natural_t mem_used;
  NSMutableString* mutableString = [[NSMutableString alloc] init];

  host_port = mach_host_self();
  host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
  host_page_size(host_port, &pagesize);
  if(host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) == KERN_SUCCESS)
  {

    mem_used = (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count) * pagesize / MEGABYTES;
    [mutableString appendString: [NSString stringWithFormat:@"%uMB", mem_used]];

  }
  return [mutableString copy];
}


+ (nullable NSString *) getFreeRam {

  mach_port_t host_port;
  mach_msg_type_number_t host_size;
  vm_size_t pagesize;
  vm_statistics_data_t vm_stat;
  natural_t mem_free;
  NSMutableString* mutableString = [[NSMutableString alloc] init];

  host_port = mach_host_self();
  host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
  host_page_size(host_port, &pagesize);
  if(host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) == KERN_SUCCESS)
  {

    mem_free = vm_stat.free_count * pagesize / MEGABYTES;
    [mutableString appendString: [NSString stringWithFormat:@"%uMB", mem_free]];

  }
  return [mutableString copy];
}

@end
