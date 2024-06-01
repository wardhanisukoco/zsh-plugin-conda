# zsh-plugin-conda

`zsh-plugin-conda` is a zsh plugin that automatically loads the conda.


## Installation
### To avoid conflict with another python version manager ex. pyenv
by default is not autoload base conda virtual environment, you can set `CONDA_AUTO_ACTIVATE_BASE` to true in `.zprofile` to make it autoload.

```
CONDA_AUTO_ACTIVATE_BASE=true
```

### As an [Oh My ZSH!](https://github.com/robbyrussell/oh-my-zsh) custom plugin
Clone `zsh-plugin-conda` into your custom plugins repo.

```
git clone https://github.com/wardhanisukoco/zsh-plugin-conda ~/.oh-my-zsh/custom/plugins/conda
```

Then load as a plugin in your `.zshrc`

```
plugins+=(conda)
```
## Thanks
[KellieOwczarczak](https://github.com/KellieOwczarczak)
