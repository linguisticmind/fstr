# fstr

There are times when a shell script needs to allow the user to set custom string values that may include variable content. `fstr` makes use of named placeholders that can be included in a string and substituted with computed values at a later point in the script.

Video tutorial:

[![Mindful Technology - [Bash scripting] fstr: like printf but with named placeholders and more](https://img.youtube.com/vi/Wxe49-YxBYI/0.jpg)](https://www.youtube.com/watch?v=Wxe49-YxBYI)

<a href='https://ko-fi.com/linguisticmind'><img src='https://github.com/linguisticmind/linguisticmind/raw/master/res/kofi/kofi_donate_1.svg' alt='Support me on Ko-fi' height='48'></a>

## Changelog

<table>
    <tr>
        <th>Version</th>
        <th>Date</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>
            <a href='https://github.com/linguisticmind/fstr/releases/tag/v0.1.1'>0.1.1</a>
        </td>
        <td>
            2025-04-06
        </td>
        <td>
            <p>
                Substitute <code>&lt;override&gt;</code> only when command line arguments define <code>&lt;name&gt;</code> and its <code>&lt;replacement&gt;</code>.
            </p>
        </td>
    </tr>
    <tr>
        <td>
            <a href='https://github.com/linguisticmind/fstr/releases/tag/v0.1.0'>0.1.0</a>
        </td>
        <td>
            2025-04-06
        </td>
        <td>
            <p>
                Initial release.
            </p>
        </td>
    </tr>
</table>

[Read more](CHANGELOG.md)

## Dependencies

### Essential

_Essential_ dependencies come preinstalled on Debian Linux. Debian users may safely skip the _essential_ dependencies section. Users of other systems have to make sure that these are installed.

<details>
<summary>Click to view</summary>

<p>
    <table>
        <tr>
            <th>Name</th>
            <th>Notes</th>
        </tr>
        <tr>
            <td><b>Bash</b></td>
            <td>
                <p>Developed and tested on version 5.2.15. May work with other versions, but the specified one is recommended.</p>
                <p>Homepage: <a href='https://www.gnu.org/software/bash/'>https://www.gnu.org/software/bash/</a></p>
            </td>
        </tr>
        <tr>
            <td><b>GNU&nbsp;coreutils</b></td>
            <td>
                <p>Homepage: <a href='https://www.gnu.org/software/coreutils/'>https://www.gnu.org/software/coreutils/</a></p>
            </td>
        </tr>
        <tr>
            <td><b>GNU&nbsp;sed</b></td>
            <td>
                <p>Homepage: <a href='https://www.gnu.org/software/sed/'>https://www.gnu.org/software/sed/</a></p>
            </td>
        </tr>
    </table>
</p>
  
</details>

### Required

_Required_ dependencies must be installed in order for <code>fstr</code> to work.

<table>
    <tr>
        <th>Name</th>
        <th>Installation</th>
        <th>Notes</th>
    </tr>
    <tr>
        <td><b>Lua</b></td>
        <td><code>sudo&nbsp;apt&nbsp;install&nbsp;lua5.4</code></td>
        <td>
            <p>Developed and tested on version 5.4. May work with other versions, but the specified one is recommended.</p>
            <p>Lua's executable may be called <code>lua5.4</code> or <code>lua</code>. The names are checked for in this order.</p>
            <p>Homepage: <a href='https://www.lua.org/'>https://www.lua.org/</a></p>
        </td>
    </tr>
</table>

## Installation and upgrading

1. Clone this repository to a directory of your choice (for example, `~/local/src`):

    ```bash
    mkdir -pv ~/local/src
    cd ~/local/src
    git clone https://github.com/linguisticmind/fstr.git
    ```

2. Symlink the [shell wrapper](fstr) to a directory on your `PATH` (for example, `~/local/bin`):

    ```bash
    cd fstr
    ln -srv fstr ~/local/bin
    ```

    <details>
    <summary><b>How do I add a directory to <code>PATH</code>?</b></summary>

    1. Open your `~/.bashrc` file in a text editor and add the following line to end of the file:

        ```bash
        export PATH="$HOME/local/bin:$PATH"
        ```

    2. Restart your terminal session.

    </details>

3. Symlink the [man page](man/man1/fstr.1) to a directory on your `MANPATH` (for example, `~/local/share/man`):

    ```bash
    cd ~/local/src/fstr
    ln -srv man/man1/fstr.1 ~/local/share/man/man1
    ```

    Note: The `man` directory must contain subdirectories for different manual sections (`man1`, `man2` etc.).

    <details>
    <summary><b>How do I add a directory to <code>MANPATH</code>?</b></summary>

    1. Open your `~/.bashrc` file in a text editor and add the following line to end of the file:
    
        ```bash
        export MANPATH="$HOME/local/share/man:$MANPATH"
        ```
    
    2. Restart your terminal session.

    </details>

4. To upgrade to the most recent version of `fstr`, run `git pull` in the cloned repository:

    ```bash
    cd ~/local/src/fstr
    git pull
    ```

## Manual

```plain
FSTR(1)                     General Commands Manual                    FSTR(1)

NAME
       fstr - substitute placeholders in strings

SYNOPSIS
       fstr <str> [<name> <replacement> ...]

DESCRIPTION
       There are times when a shell script needs to allow the user to set cus‐
       tom string values that may include variable content. fstr makes use  of
       named  placeholders  that  can  be included in a string and substituted
       with computed values at a later point in the script.

       <str>  A string with placeholders.

              The placeholder format is:

              (1)    %<name>

                     or

              (2)    %{<name>:-<fallback>:+<override>}

                     :-<fallback> and :+<override> are optional and may go  in
                     any order.

              <name>  is a placeholder name to match a <name> defined via com‐
              mand line arguments. It may consist of one or more  alphanumeric
              characters and underscores.

              <fallback>  and  <override>  are  also strings with placeholders
              just like <str>.

              <fallback> is substituted if command line arguments do  not  de‐
              fine <name> and its <replacement>.

              <override>  is substituted instead of <replacement> allowing to,
              for instance, insert extra characters next to <replacement>.

              In strings with placeholders  (<str>,  <fallback>,  <override>),
              '\',  '%', '{', ':', and '}' are special characters. They can be
              escaped with backslashes ('\') to represent their  literal  val‐
              ues.

       <name> A  placeholder  name.  May  consist  of one or more alphanumeric
              characters and underscores.

       <replacement>
              A placeholder replacement. This is a  literal  string  —  unlike
              <str>,  <fallback>, and <override> which are strings with place‐
              holders.

FILES
       fstr.lua
              The main Lua script.

       fstr   A shell wrapper for 'fstr.lua'.

       tools/generate-bash-function
              Outputs a Bash function based on 'fstr.lua'.

AUTHOR
       Alex Rogers <https://github.com/linguisticmind>

HOMEPAGE
       <https://github.com/linguisticmind/fstr>

COPYRIGHT
       Copyright © 2025 Alex Rogers. License GPLv3+:  GNU  GPL  version  3  or
       later <https://gnu.org/licenses/gpl.html>.

       This  is  free  software:  you  are free to change and redistribute it.
       There is NO WARRANTY, to the extent permitted by law.

FSTR 0.1.1                        2025-04-06                           FSTR(1)
```

## License

[GNU General Public License v3.0](LICENSE)
