## 新节点信息

|    **ip**     | **hostname** |   **OS**   | **kernel version** | **role** |
| :-----------: | :----------: | :--------: | :----------------: | :------: |
| 192.168.56.18 |    node8     | CentOS 7.4 |     4.20.13-1      |  lb      |
| 192.168.56.19 |    node9     | CentOS 7.4 |     4.20.13-1      |  lb      |

## 增加或删除 lb 节点

- 添加或删除 lb 节点都按下面方式进行，维护好节点组信息即可

- 在 `[lb]` 节点组中添加或删除节点信息
  ```diff
  ...
  [lb]
  + node8
  + node9
  ...
  ```

- 执行 lb 节点添加或删除操作
  - 基本配置执行
    ```
    ansible-playbook -i example/hosts.m-master.ip.ini 04-load-balancer.yml
    ```

  - **注意：** 如果安装集群时使用高级配置，则使用该命令
    ```
    ansible-playbook -i example/hosts.m-master.ip.ini -e @example/variables.yaml 04-load-balancer.yml
    ```

    > 若 `example/hosts.m-master.ip.ini` 文件中与 `example/variables.yaml` 参数冲突时， `example/variables.yaml` 文件中的变量值优先级最高。