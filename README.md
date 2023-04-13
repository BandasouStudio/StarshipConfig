## My personal configurations for [Starship](https://starship.rs)

Just run `bash generate.sh > ~/.config/starship.toml`.

Or for zinit:
```
zinit ice from'gh' as'program' \
	atclone'bash generate.sh > ~/.config/starship.toml' \
	atpull'%atclone'
zinit light Namorzyny/StarshipConfig
```
