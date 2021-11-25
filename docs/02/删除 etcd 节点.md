## 删除 etcd 节点

- 在 `[del-etcd]` 节点组中添加需删除节点信息
  ```diff
  ...
  [del-etcd]
  + node1
  ...
  ```

- 执行 etcd 节点删除操作
  - 基本配置执行
    ```
    ansible-playbook -i example/hosts.m-master.ip.ini 86-remove-etcd.yml
    ```

  - **注意：** 如果安装集群时使用高级配置，则使用该命
    ```
    ansible-playbook -i example/hosts.m-master.ip.ini -e @example/variables.yaml 86-remove-etcd.yml
    ```

    > 若 `example/hosts.m-master.ip.ini` 文件中与 `example/variables.yaml` 参数冲突时， `example/variables.yaml` 文件中的变量值优先级最高。

- 删除完成后，更新 `[del-etcd]` 节点组以及 `[etcd]` 节点组
  ```diff
  ...
  [etcd]
  - node1
  node2
  node3
  node5
  ...
  [del-etcd]
  - node1
  ...
  ```
