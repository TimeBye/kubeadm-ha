## 删除节点 master 角色

- 删除节点 master 角色，则该节点将转换为 worker 角色节点

- 在 `[del-master]` 节点组中添加需删除节点信息
  ```diff
  ...
  [del-master]
  + node6
  ...
  ```

- 执行 master 节点删除操作
  - 基本配置执行
    ```
    ansible-playbook -i example/hosts.m-master.ip.ini 85-remove-master.yml
    ```

  - **注意：** 如果安装集群时使用高级配置，则使用该命令
    ```
    ansible-playbook -i example/hosts.m-master.ip.ini -e @example/variables.yaml 85-remove-master.yml
    ```

    > 若 `example/hosts.m-master.ip.ini` 文件中与 `example/variables.yaml` 参数冲突时， `example/variables.yaml` 文件中的变量值优先级最高。

- 删除完成后，更新 `[del-master]` 、`[kube-master]` 节点组以及 `[kube-worker]` 节点组
  ```diff
  ...
  [kube-master]
  node1
  node2
  node3
  - node6
  ...
  [kube-worker]
  node1
  node2
  node3
  + node6
  ...
  [del-master]
  - node6
  ...
  ```