---
name: 缺陷报告
about: 创建缺陷报告以帮助我们改进
title: ''
labels: ''
assignees: ''

---

**缺陷描述**

清晰而简明的描述缺陷是什么。

**环境 (请填写以下信息):**

执行下面括号中的命令，提交返回结果

- **OS** (`printf "$(uname -srm)\n$(cat /etc/os-release)\n"`):

- **Ansible版本** (`ansible --version`):

- **Python版本** (`python --version`):

- **Kubeadm-ha版本(commit)** (`git rev-parse --short HEAD`):

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
    ```
    错误内容......
    ```

**预期结果**

对你期望发生的结果清晰而简洁的描述。

**屏幕截图**

如果可以的话，添加屏幕截图来帮助解释你的问题。

**其他事项**

在此处添加有关该问题的任何其他事项。
