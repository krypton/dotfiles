How to install
--------------
1. Prepare your environment. For more details please refer to [overmind's repo](https://github.com/DarthSim/overmind).

    ```
    # ~/.overmind.env
    OVERMIND_SOCKET=/path/to/.overmind.sock
    OVERMIND_PROCFILE=/path/to/Procfile.dev
    ```
2. Clone this repository in oh-my-zsh's plugins directory:

    ```zsh
    git clone https://github.com/crawlingcity/zsh-overmind-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-overmind-autocomplete
    ```

3. Activate the plugin in `~/.zshrc`:

    ```zsh
    plugins=( [plugins...] zsh-overmind-autocomplete)
    ```

4. Restart zsh (such as by opening a new instance of your terminal emulator).

# personal alias
`alias om='noglob overmind'`

List of jobs:
job
job-2

This allows to use it like this without having to use quotes:
`om r job*`
