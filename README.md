# dci-doc

## convert foo.rst into foo.md

install pandoc

    yum install pandoc
    
run command

    pandoc foo.rst -f rst --atx-headers -t markdown_github+grid_tables -o foo.md