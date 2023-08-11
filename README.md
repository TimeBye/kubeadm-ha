[Kubeadm HA](https://github.com/TimeBye/kubeadm-ha)
=======

**🎉 项目受 [kubeasz](https://github.com/easzlab/kubeasz) 启发，考虑使用二进制进行安装的童鞋可以参考这个项目。**

`kubeadm-ha` 使用 [kubeadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/) 进行高可用 kubernetes 集群搭建，利用 ansible-playbook 实现自动化安装，既提供一键安装脚本，也可以根据 playbook 分步执行安装各个组件。

[![](https://img.shields.io/badge/Mode-HA-brightgreen.svg?style=flat-square)](https://img.shields.io/badge/Mode-HA-brightgreen.svg?style=flat-square)
[![](https://img.shields.io/badge/Dist-Ubuntu16.04-yellow.svg?style=flat-square)](https://img.shields.io/badge/Dist-Ubuntu16.04-yellow.svg?style=flat-square)
[![](https://img.shields.io/badge/Dist-Debian10-yellow.svg?style=flat-square)](https://img.shields.io/badge/Dist-Debian10-yellow.svg?style=flat-square)
[![](https://img.shields.io/badge/Dist-Centos7-orange.svg?style=flat-square)](https://img.shields.io/badge/Dist-Centos7-orange.svg?style=flat-square)
[![](https://img.shields.io/badge/Dist-RedHat7-orange.svg?style=flat-square)](https://img.shields.io/badge/Dist-RedHat7-orange.svg?style=flat-square)
[![](https://img.shields.io/badge/Dist-Centos8-orange.svg?style=flat-square)](https://img.shields.io/badge/Dist-Centos8-orange.svg?style=flat-square)
[![](https://img.shields.io/badge/Proxy-iptables-brightgreen.svg?style=flat-square)](https://img.shields.io/badge/Proxy-iptables-brightgreen.svg?style=flat-square)
[![](https://img.shields.io/badge/Proxy-IPVS-brightgreen.svg?style=flat-square)](https://img.shields.io/badge/Proxy-IPVS-brightgreen.svg?style=flat-square)
[![](https://img.shields.io/badge/DNS-CoreDNS-brightgreen.svg?style=flat-square)](https://img.shields.io/badge/DNS-CoreDNS-brightgreen.svg?style=flat-square)
[![](https://img.shields.io/badge/Net-Flannel-brightgreen.svg?style=flat-square)](https://img.shields.io/badge/Net-Flannel-brightgreen.svg?style=flat-square)
[![](https://img.shields.io/badge/Net-Calico-brightgreen.svg?style=flat-square)](https://img.shields.io/badge/Net-Calico-brightgreen.svg?style=flat-square)
[![LICENSE](https://img.shields.io/badge/license-Anti%20996-blue.svg?style=flat-square)](https://github.com/TimeBye/kubeadm-ha/blob/master/LICENSE)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2FTimeBye%2Fkubeadm-ha.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2FTimeBye%2Fkubeadm-ha?ref=badge_shield)

- **项目特性：** 不受国内网络限制、所有组件使用 `kubelet` 托管、多 `master` 高可用、`tls` 双向认证、自定义 `tls` 证书有效期、`RBAC` 授权、支持 `Network Policy`

- **分支说明：**
  - `master`：稳定分支，推荐安装
  - `release-*`：安装 `*` 版本的 Kubernetes
  - `develop`：开发分支，不建议安装

- **相关支持：**

  | **类别**           | **支持**                                                                                     |
  | :----------------- | :------------------------------------------------------------------------------------------- |
  | Architecture       | amd64, arm64                                                                                 |
  | OS                 | Ubuntu 16.04+, Debian 10, CentOS 7.4+, RedHat 7, CentOS 8, Anolis OS 7, Kylin V10, OpenEuler |
  | Etcd               | 3.5.7-0                                                                                      |
  | Container runtimes | Docker, **containerd**                                                                       |
  | Kubernetes         | v1.20, v1.21, v1.22, v1.23, v1.24, v1.25, v1.26, **v1.27**                                   |
  | Kube-apiserver lb  | slb, haproxy, envoy, openresty, **nginx**                                                    |
  | Network plugin     | flannel, **calico**                                                                          |
  | Ingress controller | traefik, **nginx-ingress**                                                                   |

  **Note:** 表格中粗体标识出来的为默认安装版本

## 已知问题

- 由于各插件（Network plugin、Ingress controller）版本更新可能不再兼容低版本 kubernetes，若在部署时指定了低版本 kubernetes 可能导致插件部署时报错。在此建议安装本项目默认或者最新版本 kubernetes。也可参与此进行讨论 [#28](https://github.com/TimeBye/kubeadm-ha/issues/28)。

## 使用指南

<table border="0">
    <tr>
        <td><a target="_blank" href="docs/00-安装须知.md">00-安装须知</a></td>
        <td><a target="_blank" href="docs/01-集群安装.md">01-集群安装</a></td>
        <td><a target="_blank" href="docs/02-节点管理.md">02-节点管理</a></td>
        <td><a target="_blank" href="docs/03-证书轮换.md">03-证书轮换</a></td>
        <td><a target="_blank" href="docs/04-集群升级.md">04-集群升级</a></td>
    </tr>
    <tr>
        <td><a target="_blank" href="docs/05-集群备份.md">05-集群备份</a></td>
        <td><a target="_blank" href="docs/06-集群恢复.md">06-集群恢复</a></td>
        <td><a target="_blank" href="docs/07-集群重置.md">07-集群重置</a></td>
        <td><a target="_blank" href="docs/08-离线安装.md">08-离线安装</a></td>
        <td><a target="_blank" href="docs/09-扩展阅读.md">09-扩展阅读</a></td>
    </tr>
</table>

[![asciicast](https://asciinema.org/a/254490.svg)](https://asciinema.org/a/254490)

## 参与者
<table><tr>

   <td align="center">
  <a href="https://github.com/carllhw"><img src="https://avatars2.githubusercontent.com/u/9696301?s=400&v=4" width="100px;" alt="carllhw"/>
   <br></br><sub><b>carllhw</b></sub>

   <td align="center">
  <a href="https://github.com/Jaywoods2"><img src="https://avatars2.githubusercontent.com/u/18679696?s=400&v=4" width="100px;" alt="Jaywoods2"/>
  <br></br><sub><b>Jaywoods2</b></sub>

   <td align="center">
  <a href="https://github.com/ChongmingDu"><img src="https://avatars.githubusercontent.com/u/22591706?s=400&v=4" width="100px;" alt="ChongmingDu"/>
  <br></br><sub><b>ChongmingDu</b></sub>
  
   <td align="center">
  <a href="https://github.com/happinesslijian"><img src="https://avatars2.githubusercontent.com/u/47111417?s=400&v=4" width="100px;" alt="happinesslijian"/>
  <br></br><sub><b>happinesslijian</b></sub>

   <td align="center">
  <a href="https://github.com/zlingqu"><img src="https://avatars1.githubusercontent.com/u/41672611?s=400&v=4" width="100px;" alt="zlingqu"/>
  <br></br><sub><b>zlingqu</b></sub>

   <td align="center">
  <a href="https://github.com/li-sen"><img src="https://avatars.githubusercontent.com/u/33471335?s=400&v=4" width="100px;" alt="li-sen"/>
  <br></br><sub><b>li-sen</b></sub>

</td></tr></table>

## JetBrains 开源证书支持

`kubeadm-ha` 基于 **free JetBrains Open Source license(s)** 正版免费授权进行开发，在此表达我的谢意。

<a href="https://www.jetbrains.com/?from=kubeadm-ha" target="_blank"><img src="https://raw.githubusercontent.com/panjf2000/illustrations/master/jetbrains/jetbrains-variant-4.png" width="250" align="middle"/></a>

## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2FTimeBye%2Fkubeadm-ha.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2FTimeBye%2Fkubeadm-ha?ref=badge_large)