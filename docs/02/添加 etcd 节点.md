## 新节点信息

|    **ip**     | **hostname** |   **OS**   | **kernel version** | **role** |
| :-----------: | :----------: | :--------: | :----------------: | :------: |
| 192.168.56.15 |    node5     | CentOS 7.4 |     4.20.13-1      |   etcd   |

## 添加 etcd 节点

**注意：** 同时只能添加一个 etcd 节点。

- 编辑原有主机清单文件，在 `[all]` 节点组中添加新节点信息
  ```diff
  [all]
  ...
  + node5 ansible_host=192.168.56.15 ansible_user=vagrant ansible_ssh_pass=vagrant
  ... 
  ```

- 在 `[new-etcd]` 节点组中添加新节点信息
  ```diff
  ...
  [new-etcd]
  + node5
  ...
  ```

- 执行 etcd 节点添加操作
  - 基本配置执行
    ```
    ansible-playbook -i example/hosts.m-master.ip.ini 83-add-etcd.yml
    ```

  - **注意：** 如果安装集群时使用高级配置，则使用该命令
    ```
    ansible-playbook -i example/hosts.m-master.ip.ini -e @example/variables.yaml 83-add-etcd.yml
    ```

    > 若 `example/hosts.m-master.ip.ini` 文件中与 `example/variables.yaml` 参数冲突时， `example/variables.yaml` 文件中的变量值优先级最高。

- 添加完成后，将`[new-etcd]` 节点组中新节点信息移动至 `[etcd]` 节点组
  ```diff
  ...
  [etcd]
  node1
  node2
  node3
  + node5
  ...
  [new-etcd]
  - node5
  ...
  ```