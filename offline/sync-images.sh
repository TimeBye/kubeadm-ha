#!/bin/bash
REGISTRY_PATH="/var/lib/registry"
REGISTRY_DOMAIN="${1}"
REGISTRY_USER="${2}"
REGISTRY_PWD="${3}"

# 切换到 registry 存储主目录下
cd ${REGISTRY_PATH}

gen_skopeo_dir() {
   # 定义 registry 存储的 blob 目录 和 repositories 目录，方便后面使用
    BLOB_DIR="docker/registry/v2/blobs/sha256"
    REPO_DIR="docker/registry/v2/repositories"
    # 定义生成 skopeo 目录
    SKOPEO_DIR="docker/skopeo"
    # 通过 find 出 current 文件夹可以得到所有带 tag 的镜像，因为一个 tag 对应一个 current 目录
    for image in $(find ${REPO_DIR} -type d -name "current"); do
        # 根据镜像的 tag 提取镜像的名字
        name=$(echo ${image} | awk -F '/' '{print $5"/"$6":"$9}')
        link=$(cat ${image}/link | sed 's/sha256://')
        mfs="${BLOB_DIR}/${link:0:2}/${link}/data"
        # 创建镜像的硬链接需要的目录
        mkdir -p "${SKOPEO_DIR}/${name}"
        # 硬链接镜像的 manifests 文件到目录的 manifest 文件
        ln -f ${mfs} ${SKOPEO_DIR}/${name}/manifest.json
        # 使用正则匹配出所有的 sha256 值，然后排序去重
        layers=$(grep -Eo "\b[a-f0-9]{64}\b" ${mfs} | sort -n | uniq)
        for layer in ${layers}; do
            # 硬链接 registry 存储目录里的镜像 layer 和 images config 到镜像的 dir 目录
            ln -f ${BLOB_DIR}/${layer:0:2}/${layer}/data ${SKOPEO_DIR}/${name}/${layer}
        done
    done
}

sync_image() {
    # 使用 skopeo sync 将 dir 格式的镜像同步到 harbor
    for project in $(ls ${SKOPEO_DIR}); do
        skopeo sync --insecure-policy --src-tls-verify=false --dest-tls-verify=false \
        --dest-creds ${REGISTRY_USER}:${REGISTRY_PWD} \
        --src dir --dest docker ${SKOPEO_DIR}/${project} ${REGISTRY_DOMAIN}
    done
}

gen_skopeo_dir
sync_image