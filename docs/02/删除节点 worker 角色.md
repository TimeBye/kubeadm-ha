## 删除节点 worker 角色

- **此操作仅为移除 worker 角色操作，并不会完全将该节点移出集群**；若需移出集群，请看本文 `删除节点` 操作

- 在 `[del-worker]` 节点组中添加需删除角色的节点信息
  ```diff
  ...
  [del-worker]
  + node7
  ...
  ```

- 执行 worker 角色删除操作
  - 基本配置执行
    ```
    ansible-playbook -i example/hosts.m-master.ip.ini 84-remove-worker.yml
    ```

  - **注意：** 如果安装集群时使用高级配置，则使用该命令
    ```
    ansible-playbook -i example/hosts.m-master.ip.ini -e @example/variables.yaml 84-remove-worker.yml
    ```

    > 若 `example/hosts.m-master.ip.ini` 文件中与 `example/variables.yaml` 参数冲突时， `example/variables.yaml` 文件中的变量值优先级最高。

- 删除完成后，更新 `[del-worker]` 节点组以及 `[kube-worker]` 节点组
  ```diff
  ...
  [kube-worker]
  node1
  node2
  node3
  node4
  - node7
  ...
  [del-worker]
  - node7
  ...
  ```