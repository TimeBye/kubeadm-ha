---
name: 缺陷报告
about: 创建缺陷报告以帮助我们改进
title: ''
labels: ''
assignees: ''

---

**缺陷描述**
清晰而简明的描述缺陷是什么。

**如何复现**
复现的步骤：
1. 第一步：编写 inventory.ini 文件，内容如下
    ```ini
    [all]
    192.168.56.11 ansible_port=22 ansible_user="vagrant" ansible_ssh_pass="vagrant"
    ......
    ```
2. 第二步：编写 variables.yaml 文件，内容如下
    ```yaml
    skip_verify_node: false
    timezone: Asia/Shanghai
    ......
    ```
3. 第三步：执行部署命令，命令如下
    ```yaml
    ansible-playbook -i inventory.ini -e @variables.yaml 90-init-cluster.yml
    ```
4. 出现错误

**预期结果**
对你期望发生的事情的清晰而简洁的描述。

**屏幕截图**
如果可行的话，添加屏幕截图来帮助解释你的问题。

**环境 (请填写以下信息):**
 - OS: [例如： Centos7]
 - Kubernetes Version: [例如： 1.20.0]
 - Docker(containerd) Version: [例如： 1.19.03]
 - 本项目 git commit hash: [例如：183b254ab4736e1d8cc38a35b982e8456e330a0a]

**其他事项**
在此处添加有关该问题的任何其他事项。
