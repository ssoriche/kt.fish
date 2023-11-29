function kt
    set file $argv
    if test -z "$file"
        for dir in ~/.kube/configs ~/.ssh/kubeconfigs
            if test ! -d "$dir"
                continue
            end

            for cand in (ls "$dir")
                if test -n "$KUBECONFIG" && test "$KUBECONFIG" = "$dir/$cand"
                    echo "* $cand"
                else
                    echo "  $cand"
                end
            end
        end
        return
    end

    if test -f "$file"
        set -gx KUBECONFIG "$file"
        return
    end

    for dir in ~/.kube/configs ~/.ssh/kubeconfigs
        if test -f "$dir/$file"
            set -gx KUBECONFIG "$dir/$file"
            return
        end
    end
    echo "Invalid KUBECONFIG: cannot file '$file'" >&2
end

