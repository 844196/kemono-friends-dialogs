#!/bin/bash

cat *.md \
    | grep '\|' \
    | grep -v -e '^[-\.]' -e '人物.*台詞' \
    | ruby -ne 'puts $_.split("|").map(&:strip).join("\t")' \
    | ruby -ne '$_.split("\t").tap {|l| puts l.join("\t") unless l[1] =~ /[\)\(]/ }' \
    | ruby -ne '$_.split("\t").tap {|l| ss=l[0].split("、"); ss.each {|s| puts "speaker:#{s}\tquote:#{l[1]}" } }' \
    | cat <(echo "filetype:polyaness_dict") - \
    > kemono-friends-dialogs.ltsv
