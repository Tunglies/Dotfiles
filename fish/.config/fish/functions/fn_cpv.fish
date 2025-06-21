function cpv
  if test (count $argv) -lt 2
    echo "Usage: cpv source... destination"
    return 1
  end

  set -l sources $argv[1..-2]
  set -l dest $argv[-1]

  for src in $sources
    echo "Copying $src to $dest ..."

    # 兼容 macOS 计算字节数
    set size (du -sk $src | awk '{print $1 * 1024}')

    # 确保目标目录存在
    if not test -d $dest
      mkdir -p $dest
    end

    # 使用 tar + pv + tar 复制
    tar -cf - -C (dirname $src) (basename $src) \
      | pv -s $size \
      | tar -xf - -C $dest
  end
end
