# 介绍

## 什么是Fluid
Fluid是一个开源的Kubernetes原生的分布式数据集编排和加速引擎，主要服务于云原生场景下的数据密集型应用，例如大数据应用、AI应用等。通过定义数据集资源的抽象，实现如下功能：
![image.png](https://intranetproxy.alipay.com/skylark/lark/0/2021/png/17743/1609837995778-1a3e9139-38cd-4e2f-89dd-3a655151d259.png#align=left&display=inline&height=267&margin=%5Bobject%20Object%5D&name=image.png&originHeight=802&originWidth=1026&size=914368&status=done&style=none&width=342)
## 核心功能

- **数据集抽象原生支持**
将数据密集型应用所需基础支撑能力功能化，实现数据高效访问并降低多维管理成本

- **云上数据预热与加速**
Fluid通过使用分布式缓存引擎（Alluxio inside）为云上应用提供数据预热与加速，同时可以保障缓存数据的**可观测性**，**可迁移性**和**自动化的水平扩展**

- **数据应用协同编排**
在云上调度应用和数据时候，同时考虑两者特性与位置，实现协同编排，提升性能

- **多命名空间管理支持**
用户可以创建和管理不同namespace的数据集

- **异构数据源管理**
一次性统一访问不同来源的底层数据（对象存储，HDFS和Ceph等存储)，适用于混合云场景

## 重要概念
**Dataset**: 数据集是逻辑上相关的一组数据的集合，会被运算引擎使用，比如大数据的Spark，AI场景的TensorFlow。而这些数据智能的应用会创造工业界的核心价值。Dataset的管理实际上也有多个维度，比如安全性，版本管理和数据加速。我们希望从数据加速出发，对于数据集的管理提供支持。


**Runtime**: 实现数据集安全性，版本管理和数据加速等能力的执行引擎，定义了一系列生命周期的接口。可以通过实现这些接口，支持数据集的管理和加速。


**JindoRuntime**: 来源于阿里云EMR团队JIndoFS，是基于C++实现的支撑Dataset数据管理和缓存的执行引擎实现，支持OSS对象存储。JIndoFS是阿里云的产品，有专门的产品级支持，但是代码不开源。Fluid通过管理和调度JIndo Runtime实现数据集的可见性，弹性伸缩， 数据迁移。


**AlluxioRuntime**: 来源于[Alluixo](https://www.alluxio.org/)社区，是支撑Dataset数据管理和缓存的执行引擎实现，支持PVC，Ceph，CPFS计算，有效支持混合云场景。但是Alluxio是开源社区方案，对于数据缓存的稳定性和性能优化我们会和社区一起推动，但是时效性和响应会有延时。Fluid通过管理和调度Alluxio Runtime实现数据集的可见性，弹性伸缩， 数据迁移。





|  | Alluxio | Jindo |
| --- | --- | --- |
| 底层存储类型 | PVC，Ceph，HDFS，CPFS，NFS... | OSS，EMR |
| 支持方式 | 开源社区 | 阿里云产品 |
| 实现语言 | Java | C++ |



