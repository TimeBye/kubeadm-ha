# Kubeadm HA

本项目使用`kubeadm`进行高可用kubernetes集群搭建，利用ansible-playbook实现自动化一键安装。

- 支持版本：

  |组件|支持|
  |:-|:-|
  |OS|Ubuntu 16.04+, Debian 9, CentOS/RedHat 7|
  |k8s|v1.14.1|
  |etcd|v3.2.4|
  |docker|18.06.3, 18.09.3|
  |network|flannel|

## 1. 环境准备

- 在执行ansible本脚本的机器上安装ansible运行需要的环境：
    - Ubuntu 16.04 请执行以下脚本：

        ``` bash
        sudo apt-get install git python3-pip sshpass -y
        ```

    - CentOS 7 请执行以下脚本：

        ``` bash
        sudo yum install epel-release -y 
        sudo yum install git python36 sshpass -y
        sudo python3.6 -m ensurepip
        sudo ln -s /usr/local/bin/pip3 /usr/bin/pip3
        ```

    - 安装ansible
        
        ``` bash
        sudo pip3 install --no-cache-dir ansible==2.7.5 netaddr -i https://mirrors.aliyun.com/pypi/simple/
        python -m SimpleHTTPServer 80 &
        ```

## 2. 克隆本项目至ansible环境中：

```
git clone https://github.com/TimeBye/kubeadm-ha.git
```

## 3. 修改 hosts 文件

编辑项目`example`文件夹下的主机清单文件，修改各机器的访问地址、用户名、密码，并维护好各节点与角色的关系。文件中配置的用户必须是具有 **root** 权限的用户。项目预定义了6个例子，请修改后完成适合你的集群规划，生产环境建议一个节点只是一个角色。

- 搭建集群后有以下两种“样式”显示，请自行选择：
    - 样式一
        ```
        NAME             STATUS    ROLES                 AGE    VERSION
        192.168.56.11    Ready     etcd,master,worker    1d     v1.14.1
        192.168.56.12    Ready     etcd,master,worker    1d     v1.14.1
        192.168.56.13    Ready     etcd,master,worker    1d     v1.14.1
        ```

    - 样式二
        ```
        NAME     STATUS    ROLES                 AGE    VERSION
        node1    Ready     etcd,master,worker    1d     v1.14.1
        node2    Ready     etcd,master,worker    1d     v1.14.1
        node3    Ready     etcd,master,worker    1d     v1.14.1
        ```

    - 对应的hosts配置文件事例如下：

        |节点分配|样式一|样式二|
        |:-|:-|:-|
        |单节点|[hosts.allinone.ip](example/hosts.allinone.ip.ini)|[hosts.allinone.hostname](example/hosts.allinone.hostname.ini)|
        |单主多节点|[hosts.s-master.ip](example/hosts.s-master.ip.ini)|[hosts.s-master.hostname](example/hosts.s-master.hostname.ini)|
        |多主多节点|[hosts.m-master.ip](example/hosts.m-master.ip.ini)|[hosts.m-master.hostname](example/hosts.m-master.hostname.ini)|

## 4. 部署

进行安装:

- 基本配置执行
```
ansible-playbook -i example/hosts.allinone.ip.ini cluster.yaml
```

- 高级配置执行
```
ansible-playbook -i example/hosts.allinone.ip.ini -e @example/variables.yaml cluster.yaml
```

> 若`example/hosts.allinone.ip.ini`文件中与`example/variables.yaml`参数冲突，则以`example/variables.yaml`文件为准。

## 5. 重置

如果部署失败，想要重置集群(所有数据),执行：

```
ansible-playbook -i example/hosts.allinone.ip.ini reset.yml
```