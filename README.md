[Kubeadm HA](https://github.com/TimeBye/kubeadm-ha)
=======

**🎉 项目受 [kubeasz](https://github.com/easzlab/kubeasz) 启发，考虑使用二进制进行安装的童鞋可以参考这个项目。**

`kubeadm-ha` 使用 [kubeadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/) 进行高可用 kubernetes 集群搭建，利用 ansible-playbook 实现自动化安装，既提供一键安装脚本，也可以根据 playbook 分步执行安装各个组件。

[![](https://img.shields.io/badge/Mode-HA-brightgreen.svg?style=flat-square)](https://img.shields.io/badge/Mode-HA-brightgreen.svg?style=flat-square)
[![](https://img.shields.io/badge/Dist-Ubuntu16.04-yellow.svg?style=flat-square)](https://img.shields.io/badge/Dist-Ubuntu16.04-yellow.svg?style=flat-square)
[![](https://img.shields.io/badge/Dist-Debian9-yellow.svg?style=flat-square)](https://img.shields.io/badge/Dist-Debian9-yellow.svg?style=flat-square)
[![](https://img.shields.io/badge/Dist-Centos7-orange.svg?style=flat-square)](https://img.shields.io/badge/Dist-Centos7-orange.svg?style=flat-square)
[![](https://img.shields.io/badge/Dist-Centos8-orange.svg?style=flat-square)](https://img.shields.io/badge/Dist-Centos8-orange.svg?style=flat-square)
[![](https://img.shields.io/badge/Dist-RedHat7-orange.svg?style=flat-square)](https://img.shields.io/badge/Dist-RedHat7-orange.svg?style=flat-square)
[![](https://img.shields.io/badge/Proxy-iptables-brightgreen.svg?style=flat-square)](https://img.shields.io/badge/Proxy-iptables-brightgreen.svg?style=flat-square)
[![](https://img.shields.io/badge/Proxy-IPVS-brightgreen.svg?style=flat-square)](https://img.shields.io/badge/Proxy-IPVS-brightgreen.svg?style=flat-square)
[![](https://img.shields.io/badge/DNS-CoreDNS-brightgreen.svg?style=flat-square)](https://img.shields.io/badge/DNS-CoreDNS-brightgreen.svg?style=flat-square)
[![](https://img.shields.io/badge/Net-Flannel-brightgreen.svg?style=flat-square)](https://img.shields.io/badge/Net-Flannel-brightgreen.svg?style=flat-square)
[![](https://img.shields.io/badge/Net-Calico-brightgreen.svg?style=flat-square)](https://img.shields.io/badge/Net-Calico-brightgreen.svg?style=flat-square)
[![LICENSE](https://img.shields.io/badge/license-Anti%20996-blue.svg?style=flat-square)](https://github.com/TimeBye/kubeadm-ha/blob/master/LICENSE)
[![HitCount](http://hits.dwyl.io/timebye/kubeadm-ha.svg)](http://hits.dwyl.io/timebye/kubeadm-ha)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2FTimeBye%2Fkubeadm-ha.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2FTimeBye%2Fkubeadm-ha?ref=badge_shield)

- **项目特性：** 不受国内网络限制、所有组件使用 `kubelet` 托管、多 `master` 高可用、`tls` 双向认证、自定义 `tls` 证书有效期、`RBAC` 授权、支持 `Network Policy`

- **相关支持：**

  | **类别**           | **支持**                                                |
  | :----------------- | :------------------------------------------------------ |
  | Architecture       | amd64, arm64                                            |
  | OS                 | Ubuntu 16.04+, Debian 9, CentOS 7.4+,CentOS 8, RedHat 7 |
  | Etcd               | v3.4.13-0                                                |
  | Docker             | 18.06, 18.09, **19.03**                                 |
  | Kubernetes         | v1.13, v1.14, v1.15, v1.16, v1.17, **v1.18**            |
  | Kube-apiserver lb  | slb, haproxy, envoy, openresty, **nginx**               |
  | Network plugin     | flannel, **calico**                                     |
  | Ingress controller | traefik, **nginx-ingress**                              |

  **Note:** 表格中粗体标识出来的为默认安装版本

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
        <td><a target="_blank" href="#">-</a></td>
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
  <a href="https://github.com/happinesslijian"><img src="https://avatars2.githubusercontent.com/u/47111417?s=400&v=4" width="100px;" alt="happinesslijian"/>
  <br></br><sub><b>happinesslijian</b></sub>

   <td align="center">
  <a href="https://github.com/zlingqu"><img src="https://avatars1.githubusercontent.com/u/41672611?s=400&v=4" width="100px;" alt="zlingqu"/>
  <br></br><sub><b>zlingqu</b></sub>

</td></tr></table>

## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2FTimeBye%2Fkubeadm-ha.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2FTimeBye%2Fkubeadm-ha?ref=badge_large)