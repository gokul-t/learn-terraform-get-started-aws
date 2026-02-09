# EC2 Instance Storage

## EBS

- Elastic block storage is like network USB drive.
- Restricted to one AZ, but can be attached to any instance in that AZ.
- Two types: SSD (general purpose) and HDD (throughput optimized).
- To move another AZ, create a snapshot and restore it in the new AZ.
- Can be encrypted. Encryption is handled transparently by AWS, so there is no
performance impact.
- Can be used as root device, and can be detached and reattached to another instance.

### Instance Store

- Instance store provides temporary block-level storage for EC2 instances.
- Storage is physically attached to the host server and offers very high I/O performance.
- Data on instance store is lost if the instance is stopped, terminated, or fails.
- Suitable for temporary data, caches, buffers, or data replicated across instances.
- Cannot be detached or reattached to another instance.
- Not recommended for storing persistent or critical data.
