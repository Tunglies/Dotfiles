function cpv
    if test (count $argv) -lt 2
        echo "Usage: cpv source... destination"
        return 1
    end

    set -l sources $argv[1..-2]
    set -l dest $argv[-1]

    for src in $sources
        rsync -ah --progress --info=progress2 $src $dest
    end
end
