# Palette

[![IRC][IRC Badge]][IRC]

###### [Usage](#usage) | [Documentation](#commands) | [Contributing](CONTRIBUTING)

> Color preview in [Kakoune].

## Installation

### [Pathogen]

``` kak
pathogen-infect /home/user/repositories/github.com/alexherbo2/palette.kak
```

## Usage

``` kak
hook global WinCreate .* %{
  palette-enable
}
```

## Commands

- `palette-enable`: Enable color preview
- `palette-disable`: Disable color preview

[Kakoune]: https://kakoune.org
[IRC]: https://webchat.freenode.net/#kakoune
[IRC Badge]: https://img.shields.io/badge/IRC-%23kakoune-blue.svg
[Pathogen]: https://github.com/alexherbo2/pathogen.kak
