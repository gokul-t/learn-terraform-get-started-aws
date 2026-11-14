# EFS

- **Fully Managed NFS File System:** EFS provides scalable, elastic, cloud-native NFS file storage for use with AWS Cloud services and on-premises resources.
- **Shared Storage:** Multiple EC2 instances (across multiple AZs) can access the same EFS file system concurrently, making it ideal for shared data scenarios.
- **Scalability:** Automatically grows and shrinks as files are added or removed; no need to provision storage in advance.
- **POSIX-Compliant:** Supports standard file system permissions and operations, making it compatible with Linux-based applications.
- **High Availability & Durability:** Data is stored redundantly across multiple Availability Zones within a region.
- **Performance Modes:** Two modes—General Purpose (default, for latency-sensitive use) and Max I/O (for highly parallelized workloads).
- **Throughput Modes:** Bursting (default, scales with storage) and Provisioned (set throughput regardless of storage size).
- **Use Cases:** Web serving, content management, home directories, big data analytics, and lift-and-shift enterprise applications.
- **Integration:** Can be mounted on EC2, ECS, EKS, and Lambda (via EFS integration).
- **Security:** Supports encryption at rest and in transit, IAM policies, and security groups for access control.
- **Pricing:** Pay only for the storage used (GB/month).

