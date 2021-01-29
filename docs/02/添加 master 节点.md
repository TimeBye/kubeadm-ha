## 新节点信息

|    **ip**     | **hostname** |   **OS**   | **kernel version** | **role** |
| :-----------: | :----------: | :--------: | :----------------: | :------: |
| 192.168.56.16 |    node6     | CentOS 7.4 |     4.20.13-1      |  master  |

## 添加 master 节点

- 编辑原有主机清单文件，在 `[all]` 节点组中添加新节点信息
  ```diff
  [all]
  ...
  + node6 ansible_host=192.168.56.16 ansible_user=vagrant ansible_ssh_pass=vagrant
  ... 
  ```

- 在 `[new-master]` 节点组中添加新节点信息
  ```diff
  ...
  [new-master]
  + node6
  ...
  ```

- 执行 master 节点添加操作
  - 基本配置执行
    ```
    ansible-playbook -i example/hosts.m-master.ip.ini 82-add-master.yml
    ```

  - **注意：** 如果安装集群时使用高级配置，则使用该命令
    ```
    ansible-playbook -i example/hosts.m-master.ip.ini -e @example/variables.yaml 82-add-master.yml
    ```

    > 若 `example/hosts.m-master.ip.ini` 文件中与 `example/variables.yaml` 参数冲突时， `example/variables.yaml` 文件中的变量值优先级最高。

- 添加完成后，将`[new-master]` 节点组中新节点信息移动至 `[kube-master]` 节点组
  ```diff
  ...
  [kube-master]
  node1
  node2
  node3
  + node6
  ...
  [new-master]
  - node6
  ...
  ```