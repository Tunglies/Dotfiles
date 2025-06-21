function rmv
    set -l dry_run 0
    set -l force 0
    set -l paths

    # 参数解析
    for arg in $argv
        switch $arg
            case '--dry-run'
                set dry_run 1
            case '--yes'
                set force 1
            case 'help' '--help' '-h'
                echo "Usage: rmv [--dry-run] [--yes] file_or_dir..."
                return 0
            case '-r'
                # 忽略 -r，find 递归本身支持
            case '*'
                set paths $paths $arg
        end
    end

    if test (count $paths) -eq 0
        echo "rmv: missing operand"
        echo "Usage: rmv [--dry-run] [--yes] file_or_dir..."
        return 1
    end

    set -l all_items_file (mktemp)
    set -l total 0

    # 逐个路径处理
    for p in $paths
        if not test -e $p
            echo "Warning: '$p' does not exist, skipping."
            continue
        end

        # 查找该路径所有文件/目录
        set -l tmpfile (mktemp)
        find $p > $tmpfile
        set -l count (cat $tmpfile | wc -l | tr -d ' ')

        if test $count -eq 0
            echo "Nothing to delete in '$p'."
            rm $tmpfile
            continue
        end

        echo "In '$p', the following $count items will be deleted:"
        cat $tmpfile | head -n 5
        if test $count -gt 5
            set rest (math $count - 5)
            echo "... and $rest more."
        end
        echo

        cat $tmpfile >> $all_items_file
        set total (math $total + $count)
        rm $tmpfile
    end

    if test $total -eq 0
        echo "Nothing to delete overall."
        rm $all_items_file
        return 0
    end

    if test $dry_run -eq 1
        echo "[Dry run] Nothing deleted."
        rm $all_items_file
        return 0
    end

    if test $force -ne 1
        read -l -P "Proceed with deletion of $total items? (y/N) " confirm
        if test "$confirm" != "y"
            echo "Aborted."
            rm $all_items_file
            return 0
        end
    end

    echo "Deleting $total items..."

    cat $all_items_file | pv -l -s $total | while read line
        if test -n "$line"
            rm -rf "$line"
        end
    end

    rm $all_items_file
end
