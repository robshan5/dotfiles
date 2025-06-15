{ inputs, pkgs, ... }:

{
    programs.starship.enableZshIntegration = true;
    programs.zsh = {
        enable = true;
        history = {
            size = 50000;
            ignoreDups = true;
        };
        syntaxHighlighting.enable = true;
        prezto.caseSensitive = false;
        enableCompletion = true;
        shellAliases = {
            cp = "cp -i";
            c = "clear";
            mv = "mv -i";
            mkdir = "mkdir -p";
            ps = "ps auxf";
            ping = "ping -c 10";
            less = "less -R";
            multitail = "multitail --no-repeat -c";
            deepseek = "ollama run deepseek-r1:7b";
            v = "nvim";
            sv = "sudo v";
            sd = "shutdown -h now";
            rb = "reboot";
            bd = "cd \"$OLDPWD\"";
            rmd = "rm -rfv";
            #directory listings
            la = "ls -a"; #list hidden
            ls = "ls -xF --color=always"; #list with colours
            ld = "ls -d"; #list only directories
            lf = "ls -p | grep -v /"; #list only files
            lls = "ls -lah"; #list with info
            lt = "ls -lth"; #sort by time
            lss = "ls -lSh"; #sort by file size
            lc = "ls -c"; #sort by change time
            lu = "ls -u"; #sort by access time
            lr = "ls -R"; #recursively list
            #directory
            home = "cd ~";
            ".." = "cd ..";
            "..." = "cd ../..";
            "...." = "cd ../../..";
            "....." = "cd ../../../..";
            #chmod commands
            mx = "chmod a+x";
            "000" = "chmod -R 000";
            "644" = "chmod -R 644";
            "666" = "chmod -R 666";
            "755" = "chmod -R 755";
            "777" = "chmod -R 777";
            #grep history
            h = "history | grep";
            #seach running processes
            p = "ps aux | grep";
            #find in current directory
            f = "find . | grep";
            #count files in directory (recursive)
            countfiles = "for t in fileslinks directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null";
            #check type
            checkcommand = "type -t";
            #open ports
            openports = "netstat -nape --inet";
            #diskspace used
            diskspace = "du -S | sort -n -r | more";
            folders = "du -h --max-depth=1";
            foldersort = "find . -maxdepth 1 -tupe d -print0 | xargs -0 du -sk | sort -rn";
            tree = "tree -CAhF --dirsfirst";
            treed = "tree -CAFd";
            mountedinfo = "df -hT";

            #Archives
            mktar = "tar -cvf";
            mkbz2 = "tar -cvjf";
            mkgz = "tar -cvzf";
            untar = "tar -xvf";
            unbz2 = "tar -xvjf";
            ungz = "tar -xvzf";

            #logs in /var/log
            logs = "sudo find /var/log -type f =exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"; #don't ask
            #SHA1
            sha1 = "openssl sha1";
            clickpaste = "sleep 3; xdptpp; type \"$(xclip -o -selection clipboard)\"";

            #kitty ssh
            kssh = "kitty +kitten ssh";

        };
        initContent = ''
      #disable the beep
      setopt NO_BEEP
      #case insensitive
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      # Enable completion previews
      autoload -Uz compinit
      compinit

      # Enable preview of completions
      zstyle ':completion:*' menu select=2
      zstyle ':completion:*' list-colors '=(#b)fg=black, bg=yellow'


      extract(){
        for archive in "$@"; do
          if [ -f "@archive" ]; then
            case $archive in
              *.tar.bz2) tar xvjf $archive ;;
              *.tar.gz) tar xvzf $archive ;;
              *.bz2) bunzip2 $archive ;;
              *.rar) rar x $archive ;;
              *.gz) gunzip $archive ;;
              *.tar) tar xvf $archive ;;
              *.tbz2) tar xvzf $archive ;;
              *.tgz) tar xvzf $archive ;;
              *.zip) unzip $archive ;;
              *.Z) uncompress $archive ;;
              *.7z) 7z x $archive ;;
              *) echo "don't know how to extract '$archive'..." ;;
            esac
          else
            echo "'$archive' is not a valid file"
          fi
        done
      }
      ftext() {
        # -i case-insensitive
        # -I ignore binary files
        # -H causes filename to be printed
        # -r recursive search
        # -n causes line number to be printed
        # optional: -F treat search term as a literal, not a regular expression
        # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
        grep -iIHrn --color=always "$1" . | less -r
      }

      # Copy and go to the directory
      cpg() {
        if [ -d "$2" ]; then
          cp -r "$1" "$2" && cd "$2"
        else
          cp -r "$1" "$2"
        fi
      }

      # Move and go to the directory
      mvg() {
        if [ -d "$2" ]; then
          mv "$1" "$2" && cd "$2"
        else
          mv "$1" "$2"
        fi
      }

      # Create and go to the directory
      mkdirg() {
        mkdir -p "$1"
        cd "$1"
      }

      # Goes up a specified number of directories  (i.e. up 4)
      up() {
        local d=""
        limit=$1
        for ((i = 1; i <= limit; i++)); do
          d=$d/..
        done
        d=$(echo $d | sed 's/^\///')
        if [ -z "$d" ]; then
          d=..
        fi
        cd $d
      }

      # Automatically do an ls after each cd, z, or zoxide
      cd() {
        if [ -n "$1" ]; then
          builtin cd "$@" && ls
        else
          builtin cd ~ && ls
        fi
      }

      eval "$(zoxide init zsh)"
      z() {
        if [ -n "$1" ]; then
          __zoxide_z "$@" && ls
        else
          __zoxide_z ~ && ls
        fi
      }

      headphones(){
        bluetoothctl power on &&
        bluetoothctl scan on &&
        bluetoothctl connect 38:18:4C:17:DA:8A
      }


      # Returns the last 2 fields of the working directory
      pwdtail() {
        pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
      }

      # Show the current version of the operating system
      ver() {
        local dtype
        dtype=$(distribution)

        case $dtype in
          "redhat")
            if [ -s /etc/redhat-release ]; then
              cat /etc/redhat-release
            else
              cat /etc/issue
            fi
            uname -a
            ;;
          "suse")
            cat /etc/SuSE-release
            ;;
          "debian")
            lsb_release -a
            ;;
          "gentoo")
            cat /etc/gentoo-release
            ;;
          "arch")
            cat /etc/os-release
            ;;
          "slackware")
            cat /etc/slackware-version
            ;;
          *)
            if [ -s /etc/issue ]; then
              cat /etc/issue
            else
              echo "Error: Unknown distribution"
              exit 1
            fi
            ;;
        esac
      }

      # View Apache logs
      apachelog() {
        if [ -f /etc/httpd/conf/httpd.conf ]; then
          cd /var/log/httpd && ls -xAh && multitail --no-repeat -c -s 2 /var/log/httpd/*_log
        else
          cd /var/log/apache2 && ls -xAh && multitail --no-repeat -c -s 2 /var/log/apache2/*.log
        fi
      }

      # Edit the Apache configuration
      apacheconfig() {
        if [ -f /etc/httpd/conf/httpd.conf ]; then
          sedit /etc/httpd/conf/httpd.conf
        elif [ -f /etc/apache2/apache2.conf ]; then
          sedit /etc/apache2/apache2.conf
        else
          echo "Error: Apache config file could not be found."
          echo "Searching for possible locations:"
          sudo updatedb && locate httpd.conf && locate apache2.conf
        fi
      }

      # Edit the PHP configuration file
      phpconfig() {
        if [ -f /etc/php.ini ]; then
          sedit /etc/php.ini
        elif [ -f /etc/php/php.ini ]; then
          sedit /etc/php/php.ini
        elif [ -f /etc/php5/php.ini ]; then
          sedit /etc/php5/php.ini
        elif [ -f /usr/bin/php5/bin/php.ini ]; then
          sedit /usr/bin/php5/bin/php.ini
        elif [ -f /etc/php5/apache2/php.ini ]; then
          sedit /etc/php5/apache2/php.ini
        else
          echo "Error: php.ini file could not be found."
          echo "Searching for possible locations:"
          sudo updatedb && locate php.ini
        fi
      }

      # Edit the MySQL configuration file
      mysqlconfig() {
        if [ -f /etc/my.cnf ]; then
          sedit /etc/my.cnf
        elif [ -f /etc/mysql/my.cnf ]; then
          sedit /etc/mysql/my.cnf
        elif [ -f /usr/local/etc/my.cnf ]; then
          sedit /usr/local/etc/my.cnf
        elif [ -f /usr/bin/mysql/my.cnf ]; then
          sedit /usr/bin/mysql/my.cnf
        elif [ -f ~/my.cnf ]; then
          sedit ~/my.cnf
        elif [ -f ~/.my.cnf ]; then
          sedit ~/.my.cnf
        else
          echo "Error: my.cnf file could not be found."
          echo "Searching for possible locations:"
          sudo updatedb && locate my.cnf
        fi
      }


      # Trim leading and trailing spaces (for scripts)
      #this broke with the initExtra so I deleted it, check the old .bashrc for this function

      # GitHub Titus Additions

      gcom() {
        git add .
        git commit -m "$1"
      }
      lazyg() {
        git add .
        git commit -m "$1"
        git push
      }

      function hb {
          if [ $# -eq 0 ]; then
              echo "No file path specified."
              return
          elif [ ! -f "$1" ]; then
              echo "File path does not exist."
              return
          fi

          uri="http://bin.christitus.com/documents"
          response=$(curl -s -X POST -d "$(cat "$1")" "$uri")
          if [ $? -eq 0 ]; then
              hasteKey=$(echo $response | jq -r '.key')
              echo "http://bin.christitus.com/$hasteKey"
          else
              echo "Failed to upload the document."
          fi
      }

      #######################################################
      # Set the ultimate amazing command prompt
      #######################################################

      # alias hug="hugo server -F --bindkey=10.0.0.97 --baseURL=http://10.0.0.97"

      # # Check if the shell is interactive
      # if [[ $- == *i* ]]; then
      #     # Bind Ctrl+f to insert 'zi' followed by a newline
      #     bindkey '"\C-f":"zi\n"'
      # fi

      # export PATH=$PATH:"$HOME/.local/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:/.local/share/flatpak/exports/bin"

      # Install Starship - curl -sS https://starship.rs/install.sh | sh
      # eval "$(starship init zsh)"
        '';
    };
}
