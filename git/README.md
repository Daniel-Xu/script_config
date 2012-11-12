##  git config

+   global config
   
    `mv gitconfig ~/.gitconfig`

+   git change username

    *when you changed your account username, the following is what you should
    do*

    `git remote -v`

    >   view existing remote
   
    `git remote set-url <remote_name> <remote_url>`

    >   remote_name could be found through `git remote`
    >   remote_url can be found in github repo

    modify `.git/config`

    >	url = ssh://git@github.com/user_name/repo_name
