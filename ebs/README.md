# EBS

- Elastic block storage is like network USB drive.
- Restricted to one AZ, but can be attached to any instance in that AZ.
- Two types: SSD (general purpose) and HDD (throughput optimized).
- To move another AZ, create a snapshot and restore it in the new AZ.
- Can be encrypted. Encryption is handled transparently by AWS, so there is no
performance impact.
- Can be used as root device, and can be detached and reattached to another instance.
